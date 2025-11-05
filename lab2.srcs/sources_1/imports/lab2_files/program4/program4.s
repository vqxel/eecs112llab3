addi $a0, $zero, 200
addi $a1, $zero, 3
addi $t5, $zero, 10   # $t5 = 10
sw $t5, 12($a0)       # mem[200 + 12] = 10
addi $t6, $zero, 99   # $t6 = 99
sw $t6, 16($a0)       # mem[200 + 16] = 99


sll $t0, $a1, 2
add $t0, $a0, $t0
lw $t1, 0($t0)
lw $t2, 4($t0)
sw $t2, 0($t0)
sw $t1, 4($t0)

t0 = a1 << 2
t0 = t0 + a0
t1 = t0[0]
t2 = t0[1]
t0[0] = t2
t0[1] = t1

t0 = t0(word) + a0(byte)
tmp = t0[0]
t0[0] = t0[1]
t0[1] = tmp

// a1 is storing i (offset)
// a0 is storing array's base address
int arrayOne = array[i]; // lw instruction 1
int arrayTwo = array[i + 1]; // lw instruction 2
array[i] = arrayTwo; // sw instruction 1
array[i + 1] = arrayOne; // sw instruction 2
