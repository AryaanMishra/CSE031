.data
prompt: .asciiz "Please enter a number: "

.text
main:
    # prompt user for input
    li $v0, 4       # system call code for print_string
    la $a0, prompt  # address of the prompt string
    syscall         # print the prompt string

    # read integer from user
    li $v0, 5       # system call code for read_int
    syscall         # read an integer from the user
    move $t3, $v0   # store the user input in $t3

    add $t0, $zero, $zero  # initialize $t0 with 0
    addi $t1, $zero, 1     # initialize $t1 with 1

fib:
    beq $t3, $zero, finish # base case: if n == 0, go to finish
    add $t2, $t1, $t0      # calculate next Fibonacci number
    move $t0, $t1          # update $t0 with previous value
    move $t1, $t2          # update $t1 with next value
    subi $t3, $t3, 1       # decrement n
    j fib                  # loop

finish:
    addi $a0, $t0, 0       # move final Fibonacci number to $a0
    li $v0, 1              # system call code for print_int
    syscall                # print the result

    li $v0, 10             # exit
    syscall