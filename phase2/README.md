# Phase 2 — Parser & Intermediate Code (Project README)

Overview
--------
This folder contains the Phase 2 implementation for the minimal Julia subset:
a Bison parser that performs syntax analysis and emits three-address code
(TAC) during parsing, together with the Flex lexer used by the parser.

This README documents how to build, test, and package Phase 2 on an Ubuntu
system (the environment used for evaluation).

Repository layout (phase2/)
--------------------------
- `parser.y`             — Bison grammar (parsing + TAC semantic actions)
- `lexer_phase2.l`       — Flex lexer for tokens used by the parser
- `Makefile`             — Optional convenience targets (build/test)
- `verify_submission.sh` — One-command verification script for Ubuntu
- `intermediate_valid.tac` — Example TAC produced from the sample program

Prerequisites (Ubuntu)
----------------------
Install required packages once:

```bash
sudo apt update
sudo apt install -y bison flex gcc make zip texlive-latex-base
```

Build (direct commands)
-----------------------
You do not need the `Makefile` to build — run these commands from `phase2/`:

```bash
bison -d parser.y
flex lexer_phase2.l
gcc -Wall -Wextra -std=c11 parser.tab.c lex.yy.c -lfl -o julia_compiler
```

Run
---
Generate TAC for the valid test program:

```bash
./julia_compiler ../tests/phase2_valid_program.jl intermediate_valid.tac
```

Run the syntax-error test (expected to report errors):

```bash
./julia_compiler ../tests/syntax_error_program.jl intermediate_error.tac
```

Makefile (optional)
-------------------
`Makefile` provides `make`, `make run-valid`, and `make run-syntax-error` to
quickly perform the same steps above. It is included for convenience and for
users who prefer `make` invocations.

Verification
------------
To perform an end-to-end verification (build, run tests, generate cover PDF):

```bash
chmod +x verify_submission.sh
./verify_submission.sh
```

Expected artifacts
------------------
- `intermediate_valid.tac` — TAC produced from the provided valid test case
- `intermediate_error.tac` — TAC output (or partial) when syntax errors are present

Packaging (submission)
----------------------
Follow the repository root README for packaging; a helper `package_submission.sh`
is provided to assemble the required files into `CSF365-JULIA-Group31.zip`.

Notes for evaluators
--------------------
- The lexer tokens and grammar correspond to the minimal Julia subset used in
	Phase 1 (variable declarations, assignments, expressions, one conditional,
	one loop, and `println`).
- The TAC format is simple, human-readable three-address code used for grading.

Contact
-------
For questions about Phase 2 implementation, contact the group leader:

Aryan Kamlesh Agrawal — 2023A7PS0085H

