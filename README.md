# CS f364 — Compiler Construction

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

This is the **`ubuntu`** branch - everything is set up to build and
run on **Ubuntu 20.04+** with GNU `bison`, `flex`, and `gcc`.

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
├── phase2/
│   ├── parser.y           ← bison grammar + TAC generation
│   ├── lexer_phase2.l     ← flex lexer for parser tokens
│   ├── Makefile           ← build and run commands for phase 2
│   └── (generated: parser.tab.c/h, lex.yy.c, julia_compiler)
└── tests/
    ├── valid_program.jl   ← valid Julia program (no errors expected)
    ├── error_program.jl   ← program with intentional lexical errors
    ├── phase2_valid_program.jl ← successful parser/TAC test case
    └── syntax_error_program.jl ← program with intentional syntax errors
```

---

## Prerequisites (Ubuntu)

Install parser/lexer build tools (one-time):

```bash
sudo apt update
sudo apt install -y bison flex gcc make zip texlive-latex-base
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

## Phase 2 Build & Run

Detailed Phase 2 notes are available in `phase2/README.md`.

```bash
cd phase2
bison -d parser.y
flex lexer_phase2.l
gcc -Wall -Wextra -std=c11 parser.tab.c lex.yy.c -lfl -o julia_compiler

# valid run + TAC output file
./julia_compiler ../tests/phase2_valid_program.jl intermediate_valid.tac

# syntax error run
./julia_compiler ../tests/syntax_error_program.jl intermediate_error.tac
# expected: parser reports syntax error(s)
```

Or using make:

```bash
cd phase2
make
make run-valid
make run-syntax-error
```

One-command Ubuntu verification before zipping:

```bash
cd phase2
chmod +x verify_submission.sh
./verify_submission.sh
```

---

## Submission Checklist (Phase 2)

Required files to include in the zip:

1. Lex file: `phase2/lexer_phase2.l`
2. Yacc file: `phase2/parser.y`
3. Successful test case: `tests/phase2_valid_program.jl`
4. Error test case: `tests/syntax_error_program.jl`
5. Intermediate code for successful test: `phase2/intermediate_valid.tac`
6. Cover page (LaTeX source): `docs/cover_page_phase2.tex`

Recommended zip name:

- `CSf364-JULIA-Group31.zip`

Generate cover page PDF on Ubuntu:

```bash
cd docs
pdflatex cover_page_phase2.tex
pdflatex cover_page_phase2.tex
```

Create final zip (required naming format):

```bash
chmod +x package_submission.sh
./package_submission.sh
```

This produces: `CSf364-JULIA-Group31.zip`

---

## Phase 1 Deliverables

| # | Task                          | File(s)                                    | Status |
|---|-------------------------------|--------------------------------------------|--------|
| 1 | Language selection             | Julia                                      | Done   |
| 2 | Context-Free Grammar (CFG)    | `phase1/CFG.md`                            | Done   |
| 3 | Lexical specification         | `phase1/LexicalSpec.md`                    | Done   |
| 4 | Lexer implementation (Lex)    | `phase1/lexer.l`, `phase1/tokens.h`        | Done   |
| 5 | Testing the lexer             | `tests/valid_program.jl`, `tests/error_program.jl` | Done |

## Phase 2 Deliverables

| # | Task                                 | File(s)                                                  | Status |
|---|--------------------------------------|----------------------------------------------------------|--------|
| 1 | Parser implementation (Bison)        | `phase2/parser.y`                                        | Done   |
| 2 | Phase 2 lexer for parser             | `phase2/lexer_phase2.l`                                  | Done   |
| 3 | Valid parser test                    | `tests/phase2_valid_program.jl`                          | Done   |
| 4 | Syntax error parser test             | `tests/syntax_error_program.jl`                          | Done   |
| 5 | Intermediate code generation (TAC)   | `phase2/intermediate_valid.tac`                          | Done |

**Phase 1 Deadline:** 5:00 PM, 03-Mar-2026 (Tuesday)

---

## Deadlines

- **Phase 1:** 5:00 PM 03-Mar-2026
- **Phase 2:** 5:00 PM 16-Apr-2026