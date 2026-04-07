.data
    array: .word 15, 9, 12, 10, 4 # example array
    size:  .word 5 # array size

.text
.globl main
main:
    la $a0, array
    lw $a1, size
    jal sort
 
    li $v0, 10
    syscall
    
swap:
    mul $t1, $a1, 4
    add $t1, $a0, $t1
    
    lw $t0, 0($t1)
    lw $t2, 4($t1)
    sw $t2, 0($t1)
    sw $t0, 4($t1)
    jr $ra
sort:
    addi $sp, $sp, -20
    sw $ra, 16($sp)
    sw $s3, 12($sp)
    sw $s2, 8($sp)
    sw $s1, 4($sp)
    sw $s0, 0($sp)
    move $s2, $a0
    move $s3, $a1
    move $s0, $zero

for1tst: 
    bge $s0, $s3, exit1
    addi $s1, $s0, -1

for2tst: 
    blt $s1, 0, exit2
    mul $t1, $s1, 4
    add $t2, $s2, $t1
    lw $t3, 0($t2)
    lw $t4, 4($t2)
    ble $t3, $t4, exit2
    move $a0, $s2
    move $a1, $s1
    jal swap
    addi $s1, $s1, -1
    j for2tst

exit2:
    addi $s0, $s0, 1
    j for1tst

exit1:
    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $s3, 12($sp)
    lw $ra, 16($sp)
    addi $sp, $sp, 20
    jr $ra