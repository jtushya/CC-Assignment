#!/usr/bin/env bash
set -euo pipefail

echo "[1/4] Building parser and lexer"
bison -d parser.y
flex lexer_phase2.l
gcc -Wall -Wextra -std=c11 parser.tab.c lex.yy.c -lfl -o julia_compiler

echo "[2/4] Running valid program test"
./julia_compiler ../tests/phase2_valid_program.jl intermediate_valid.tac

if [[ ! -s intermediate_valid.tac ]]; then
  echo "ERROR: intermediate_valid.tac was not generated or is empty"
  exit 1
fi

echo "[3/4] Running syntax error test (expected failure)"
if ./julia_compiler ../tests/syntax_error_program.jl intermediate_error.tac; then
  echo "ERROR: syntax error test unexpectedly succeeded"
  exit 1
else
  echo "Syntax error test behaved as expected"
fi

echo "[4/4] Building cover page PDF"
cd ../docs
pdflatex cover_page_phase2.tex >/dev/null
pdflatex cover_page_phase2.tex >/dev/null

if [[ ! -s cover_page_phase2.pdf ]]; then
  echo "ERROR: cover_page_phase2.pdf was not generated"
  exit 1
fi

echo "Verification complete. Submission artifacts are ready."
