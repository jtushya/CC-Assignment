# Context-Free Grammar — Minimal Julia Subset

## Group Details
- **Course:** CS F365 Compiler Construction
- **Chosen Language:** Julia
- **Group Leader:** Aryan Kamlesh Agrawal (2023A7PS0085H)
- **Members:**
  - Tushya Jain (2023A7PS0150H)
  - Gursidak Singh Bassi (2023A7PS0033H)
  - Jainam Parekh (2023A7PS0137H)

---

## Supported Constructs (as required by assignment)

| Construct                     | Julia Syntax Used                  |
|-------------------------------|------------------------------------|
| Variable declaration          | `x::Int64 = 5`  or  `x = 5`       |
| Assignment statement          | `x = expr`                         |
| Arithmetic expressions        | `+  -  *  /  %`                    |
| Relational expressions        | `==  !=  <  >  <=  >=`             |
| Logical expressions           | `&&  \|\|  !`                      |
| Conditional statement         | `if … elseif … else … end`         |
| Loop statement                | `while … end`                      |

---

## Formal CFG

Non-terminals are in **PascalCase**, terminals (tokens) are in **`UPPER_CASE`** or
quoted literal strings.

```
Program         → StmtList

StmtList        → Stmt StmtList
                 | ε

Stmt            → VarDecl
                 | Assignment
                 | IfStmt
                 | WhileStmt
                 | PrintStmt

# ---------- Variable Declaration ----------
# Julia allows optional type annotation with ::
VarDecl         → IDENTIFIER "::" Type "=" Expr NEWLINE
                 | IDENTIFIER "=" Expr NEWLINE

Type            → "Int64"
                 | "Float64"
                 | "Bool"
                 | "String"

# ---------- Assignment ----------
Assignment      → IDENTIFIER "=" Expr NEWLINE

# ---------- Conditional ----------
IfStmt          → "if" Expr NEWLINE StmtList ElseIfList ElseBlock "end" NEWLINE

ElseIfList      → "elseif" Expr NEWLINE StmtList ElseIfList
                 | ε

ElseBlock       → "else" NEWLINE StmtList
                 | ε

# ---------- Loop ----------
WhileStmt       → "while" Expr NEWLINE StmtList "end" NEWLINE

# ---------- Print (handy for testing) ----------
PrintStmt       → "println" "(" Expr ")" NEWLINE

# ====================================================
# Expressions — with PRECEDENCE (lowest → highest)
# ====================================================

# Level 1 — Logical OR  (lowest precedence)
Expr            → Expr "||" LogAndExpr
                 | LogAndExpr

# Level 2 — Logical AND
LogAndExpr      → LogAndExpr "&&" NotExpr
                 | NotExpr

# Level 3 — Logical NOT (unary prefix)
NotExpr         → "!" NotExpr
                 | RelExpr

# Level 4 — Relational / Comparison
RelExpr         → AddExpr RelOp AddExpr
                 | AddExpr

RelOp           → "==" | "!=" | "<" | ">" | "<=" | ">="

# Level 5 — Addition / Subtraction
AddExpr         → AddExpr AddOp MulExpr
                 | MulExpr

AddOp           → "+" | "-"

# Level 6 — Multiplication / Division / Modulo
MulExpr         → MulExpr MulOp UnaryExpr
                 | UnaryExpr

MulOp           → "*" | "/" | "%"

# Level 7 — Unary minus (highest precedence before primary)
UnaryExpr       → "-" UnaryExpr
                 | Primary

# Level 8 — Primary (highest)
Primary         → IDENTIFIER
                 | INT_LIT
                 | FLOAT_LIT
                 | STRING_LIT
                 | BOOL_LIT
                 | "(" Expr ")"

# ========= Terminal Tokens =========
IDENTIFIER      → [a-zA-Z_][a-zA-Z0-9_]*      (not a keyword)
INT_LIT         → [0-9]+
FLOAT_LIT       → [0-9]+ "." [0-9]+
STRING_LIT      → '"' (any char except '"')* '"'
BOOL_LIT        → "true" | "false"
NEWLINE         → '\n' (or ';')
```

### Precedence Table (low → high)

| Level | Operator(s)               | Associativity |
|-------|---------------------------|---------------|
| 1     | `\|\|`                    | Left          |
| 2     | `&&`                      | Left          |
| 3     | `!`  (unary prefix)       | Right         |
| 4     | `==  !=  <  >  <=  >=`    | Non-assoc     |
| 5     | `+  -`                    | Left          |
| 6     | `*  /  %`                 | Left          |
| 7     | `-` (unary prefix)        | Right         |

---

*This CFG specifies a minimal but complete subset of Julia sufficient for the
assignment requirements: declarations, assignment, arithmetic/relational/logical
expressions with multiple precedence levels, one conditional (`if`), and one loop
(`while`).*
