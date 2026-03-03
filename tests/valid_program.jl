# Phase 1 test — all grammar constructs, no lexical errors expected

# variable declarations
x::Int64 = 10
y::Float64 = 3.14
flag::Bool = true
name::String = "Julia"

# assignments
a = 5
b = 20

# arithmetic
sum = a + b
diff = b - a
prod = a * b
quot = b / a
rem = b % a

# relational and logical
is_positive = x > 0
check = (a == 5) && (b != 10)
either = flag || false

# if / elseif / else
if x > 5
    println(x)
elseif x == 5
    println(a)
else
    println(b)
end

# while loop
counter = 0
while counter < 5
    counter = counter + 1
    println(counter)
end

# nested expressions across precedence levels
result = (a + b) * 2 - (x / 5) % 3
complex = !(a < b) || (x >= y) && true
println(result)
println(complex)
