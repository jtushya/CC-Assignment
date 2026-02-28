# -------------------------------------------------------
# Julia Program with LEXICAL ERRORS — Phase 1 Test (Task 5)
#
# This file intentionally contains characters/tokens that
# the lexer cannot recognise, so it should report errors.
# -------------------------------------------------------

# --- Valid declarations first ---
x = 10
y = 3.14

# ERROR 1: '@' is not a valid character in our Julia subset
z = x @ y

# ERROR 2: '$' is not in our token set
price = $100

# ERROR 3: '~' is not recognised
mask = ~x

# ERROR 4: backtick is not in our subset
cmd = `ls`

# ERROR 5: '^' (we did not include exponentiation)
power = x ^ 2

# A valid statement after errors (lexer should recover)
println(x)
