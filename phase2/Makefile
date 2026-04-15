BISON = bison
FLEX = flex
CC = gcc
CFLAGS = -Wall -Wextra -std=c11
TARGET = julia_compiler

all: $(TARGET)

parser.tab.c parser.tab.h: parser.y
	$(BISON) -d parser.y

lex.yy.c: lexer_phase2.l parser.tab.h
	$(FLEX) lexer_phase2.l

$(TARGET): parser.tab.c lex.yy.c
	$(CC) $(CFLAGS) parser.tab.c lex.yy.c -lfl -o $(TARGET)

run-valid: $(TARGET)
	./$(TARGET) ../tests/phase2_valid_program.jl intermediate_valid.tac

run-syntax-error: $(TARGET)
	./$(TARGET) ../tests/syntax_error_program.jl intermediate_error.tac || true

clean:
	rm -f parser.tab.c parser.tab.h lex.yy.c $(TARGET) intermediate_valid.tac intermediate_error.tac
