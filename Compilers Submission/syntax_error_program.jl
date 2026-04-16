# Phase 2 parser test - intentional syntax errors

x::Int64 = 10
y = 20

if x > 5
    println(x)
elseif y == 20
    println(y)
else
    println(x + y)
# ERROR: missing end for if block

while x < 15
    x = x + 1
    println(x)
end
