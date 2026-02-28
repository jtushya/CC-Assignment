# ---------------------------------------------------------------
# Makefile — Build the Minimal Julia Lexer (Phase 1)
#
# CS F365 Compiler Construction
# Language: Julia (minimal subset)
#
# Prerequisites:
#   - flex  (or lex)
#   - gcc   (or any C compiler)
#
# Targets:
#   make            — build the lexer executable
#   make test       — run lexer on valid + error test programs
#   make clean      — remove generated files
#
# Usage on Linux / WSL:
#   cd phase1 && make
#   make test
#
# Group:
#   Aryan Kamlesh Agrawal  2023A7PS0085H  (Leader)
#   Tushya Jain             2023A7PS0150H
#   Gursidak Singh Bassi    2023A7PS0033H
#   Jainam Parekh           2023A7PS0137H
# ---------------------------------------------------------------

CC      = gcc
FLEX    = flex
CFLAGS  = -Wall -g

# Source / generated files
LEX_SRC  = lexer.l
LEX_C    = lexer.c
EXEC     = lexer

# Test inputs (paths relative to phase1/)
TEST_VALID = ../tests/valid_program.jl
TEST_ERROR = ../tests/error_program.jl

# ---- Default target: build ----
all: $(EXEC)

$(LEX_C): $(LEX_SRC) tokens.h
	$(FLEX) -o $(LEX_C) $(LEX_SRC)

$(EXEC): $(LEX_C)
	$(CC) $(CFLAGS) -o $(EXEC) $(LEX_C)

# ---- Run both test cases ----
test: $(EXEC)
	@echo "========================================"
	@echo "  TEST 1: Valid Julia program"
	@echo "========================================"
	./$(EXEC) $(TEST_VALID)
	@echo ""
	@echo "========================================"
	@echo "  TEST 2: Program with lexical errors"
	@echo "========================================"
	-./$(EXEC) $(TEST_ERROR)

# ---- Cleanup ----
clean:
	rm -f $(LEX_C) $(EXEC) *.o

.PHONY: all test clean
