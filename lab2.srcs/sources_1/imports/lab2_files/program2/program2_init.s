# i != j
# ... f = g + h = 3 + 4 = 7
addi $s2, $zero, 3
addi $s3, $zero, 4
addi $s4, $zero, 1
addi $s0, $zero, 2

# if (i != j) f = g + h; else f = g - h;
# f, g, h, i, and j are assigned to the registers $s1, $s2, $s3, $s4 and $s0
beq $s4, $s0, 2 # if (i == j) branch to SUB inst
add $s1, $s2, $s3 # if (i != j), f = g + h
beq $zero, $zero, 1 # if (i != j) skip over SUB inst
sub $s1, $s2, $s3 # f = g - h 



# i == j
# ... f = g - h = 3 - 4 = -1
addi $s2, $zero, 3
addi $s3, $zero, 4
addi $s4, $zero, 2
addi $s0, $zero, 2

# if (i != j) f = g + h; else f = g - h;
# f, g, h, i, and j are assigned to the registers $s1, $s2, $s3, $s4 and $s0
beq $s4, $s0, 2 # if (i == j) branch to SUB inst
add $s1, $s2, $s3 # if (i != j), f = g + h
beq $zero, $zero, 1 # if (i != j) skip over SUB inst
sub $s1, $s2, $s3 # f = g - h 

