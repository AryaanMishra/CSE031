.data
str1:   .asciiz "p + q: %d\n"
str2:   .asciiz "%d\n"

.text
.globl main

bar:
    # a -> $a0, b -> $a1, c -> $a2
    sub $v0, $a1, $a0  # $v0 = b - a
    sllv $v0, $v0, $a2 # $v0 = (b - a) << c
    jr $ra             # Added this line to return to the caller

foo:
    # m -> $a0, n -> $a1, o -> $a2
    # p -> $s0, q -> $s1
    addi $sp, $sp, -12 # allocate space on the stack
    sw $ra, 8($sp)     # save return address
    sw $s0, 4($sp)     # save $s0
    sw $s1, 0($sp)     # save $s1

    add $a0, $a0, $a2  # m + o
    add $a1, $a1, $a2  # n + o
    add $a2, $a0, $a1  # m + n + o
    jal bar             # call bar(m + o, n + o, m + n)
    move $s0, $v0      # p = bar(m + o, n + o, m + n)

    sub $a0, $a0, $a2  # m - o
    sub $a1, $a1, $a0  # n - m
    add $a2, $a1, $a1  # n + n
    jal bar             # call bar(m - o, n - m, n + n)
    move $s1, $v0      # q = bar(m - o, n - m, n + n)

    add $a0, $s0, $s1  # p + q
    li $v0, 4           # print_string syscall code
    la $a1, str1
    syscall             # print "p + q: %d\n"

    add $v0, $s0, $s1  # return p + q

    lw $ra, 8($sp)     # restore return address
    lw $s0, 4($sp)     # restore $s0
    lw $s1, 0($sp)     # restore $s1
    addi $sp, $sp, 12  # deallocate stack space
    jr $ra

main:
    # x -> $s0, y -> $s1, z -> $s2
    li $s0, 2  # x = 2
    li $s1, 4  # y = 4
    li $s2, 6  # z = 6

    move $a0, $s0  # m = x
    move $a1, $s1  # n = y
    move $a2, $s2  # o = z
    jal foo        # call foo(x, y, z)
    add $s2, $v0, $s2  # z = foo(x, y, z) + z
    add $s2, $s2, $s1  # z = z + y
    add $s2, $s2, $s0  # z = z + x

    move $a0, $s2      # print z
    li $v0, 1
    syscall

    li $v0, 10         # exit
    syscall