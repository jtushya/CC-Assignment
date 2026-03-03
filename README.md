# CS F365 — Compiler Construction

## Group
| Name                        | ID              | Role   |
|-----------------------------|-----------------|--------|
| Aryan Kamlesh Agrawal       | 2023A7PS0085H   | Leader |
| Tushya Jain                 | 2023A7PS0150H   | Member |
| Gursidak Singh Bassi        | 2023A7PS0033H   | Member |
| Jainam Parekh               | 2023A7PS0137H   | Member |

**Chosen Language:** Julia (minimal subset)

---

## Branch Info

This is the **`ubuntu`** branch — everything is set up to build and
run on **Ubuntu 20.04+** with GNU `flex` and `gcc`.

---

## Repository Layout

```
. 
├── README.md              ← you are here
├── CC assignment.md       ← original assignment spec
├── phase1/
│   ├── CFG.md             ← formal context-free grammar
│   ├── LexicalSpec.md     ← regex for every terminal symbol
│   ├── tokens.h           ← C header with token #defines
│   ├── lexer.l            ← flex source (the lexer)
│   └── (build manually using `flex` + `gcc`)
└── tests/
    ├── valid_program.jl   ← valid Julia program (no errors expected)
    └── error_program.jl   ← program with intentional lexical errors
```

---

## Prerequisites (Ubuntu)

Install `flex` and `gcc` (one-time):

```bash
sudo apt update
sudo apt install -y flex gcc make texlive-latex-base
```

---

## Build & Run

```bash
# Build the lexer manually (recommended):
cd phase1
flex lexer.l            # produces lex.yy.c
gcc lex.yy.c -lfl -o lexer

# Run on tests
./lexer ../tests/valid_program.jl
./lexer ../tests/error_program.jl

# Cleanup (from phase1/)
rm -f lex.yy.c lexer

# Build the Phase 1 PDF report (from repo root):
cd docs
pdflatex report.tex
pdflatex report.tex
# output: docs/report.pdf
```

---

## Phase 1 Deliverables

| # | Task                          | File(s)                                    | Status |
|---|-------------------------------|--------------------------------------------|--------|
| 1 | Language selection             | Julia                                      | Done   |
| 2 | Context-Free Grammar (CFG)    | `phase1/CFG.md`                            | Done   |
| 3 | Lexical specification         | `phase1/LexicalSpec.md`                    | Done   |
| 4 | Lexer implementation (Lex)    | `phase1/lexer.l`, `phase1/tokens.h`        | Done   |
| 5 | Testing the lexer             | `tests/valid_program.jl`, `tests/error_program.jl` | Done |

**Phase 1 Deadline:** 5:00 PM, 03-Mar-2026 (Tuesday)

---

## Deadlines

- **Phase 1:** 5:00 PM 03-Mar-2026
- **Phase 2:** 5:00 PM 16-Apr-2026