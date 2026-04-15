%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

typedef struct {
    char *false_label;
    char *end_label;
} IfCtx;

typedef struct {
    char *start_label;
    char *end_label;
} LoopCtx;

static FILE *tac_out = NULL;
static int temp_counter = 0;
static int label_counter = 0;

int syntax_errors = 0;
int lexical_errors = 0;

extern int yylineno;
extern FILE *yyin;

int yylex(void);
void yyerror(const char *msg);

#define MAX_NESTING 256
static IfCtx if_stack[MAX_NESTING];
static int if_top = -1;

static LoopCtx loop_stack[MAX_NESTING];
static int loop_top = -1;

static char *dup_str(const char *src) {
    size_t n;
    char *dest;

    if (src == NULL) {
        return NULL;
    }

    n = strlen(src);
    dest = (char *)malloc(n + 1);
    if (dest == NULL) {
        fprintf(stderr, "Out of memory while duplicating string.\n");
        exit(1);
    }

    memcpy(dest, src, n + 1);
    return dest;
}

static char *new_temp(void) {
    char buf[32];

    snprintf(buf, sizeof(buf), "t%d", ++temp_counter);
    return dup_str(buf);
}

static char *new_label(void) {
    char buf[32];

    snprintf(buf, sizeof(buf), "L%d", ++label_counter);
    return dup_str(buf);
}

static void emit(const char *fmt, ...) {
    va_list args;

    va_start(args, fmt);
    vfprintf(stdout, fmt, args);
    fprintf(stdout, "\n");
    va_end(args);

    if (tac_out != NULL) {
        va_start(args, fmt);
        vfprintf(tac_out, fmt, args);
        fprintf(tac_out, "\n");
        va_end(args);
    }
}

static void push_if(char *false_label, char *end_label) {
    if (if_top + 1 >= MAX_NESTING) {
        fprintf(stderr, "Too many nested if statements.\n");
        exit(1);
    }

    if_top++;
    if_stack[if_top].false_label = false_label;
    if_stack[if_top].end_label = end_label;
}

static IfCtx *peek_if(void) {
    if (if_top < 0) {
        fprintf(stderr, "Internal parser error: empty if stack.\n");
        exit(1);
    }

    return &if_stack[if_top];
}

static IfCtx pop_if(void) {
    IfCtx ctx;

    if (if_top < 0) {
        fprintf(stderr, "Internal parser error: pop on empty if stack.\n");
        exit(1);
    }

    ctx = if_stack[if_top];
    if_top--;
    return ctx;
}

static void push_loop(char *start_label, char *end_label) {
    if (loop_top + 1 >= MAX_NESTING) {
        fprintf(stderr, "Too many nested while loops.\n");
        exit(1);
    }

    loop_top++;
    loop_stack[loop_top].start_label = start_label;
    loop_stack[loop_top].end_label = end_label;
}

static LoopCtx *peek_loop(void) {
    if (loop_top < 0) {
        fprintf(stderr, "Internal parser error: empty loop stack.\n");
        exit(1);
    }

    return &loop_stack[loop_top];
}

static LoopCtx pop_loop(void) {
    LoopCtx ctx;

    if (loop_top < 0) {
        fprintf(stderr, "Internal parser error: pop on empty loop stack.\n");
        exit(1);
    }

    ctx = loop_stack[loop_top];
    loop_top--;
    return ctx;
}
%}

%union {
    char *str;
}

%token TOK_IF TOK_ELSEIF TOK_ELSE TOK_END TOK_WHILE TOK_PRINTLN TOK_TRUE TOK_FALSE
%token TOK_TYPE_INT TOK_TYPE_FLOAT TOK_TYPE_BOOL TOK_TYPE_STR

%token <str> TOK_INT_LIT TOK_FLOAT_LIT TOK_STRING_LIT TOK_IDENTIFIER

%token TOK_PLUS TOK_MINUS TOK_STAR TOK_SLASH TOK_PERCENT
%token TOK_EQ TOK_NEQ TOK_LT TOK_GT TOK_LEQ TOK_GEQ
%token TOK_AND TOK_OR TOK_NOT
%token TOK_ASSIGN
%token TOK_LPAREN TOK_RPAREN TOK_DCOLON TOK_SEMICOLON TOK_NEWLINE

%type <str> expr log_and_expr not_expr rel_expr rel_op add_expr add_op mul_expr mul_op unary_expr primary

%start program

%%

program
    : opt_eols stmt_list opt_eols
    ;

stmt_list
    : /* empty */
    | stmt_list stmt
    ;

stmt
    : typed_decl stmt_end
    | assignment stmt_end
    | print_stmt stmt_end
    | if_stmt
    | while_stmt
    ;

typed_decl
    : TOK_IDENTIFIER TOK_DCOLON type TOK_ASSIGN expr
      {
          emit("%s = %s", $1, $5);
          free($1);
          free($5);
      }
    ;

type
    : TOK_TYPE_INT
    | TOK_TYPE_FLOAT
    | TOK_TYPE_BOOL
    | TOK_TYPE_STR
    ;

assignment
    : TOK_IDENTIFIER TOK_ASSIGN expr
      {
          emit("%s = %s", $1, $3);
          free($1);
          free($3);
      }
    ;

print_stmt
    : TOK_PRINTLN TOK_LPAREN expr TOK_RPAREN
      {
          emit("print %s", $3);
          free($3);
      }
    ;

if_stmt
    : TOK_IF expr stmt_end
      {
          char *false_label = new_label();
          char *end_label = new_label();

          push_if(false_label, end_label);
          emit("ifFalse %s goto %s", $2, false_label);
          free($2);
      }
      stmt_list if_follow TOK_END stmt_end
      {
          IfCtx ctx = pop_if();

          emit("%s:", ctx.end_label);
          free(ctx.end_label);
          if (ctx.false_label != NULL) {
              free(ctx.false_label);
          }
      }
    ;

if_follow
    : TOK_ELSEIF expr stmt_end
      {
          IfCtx *ctx = peek_if();
          char *next_false = new_label();

          emit("goto %s", ctx->end_label);
          emit("%s:", ctx->false_label);
          free(ctx->false_label);

          ctx->false_label = next_false;
          emit("ifFalse %s goto %s", $2, ctx->false_label);
          free($2);
      }
      stmt_list if_follow
    | TOK_ELSE stmt_end
      {
          IfCtx *ctx = peek_if();

          emit("goto %s", ctx->end_label);
          emit("%s:", ctx->false_label);
          free(ctx->false_label);
          ctx->false_label = NULL;
      }
      stmt_list
    | /* empty */
      {
          IfCtx *ctx = peek_if();

          if (ctx->false_label != NULL) {
              emit("%s:", ctx->false_label);
              free(ctx->false_label);
              ctx->false_label = NULL;
          }
      }
    ;

while_stmt
    : TOK_WHILE
      {
          char *start_label = new_label();
          char *end_label = new_label();

          push_loop(start_label, end_label);
          emit("%s:", start_label);
      }
      expr stmt_end
      {
          LoopCtx *ctx = peek_loop();

          emit("ifFalse %s goto %s", $3, ctx->end_label);
          free($3);
      }
      stmt_list TOK_END stmt_end
      {
          LoopCtx ctx = pop_loop();

          emit("goto %s", ctx.start_label);
          emit("%s:", ctx.end_label);
          free(ctx.start_label);
          free(ctx.end_label);
      }
    ;

stmt_end
    : one_or_more_eols
    ;

one_or_more_eols
    : eol
    | one_or_more_eols eol
    ;

opt_eols
    : /* empty */
    | opt_eols eol
    ;

eol
    : TOK_NEWLINE
    | TOK_SEMICOLON
    ;

expr
    : expr TOK_OR log_and_expr
      {
          char *tmp = new_temp();

          emit("%s = %s || %s", tmp, $1, $3);
          free($1);
          free($3);
          $$ = tmp;
      }
    | log_and_expr
      {
          $$ = $1;
      }
    ;

log_and_expr
    : log_and_expr TOK_AND not_expr
      {
          char *tmp = new_temp();

          emit("%s = %s && %s", tmp, $1, $3);
          free($1);
          free($3);
          $$ = tmp;
      }
    | not_expr
      {
          $$ = $1;
      }
    ;

not_expr
    : TOK_NOT not_expr
      {
          char *tmp = new_temp();

          emit("%s = ! %s", tmp, $2);
          free($2);
          $$ = tmp;
      }
    | rel_expr
      {
          $$ = $1;
      }
    ;

rel_expr
    : add_expr rel_op add_expr
      {
          char *tmp = new_temp();

          emit("%s = %s %s %s", tmp, $1, $2, $3);
          free($1);
          free($2);
          free($3);
          $$ = tmp;
      }
    | add_expr
      {
          $$ = $1;
      }
    ;

rel_op
    : TOK_EQ
      {
          $$ = dup_str("==");
      }
    | TOK_NEQ
      {
          $$ = dup_str("!=");
      }
    | TOK_LT
      {
          $$ = dup_str("<");
      }
    | TOK_GT
      {
          $$ = dup_str(">");
      }
    | TOK_LEQ
      {
          $$ = dup_str("<=");
      }
    | TOK_GEQ
      {
          $$ = dup_str(">=");
      }
    ;

add_expr
    : add_expr add_op mul_expr
      {
          char *tmp = new_temp();

          emit("%s = %s %s %s", tmp, $1, $2, $3);
          free($1);
          free($2);
          free($3);
          $$ = tmp;
      }
    | mul_expr
      {
          $$ = $1;
      }
    ;

add_op
    : TOK_PLUS
      {
          $$ = dup_str("+");
      }
    | TOK_MINUS
      {
          $$ = dup_str("-");
      }
    ;

mul_expr
    : mul_expr mul_op unary_expr
      {
          char *tmp = new_temp();

          emit("%s = %s %s %s", tmp, $1, $2, $3);
          free($1);
          free($2);
          free($3);
          $$ = tmp;
      }
    | unary_expr
      {
          $$ = $1;
      }
    ;

mul_op
    : TOK_STAR
      {
          $$ = dup_str("*");
      }
    | TOK_SLASH
      {
          $$ = dup_str("/");
      }
    | TOK_PERCENT
      {
          $$ = dup_str("%");
      }
    ;

unary_expr
    : TOK_MINUS unary_expr
      {
          char *tmp = new_temp();

          emit("%s = - %s", tmp, $2);
          free($2);
          $$ = tmp;
      }
    | primary
      {
          $$ = $1;
      }
    ;

primary
    : TOK_IDENTIFIER
      {
          $$ = $1;
      }
    | TOK_INT_LIT
      {
          $$ = $1;
      }
    | TOK_FLOAT_LIT
      {
          $$ = $1;
      }
    | TOK_STRING_LIT
      {
          $$ = $1;
      }
    | TOK_TRUE
      {
          $$ = dup_str("true");
      }
    | TOK_FALSE
      {
          $$ = dup_str("false");
      }
    | TOK_LPAREN expr TOK_RPAREN
      {
          $$ = $2;
      }
    ;

%%

void yyerror(const char *msg) {
    syntax_errors++;
    fprintf(stderr, "Syntax error at line %d: %s\n", yylineno, msg);
}

int main(int argc, char **argv) {
    const char *input_path;
    const char *tac_path;
    int parse_status;

    if (argc < 2 || argc > 3) {
        fprintf(stderr, "Usage: %s <input.jl> [output.tac]\n", argv[0]);
        return 1;
    }

    input_path = argv[1];
    tac_path = (argc == 3) ? argv[2] : "intermediate_code.tac";

    yyin = fopen(input_path, "r");
    if (yyin == NULL) {
        perror(input_path);
        return 1;
    }

    tac_out = fopen(tac_path, "w");
    if (tac_out == NULL) {
        perror(tac_path);
        fclose(yyin);
        return 1;
    }

    parse_status = yyparse();

    fclose(tac_out);
    fclose(yyin);

    if (parse_status == 0 && syntax_errors == 0 && lexical_errors == 0) {
        printf("Parsing successful. TAC written to %s\n", tac_path);
        return 0;
    }

    fprintf(stderr, "Parsing failed. Syntax errors: %d, lexical errors: %d\n", syntax_errors, lexical_errors);
    return 1;
}
