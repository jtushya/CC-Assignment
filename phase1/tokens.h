#ifndef TOKENS_H
#define TOKENS_H

/* keywords */
#define TOK_IF          256
#define TOK_ELSEIF      257
#define TOK_ELSE        258
#define TOK_END         259
#define TOK_WHILE       260
#define TOK_PRINTLN     261
#define TOK_TRUE        262
#define TOK_FALSE       263

/* type annotations */
#define TOK_TYPE_INT    270
#define TOK_TYPE_FLOAT  271
#define TOK_TYPE_BOOL   272
#define TOK_TYPE_STR    273

/* literals */
#define TOK_INT_LIT     280
#define TOK_FLOAT_LIT   281
#define TOK_STRING_LIT  282

#define TOK_IDENTIFIER  290

/* arithmetic */
#define TOK_PLUS        300
#define TOK_MINUS       301
#define TOK_STAR        302
#define TOK_SLASH       303
#define TOK_PERCENT     304

/* relational */
#define TOK_EQ          310
#define TOK_NEQ         311
#define TOK_LT          312
#define TOK_GT          313
#define TOK_LEQ         314
#define TOK_GEQ         315

/* logical */
#define TOK_AND         320
#define TOK_OR          321
#define TOK_NOT         322

#define TOK_ASSIGN      330

/* punctuation */
#define TOK_LPAREN      340
#define TOK_RPAREN      341
#define TOK_DCOLON      342
#define TOK_SEMICOLON   343
#define TOK_NEWLINE     344

#define TOK_EOF         0
#define TOK_ERROR       -1

#endif
