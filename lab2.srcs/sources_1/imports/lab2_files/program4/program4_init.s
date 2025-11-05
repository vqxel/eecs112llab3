# i != j
# ... f = g + h = 3 + 4 = 7
addi $s1, $zero, 8
addi $s2, $zero, 48
addi $t0, $zero, 0
sw $s1, 8($s2)


# while (save[i] != k) i += 1;
# k is assigned to $s1, base address of save[] is in $s2, i is in $t0
sll $t1, $t0, 2 # i * 4 to convert it to word value
add $t2, $s2, $t1 # calculate new memory address for save + 4i
lw $t3, ($t2) # load memory at save[i]
beq $t3, $s1, 2 # if (save[i] == k) branch to after program
addi $t0, $t0, 1 # increment i
beq $zero, $zero, -6 # loop back to start of loop logic
