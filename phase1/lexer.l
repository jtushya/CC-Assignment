/*
 * lexer.l — Flex lexer for a Minimal Julia Subset
 *
 * CS F365 Compiler Construction — Phase 1, Task 4
 * Language: Julia (minimal subset as defined in CFG.md)
 *
 * Build (Linux / WSL):
 *   flex -o lexer.c lexer.l
 *   gcc -o lexer lexer.c -lfl
 *
 * Usage:
 *   ./lexer < tests/valid_program.jl
 *   ./lexer < tests/error_program.jl
 *
 * Group:
 *   Aryan Kamlesh Agrawal  2023A7PS0085H  (Leader)
 *   Tushya Jain             2023A7PS0150H
 *   Gursidak Singh Bassi    2023A7PS0033H
 *   Jainam Parekh           2023A7PS0137H
 */

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tokens.h"

/* ---- bookkeeping ---- */
int line_num  = 1;          /* current line number                     */
int token_cnt = 0;          /* total tokens recognised                 */
int error_cnt = 0;          /* total lexical errors                    */

/*
 * helper: print one token row
 * Format:  <line>  <token-name>  <lexeme>
 */
static void print_token(const char *name, const char *lexeme) {
    token_cnt++;
    printf("%-6d  %-16s  %s\n", line_num, name, lexeme);
}
%}

/* ---- Flex options ---- */
%option noyywrap
%option yylineno

/* ================================================================
 *  RULES SECTION
 *  Order matters: longer matches come first (flex longest-match),
 *  and keywords appear before the generic IDENTIFIER rule.
 * ================================================================ */
%%

 /* ---------- Single-line comments (Julia uses #) ---------- */
#[^\n]*             { /* skip comment */ }

 /* ---------- Whitespace (spaces, tabs, carriage returns — NOT newlines) ---------- */
[ \t\r]+            { /* skip */ }

 /* ---------- Newline — acts as a statement terminator ---------- */
\n                  { line_num++; print_token("NEWLINE", "\\n"); return TOK_NEWLINE; }

 /* ===================== Keywords ===================== */
 /* Must precede the IDENTIFIER rule so they are matched first. */

"elseif"            { print_token("ELSEIF",   yytext); return TOK_ELSEIF;  }
"if"                { print_token("IF",       yytext); return TOK_IF;      }
"else"              { print_token("ELSE",     yytext); return TOK_ELSE;    }
"end"               { print_token("END",      yytext); return TOK_END;     }
"while"             { print_token("WHILE",    yytext); return TOK_WHILE;   }
"println"           { print_token("PRINTLN",  yytext); return TOK_PRINTLN; }
"true"              { print_token("TRUE",     yytext); return TOK_TRUE;    }
"false"             { print_token("FALSE",    yytext); return TOK_FALSE;   }

 /* ---- Type annotation keywords ---- */
"Int64"             { print_token("TYPE_INT",   yytext); return TOK_TYPE_INT;   }
"Float64"           { print_token("TYPE_FLOAT", yytext); return TOK_TYPE_FLOAT; }
"Bool"              { print_token("TYPE_BOOL",  yytext); return TOK_TYPE_BOOL;  }
"String"            { print_token("TYPE_STR",   yytext); return TOK_TYPE_STR;   }

 /* ===================== Literals ===================== */

 /* Floating-point literal (must come before INT_LIT so "3.14" isn't split) */
[0-9]+\.[0-9]+      { print_token("FLOAT_LIT",  yytext); return TOK_FLOAT_LIT;  }

 /* Integer literal */
[0-9]+               { print_token("INT_LIT",    yytext); return TOK_INT_LIT;    }

 /* String literal (double-quoted, no embedded quotes) */
\"[^\"]*\"           { print_token("STRING_LIT", yytext); return TOK_STRING_LIT; }

 /* ===================== Identifier ===================== */
 /* Matched AFTER all keywords, so keywords are never misidentified */
[a-zA-Z_][a-zA-Z0-9_]*  { print_token("IDENTIFIER", yytext); return TOK_IDENTIFIER; }

 /* ===================== Multi-char operators ===================== */
 /* Longest match first: == before =, != before !, <= before <, etc. */

"=="                { print_token("EQ",    yytext); return TOK_EQ;    }
"!="                { print_token("NEQ",   yytext); return TOK_NEQ;   }
"<="                { print_token("LEQ",   yytext); return TOK_LEQ;   }
">="                { print_token("GEQ",   yytext); return TOK_GEQ;   }
"&&"                { print_token("AND",   yytext); return TOK_AND;   }
"||"                { print_token("OR",    yytext); return TOK_OR;    }
"::"                { print_token("DCOLON",yytext); return TOK_DCOLON;}

 /* ===================== Single-char operators ===================== */
"+"                 { print_token("PLUS",      yytext); return TOK_PLUS;      }
"-"                 { print_token("MINUS",     yytext); return TOK_MINUS;     }
"*"                 { print_token("STAR",      yytext); return TOK_STAR;      }
"/"                 { print_token("SLASH",     yytext); return TOK_SLASH;     }
"%"                 { print_token("PERCENT",   yytext); return TOK_PERCENT;   }
"<"                 { print_token("LT",        yytext); return TOK_LT;       }
">"                 { print_token("GT",        yytext); return TOK_GT;       }
"!"                 { print_token("NOT",       yytext); return TOK_NOT;      }
"="                 { print_token("ASSIGN",    yytext); return TOK_ASSIGN;   }

 /* ===================== Punctuation ===================== */
"("                 { print_token("LPAREN",    yytext); return TOK_LPAREN;    }
")"                 { print_token("RPAREN",    yytext); return TOK_RPAREN;    }
";"                 { print_token("SEMICOLON", yytext); return TOK_SEMICOLON; }

 /* ===================== Lexical error ===================== */
 /* Any character not matched above is an error. */
.                   {
                        error_cnt++;
                        fprintf(stderr,
                            "LEXICAL ERROR at line %d: unexpected character '%s'\n",
                            line_num, yytext);
                    }

%%

/* ================================================================
 *  MAIN — standalone driver
 *  Reads from stdin, prints a token table, and summarises counts.
 * ================================================================ */
int main(int argc, char **argv) {
    /* If a filename was supplied, open it; otherwise read stdin */
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror(argv[1]);
            return 1;
        }
    }

    printf("%-6s  %-16s  %s\n", "LINE", "TOKEN", "LEXEME");
    printf("------  ----------------  ----------------\n");

    /* Keep calling yylex() until EOF */
    while (yylex() != 0)
        ;   /* token printing happens inside each rule */

    printf("------  ----------------  ----------------\n");
    printf("Total tokens : %d\n", token_cnt);
    printf("Lexical errors: %d\n", error_cnt);

    if (yyin && yyin != stdin)
        fclose(yyin);

    return (error_cnt > 0) ? 1 : 0;
}
