# Lexical Specification — Minimal Julia Subset

This document maps every **terminal symbol** in the CFG to its
corresponding **regular expression** (or literal pattern), as
required by Phase 1, Task 3.

---

## 1. Keywords

| Token Name   | Literal / Regex | Description                        |
|--------------|-----------------|------------------------------------|
| `IF`         | `if`            | Conditional keyword                |
| `ELSEIF`     | `elseif`        | Else-if branch keyword             |
| `ELSE`       | `else`          | Else branch keyword                |
| `END`        | `end`           | Block terminator                   |
| `WHILE`      | `while`         | Loop keyword                       |
| `PRINTLN`    | `println`       | Built-in print function            |
| `TRUE`       | `true`          | Boolean literal true               |
| `FALSE`      | `false`         | Boolean literal false              |
| `TYPE_INT`   | `Int64`         | Integer type annotation            |
| `TYPE_FLOAT` | `Float64`       | Floating-point type annotation     |
| `TYPE_BOOL`  | `Bool`          | Boolean type annotation            |
| `TYPE_STR`   | `String`        | String type annotation             |

> Keywords are matched **before** identifiers (longest-match / first-match rule in Lex).

---

## 2. Identifiers

| Token Name   | Regex                           | Description                  |
|--------------|---------------------------------|------------------------------|
| `IDENTIFIER` | `[a-zA-Z_][a-zA-Z0-9_]*`       | Variable / function names    |

An identifier must **not** be a keyword.

---

## 3. Literals

| Token Name   | Regex                                  | Examples            |
|--------------|----------------------------------------|---------------------|
| `INT_LIT`    | `[0-9]+`                               | `0`, `42`, `1000`   |
| `FLOAT_LIT`  | `[0-9]+\.[0-9]+`                       | `3.14`, `0.5`       |
| `STRING_LIT` | `\"[^\"]*\"`                           | `"hello"`, `""`     |

> `BOOL_LIT` is handled by the keywords `true` / `false`.

---

## 4. Operators

| Token Name   | Literal | Description              |
|--------------|---------|--------------------------|
| `PLUS`       | `+`     | Addition                 |
| `MINUS`      | `-`     | Subtraction / unary neg  |
| `STAR`       | `*`     | Multiplication           |
| `SLASH`      | `/`     | Division                 |
| `PERCENT`    | `%`     | Modulo                   |
| `EQ`         | `==`    | Equality comparison      |
| `NEQ`        | `!=`    | Not-equal comparison     |
| `LT`         | `<`     | Less than                |
| `GT`         | `>`     | Greater than             |
| `LEQ`        | `<=`    | Less than or equal       |
| `GEQ`        | `>=`    | Greater than or equal    |
| `AND`        | `&&`    | Logical AND              |
| `OR`         | `\|\|`  | Logical OR               |
| `NOT`        | `!`     | Logical NOT (unary)      |
| `ASSIGN`     | `=`     | Assignment               |

> Multi-character operators (`==`, `!=`, `<=`, `>=`, `&&`, `||`)
> are matched **before** their single-character prefixes via the
> longest-match rule in Lex.

---

## 5. Punctuation / Delimiters

| Token Name      | Literal | Description                  |
|-----------------|---------|------------------------------|
| `LPAREN`        | `(`     | Left parenthesis             |
| `RPAREN`        | `)`     | Right parenthesis            |
| `DOUBLE_COLON`  | `::`    | Type annotation separator    |
| `SEMICOLON`     | `;`     | Statement separator          |
| `NEWLINE`       | `\n`    | Statement terminator         |

---

## 6. Whitespace & Comments

| Pattern                | Action                         |
|------------------------|--------------------------------|
| `[ \t\r]+`             | Skip (ignored whitespace)      |
| `#[^\n]*`              | Skip (single-line comment)     |

> In Julia, `#` introduces a single-line comment.  
> Newlines (`\n`) are **not** skipped — they serve as statement terminators.

---

## 7. Error Handling

Any character that does **not** match the above patterns is reported as a
**lexical error** with its line number and the offending character.

---

*Each regex above directly corresponds to a rule in the Lex source file
(`phase1/lexer.l`).*
