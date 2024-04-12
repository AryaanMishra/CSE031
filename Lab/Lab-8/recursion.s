.data
prompt: .asciiz "Enter a number: "

.text
main:
    addi $sp, $sp, -4 # Moving stack pointer to make room for storing local variables (push the stack frame)

    # TPS 2 #3 (display input prompt)
    li $v0, 4       # system call code for print_string
    la $a0, prompt  # address of the prompt string
    syscall         # print the prompt string

    # TPS 2 #4 (read user input)
    li $v0, 5       # system call code for read_int
    syscall         # read an integer from the user
    move $a0, $v0   # move the user input to $a0

    jal recursion   # Call recursion(x)

    # TPS 2 #6 (print out returned value)
    move $a0, $v0   # move the returned value to $a0
    li $v0, 1       # system call code for print_int
    syscall         # print the integer

    j end           # Jump to end of program

# Implementing recursion
recursion:
    addi $sp, $sp, -12 # Push stack frame for local storage
    sw $ra, 0($sp)     # TPS 2 #7 (save the return address)

    addi $t0, $a0, 1
    bne $t0, $zero, not_minus_one

    # TPS 2 #8 (update returned value)
    addi $v0, $a0, 0   # return n
    j end_recur

not_minus_one:
    bne $a0, $zero, not_zero

    # TPS 2 #9 (update returned value)
    addi $v0, $zero, 1 # return 1
    j end_recur

not_zero:
    sw $a0, 4($sp)     # save $a0 into the stack

    # TPS 2 #11 (Prepare new input argument, i.e. m - 2)
    addi $a0, $a0, -2  # update $a0 to m - 2
    jal recursion      # Call recursion(m - 2)

    # TPS 2 #12
    sw $v0, 8($sp)     # save the returned value from the first recursive call

    # TPS 2 #13 (Prepare new input argument, i.e. m - 1)
    lw $a0, 4($sp)     # restore the original value of $a0 (m)
    addi $a0, $a0, -1  # update $a0 to m - 1
    jal recursion      # Call recursion(m - 1)

    # TPS 2 #14 (update returned value)
    lw $t0, 8($sp)     # load the returned value from the first recursive call
    add $v0, $t0, $v0  # add the two returned values

end_recur:
    # TPS 2 #15
    lw $ra, 0($sp)     # restore the return address
    addi $sp, $sp, 12  # Pop stack frame
    jr $ra

# Terminating the program
end:
    addi $sp, $sp, 4   # Moving stack pointer back (pop the stack frame)
    li $v0, 10
    syscall
