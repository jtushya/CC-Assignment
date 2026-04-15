x = 5
y = 2
t1 = y * 3
t2 = x + t1
sum = t2
t3 = sum > 10
ifFalse t3 goto L1
print sum
goto L2
L1:
print y
L2:
L3:
t4 = x < 8
ifFalse t4 goto L4
t5 = x + 1
x = t5
goto L3
L4:
