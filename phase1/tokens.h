/*
 * tokens.h — Token definitions for the Minimal Julia Lexer
 *
 * CS F365 Compiler Construction — Phase 1
 * Language: Julia (minimal subset)
 *
 * Each #define corresponds to a terminal symbol in the CFG.
 * These numeric codes are returned by the lexer to the caller
 * (and later consumed by the Bison parser in Phase 2).
 *
 * Group:
 *   Aryan Kamlesh Agrawal  2023A7PS0085H  (Leader)
 *   Tushya Jain             2023A7PS0150H
 *   Gursidak Singh Bassi    2023A7PS0033H
 *   Jainam Parekh           2023A7PS0137H
 */

#ifndef TOKENS_H
#define TOKENS_H

/* -------- Keywords -------- */
#define TOK_IF          256
#define TOK_ELSEIF      257
#define TOK_ELSE        258
#define TOK_END         259
#define TOK_WHILE       260
#define TOK_PRINTLN     261
#define TOK_TRUE        262
#define TOK_FALSE       263

/* -------- Type keywords -------- */
#define TOK_TYPE_INT    270
#define TOK_TYPE_FLOAT  271
#define TOK_TYPE_BOOL   272
#define TOK_TYPE_STR    273

/* -------- Literals -------- */
#define TOK_INT_LIT     280
#define TOK_FLOAT_LIT   281
#define TOK_STRING_LIT  282

/* -------- Identifier -------- */
#define TOK_IDENTIFIER  290

/* -------- Arithmetic operators -------- */
#define TOK_PLUS        300
#define TOK_MINUS       301
#define TOK_STAR        302
#define TOK_SLASH       303
#define TOK_PERCENT     304

/* -------- Relational operators -------- */
#define TOK_EQ          310   /* ==  */
#define TOK_NEQ         311   /* !=  */
#define TOK_LT          312   /* <   */
#define TOK_GT          313   /* >   */
#define TOK_LEQ         314   /* <=  */
#define TOK_GEQ         315   /* >=  */

/* -------- Logical operators -------- */
#define TOK_AND         320   /* &&  */
#define TOK_OR          321   /* ||  */
#define TOK_NOT         322   /* !   */

/* -------- Assignment -------- */
#define TOK_ASSIGN      330   /* =   */

/* -------- Punctuation / Delimiters -------- */
#define TOK_LPAREN      340   /* (   */
#define TOK_RPAREN      341   /* )   */
#define TOK_DCOLON      342   /* ::  */
#define TOK_SEMICOLON   343   /* ;   */
#define TOK_NEWLINE     344   /* \n  */

/* -------- Special -------- */
#define TOK_EOF         0     /* end of file */
#define TOK_ERROR       -1    /* lexical error */

#endif /* TOKENS_H */
