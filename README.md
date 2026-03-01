# CS F365 — Compiler Construction (Group Repo, `main` branch)

This branch (`main`) contains the Phase 1 artifacts and Windows/WSL guidance.

## Group
| Name                        | ID              | Role   |
|-----------------------------|-----------------|--------|
| Aryan Kamlesh Agrawal       | 2023A7PS0085H   | Leader |
| Tushya Jain                 | 2023A7PS0150H   | Member |
| Gursidak Singh Bassi        | 2023A7PS0033H   | Member |
| Jainam Parekh               | 2023A7PS0137H   | Member |

**Chosen Language:** Julia (minimal subset)

---

## What is in this branch

- `phase1/` — CFG, lexical specification, tokenizer implementation and Makefile
- `tests/` — valid input and a program with lexical errors
- `CC assignment.md` — assignment instructions

This branch is suitable for evaluation on Windows (PowerShell) or WSL. For a
clean Ubuntu-focused setup see the `ubuntu` branch.

---

## Build & Run (recommended: WSL / Ubuntu)

The easiest way on Windows is to use WSL with Ubuntu and follow the Ubuntu
instructions (switch to the `ubuntu` branch if you prefer). Example:

```powershell
# Install WSL and Ubuntu (if not already):
wsl --install -d Ubuntu

# In Ubuntu shell:
sudo apt update && sudo apt install -y flex gcc make
cd /mnt/c/Users/<you>/Downloads/CC\ Assignment/phase1
make
make test
```

---

## Native Windows (PowerShell) — alternate

If you prefer native Windows tools, install the following with Chocolatey
(requires Administrator PowerShell):

```powershell
choco install winflexbison3 mingw -y
# ensure mingw bin directory (gcc) is in PATH; open a new shell after install

# Build (from repository root):
cd .\phase1
# On Windows you may need to run win_flex or win_flex.exe instead of flex
win_flex -o lexer.c lexer.l
gcc -o lexer lexer.c -lfl
.\lexer ..\tests\valid_program.jl
```

Note: native Windows paths and tools vary; using WSL is strongly recommended for
reproducible evaluation.

---

## Phase 1 status (requirements)

- Language selection: Julia — Done
- CFG (minimal subset): `phase1/CFG.md` — Done
- Lexical specification (regex): `phase1/LexicalSpec.md` — Done
- Lexer implementation (Lex/flex): `phase1/lexer.l` & `phase1/tokens.h` — Done
- Tests (valid + lexical error): `tests/valid_program.jl`, `tests/error_program.jl` — Done

Deadline: Phase 1 — 5:00 PM 03-Mar-2026

---

If you want, I can also:
- push an `ubuntu` branch to the remote for CI/testing
- add a simple `phase2/` placeholder that documents parser expectations

Reply with which of the above you'd like next.