# Phase 1 test — intentional lexical errors

# valid declarations
x = 10
y = 3.14

# ERROR 1: '@' not in token set
z = x @ y

# ERROR 2: '$' not in token set
price = $100

# ERROR 3: '~' not in token set
mask = ~x

# ERROR 4: backtick not in token set
cmd = `ls`

# ERROR 5: '^' not in token set
power = x ^ 2

# lexer should recover and continue
println(x)
