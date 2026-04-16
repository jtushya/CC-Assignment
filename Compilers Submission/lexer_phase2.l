%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "parser.tab.h"

extern int lexical_errors;

static char *dup_text(const char *src) {
    size_t n;
    char *dest;

    if (src == NULL) {
        return NULL;
    }

    n = strlen(src);
    dest = (char *)malloc(n + 1);
    if (dest == NULL) {
        fprintf(stderr, "Out of memory while duplicating lexer text.\n");
        exit(1);
    }

    memcpy(dest, src, n + 1);
    return dest;
}
%}

%option noyywrap yylineno nounput noinput

%%

#[^\n]*                         { }
[ \t\r]+                       { }
\n                              { return TOK_NEWLINE; }
";"                             { return TOK_SEMICOLON; }

"elseif"                        { return TOK_ELSEIF; }
"if"                            { return TOK_IF; }
"else"                          { return TOK_ELSE; }
"end"                           { return TOK_END; }
"while"                         { return TOK_WHILE; }
"println"                       { return TOK_PRINTLN; }
"true"                          { return TOK_TRUE; }
"false"                         { return TOK_FALSE; }

"Int64"                         { return TOK_TYPE_INT; }
"Float64"                       { return TOK_TYPE_FLOAT; }
"Bool"                          { return TOK_TYPE_BOOL; }
"String"                        { return TOK_TYPE_STR; }

[0-9]+\.[0-9]+                  { yylval.str = dup_text(yytext); return TOK_FLOAT_LIT; }
[0-9]+                           { yylval.str = dup_text(yytext); return TOK_INT_LIT; }
\"([^\\\"]|\\.)*\"             { yylval.str = dup_text(yytext); return TOK_STRING_LIT; }
[a-zA-Z_][a-zA-Z0-9_]*          { yylval.str = dup_text(yytext); return TOK_IDENTIFIER; }

"=="                            { return TOK_EQ; }
"!="                            { return TOK_NEQ; }
"<="                            { return TOK_LEQ; }
">="                            { return TOK_GEQ; }
"&&"                            { return TOK_AND; }
"||"                            { return TOK_OR; }
"::"                            { return TOK_DCOLON; }

"+"                             { return TOK_PLUS; }
"-"                             { return TOK_MINUS; }
"*"                             { return TOK_STAR; }
"/"                             { return TOK_SLASH; }
"%"                             { return TOK_PERCENT; }
"<"                             { return TOK_LT; }
">"                             { return TOK_GT; }
"!"                             { return TOK_NOT; }
"="                             { return TOK_ASSIGN; }
"("                             { return TOK_LPAREN; }
")"                             { return TOK_RPAREN; }

.                               {
                                    lexical_errors++;
                                    fprintf(stderr, "Lexical error at line %d: unexpected character '%s'\n", yylineno, yytext);
                                }

%%
