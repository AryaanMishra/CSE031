.data
newline: .asciiz "\n"

.text
.globl main

main:
    # Initialize x, y, z
    li $s0, 2   # x = 2
    li $s1, 4   # y = 4
    li $s2, 6   # z = 6

    # Call foo(x, y, z)
    move $a0, $s0
    move $a1, $s1
    move $a2, $s2
    jal foo

    # z = x + y + z + foo(x, y, z)
    add $s2, $s2, $s0
    add $s2, $s2, $s1
    add $s2, $s2, $v0

    # Print z
    move $a0, $s2
    li $v0, 1
    syscall

    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit
    li $v0, 10
    syscall

foo:
    # Allocate stack frame
    addi $sp, $sp, -12
    sw $ra, 8($sp)
    sw $s0, 4($sp)
    sw $s1, 0($sp)

    # Call bar(m + o, n + o, m + n)
    add $t0, $a0, $a2  # m + o
    add $t1, $a1, $a2  # n + o
    add $t2, $a0, $a1  # m + n
    move $a0, $t0
    move $a1, $t1
    move $a2, $t2
    jal bar
    move $s0, $v0      # p = bar(m + o, n + o, m + n)

    # Call bar(m - o, n - m, n + n)
    sub $t0, $a0, $a2  # m - o
    sub $t1, $a1, $a0  # n - m
    add $t2, $a1, $a1  # n + n
    move $a0, $t0
    move $a1, $t1
    move $a2, $t2
    jal bar
    move $s1, $v0      # q = bar(m - o, n - m, n + n)

    # Print p + q
    add $a0, $s0, $s1
    li $v0, 1
    syscall

    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Return p + q
    add $v0, $s0, $s1

    # Restore registers and return
    lw $s1, 0($sp)
    lw $s0, 4($sp)
    lw $ra, 8($sp)
    addi $sp, $sp, 12
    jr $ra

bar:
    # Allocate stack frame
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    # Compute (b - a) << c
    sub $t0, $a1, $a0  # b - a
    sllv $v0, $t0, $a2 # (b - a) << c

    # Restore register and return
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra