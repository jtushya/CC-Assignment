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
│   └── Makefile           ← build & test targets
└── tests/
    ├── valid_program.jl   ← valid Julia program (no errors expected)
    └── error_program.jl   ← program with intentional lexical errors
```

---

## Prerequisites (Ubuntu)

Install `flex` and `gcc` (one-time):

```bash
sudo apt update
sudo apt install -y flex gcc make
```

---

## Build & Run

```bash
# 1. Build the lexer
cd phase1
make            # runs: flex → lexer.c → gcc → ./lexer

# 2. Run on the valid test program
make test       # runs lexer on both test files automatically

# 3. Or run manually
./lexer ../tests/valid_program.jl
./lexer ../tests/error_program.jl

# 4. Clean generated files
make clean
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