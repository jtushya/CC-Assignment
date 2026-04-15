# Phase 2 - Parsing and Intermediate Code Generation

This folder contains the Phase 2 implementation for the minimal Julia subset.

## Is Makefile Required on Ubuntu?

No. A Makefile is not strictly required.

You can build and run everything with direct commands:

```bash
bison -d parser.y
flex lexer_phase2.l
gcc -Wall -Wextra -std=c11 parser.tab.c lex.yy.c -lfl -o julia_compiler
./julia_compiler ../tests/phase2_valid_program.jl intermediate_valid.tac
./julia_compiler ../tests/syntax_error_program.jl intermediate_error.tac
```

The Makefile is included only for convenience and repeatability.

## Files

- `parser.y` - Bison grammar with syntax rules and TAC generation actions.
- `lexer_phase2.l` - Flex lexer used by the parser.
- `Makefile` - Optional helper build targets.
- `verify_submission.sh` - Runs a full Ubuntu verification pass.
- `intermediate_valid.tac` - Intermediate code generated from the successful test case.

## Ubuntu Prerequisites

```bash
sudo apt update
sudo apt install -y bison flex gcc make zip texlive-latex-base
```

## Recommended Verification Flow

```bash
chmod +x verify_submission.sh
./verify_submission.sh
```

## Build Targets (Optional)

```bash
make
make run-valid
make run-syntax-error
make clean
```
