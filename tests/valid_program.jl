# -------------------------------------------------------
# Valid Julia Program — Phase 1 Test (Task 5)
#
# This program uses every construct defined in the CFG:
#   - Variable declarations (with and without type annotation)
#   - Assignment statements
#   - Arithmetic, relational, and logical expressions
#   - if / elseif / else / end  conditional
#   - while / end  loop
#   - println statement
#
# Expected: The lexer should tokenise this without errors.
# -------------------------------------------------------

# --- Variable declarations ---
x::Int64 = 10
y::Float64 = 3.14
flag::Bool = true
name::String = "Julia"

# --- Simple assignments ---
a = 5
b = 20

# --- Arithmetic expressions ---
sum = a + b
diff = b - a
prod = a * b
quot = b / a
rem = b % a

# --- Relational and logical ---
is_positive = x > 0
check = (a == 5) && (b != 10)
either = flag || false

# --- Conditional: if / elseif / else / end ---
if x > 5
    println(x)
elseif x == 5
    println(a)
else
    println(b)
end

# --- Loop: while / end ---
counter = 0
while counter < 5
    counter = counter + 1
    println(counter)
end

# --- Nested expressions with multiple precedence levels ---
result = (a + b) * 2 - (x / 5) % 3
complex = !(a < b) || (x >= y) && true
println(result)
println(complex)
