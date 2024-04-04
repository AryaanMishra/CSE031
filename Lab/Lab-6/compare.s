.data
n: .word 25
str1: .asciiz "Less than\n"
str2: .asciiz "Less than or equal to\n"
str3: .asciiz "Greater than\n"
str4: .asciiz "Greater than or equal to\n"
prompt: .asciiz "Enter an integer: "

.text
.globl main
main:
    # Print the prompt
    la $a0, prompt
    li $v0, 4
    syscall

    # Read the user input
    li $v0, 5
    syscall
    move $t0, $v0  # Store the user input in $t0

    # Load the value of n into $t1
    la $t1, n
    lw $t1, 0($t1)

    # Compare if the user input is less than n
    slt $t2, $t0, $t1  # Set $t2 to 1 if $t0 < $t1, 0 otherwise
    beq $t2, $zero, else1  # Branch to else1 if $t2 is 0 (not less than)
    la $a0, str1  # Load the address of str1
    li $v0, 4  # Print the string
    syscall
    j endif1  # Jump to endif1
else1:

    # Compare if the user input is greater than or equal to n
    slt $t2, $t1, $t0  # Set $t2 to 1 if $t1 < $t0, 0 otherwise
    beq $t2, $zero, else2  # Branch to else2 if $t2 is 0 (not greater than or equal to)
    la $a0, str4  # Load the address of str4
    li $v0, 4  # Print the string
    syscall
    j endif2  # Jump to endif2
else2:
endif1:  # Define the endif1 label here

    # Compare if the user input is greater than n
    slt $t2, $t1, $t0  # Set $t2 to 1 if $t1 < $t0, 0 otherwise
    bne $t2, $zero, greater  # Branch to greater if $t2 is not 0 (greater than)
    j endif3  # Jump to endif3
greater:
    la $a0, str3  # Load the address of str3
    li $v0, 4  # Print the string
    syscall
    j endif3  # Jump to endif3
endif3:
endif2:  # Define the endif2 label here

    # Compare if the user input is less than or equal to n
    slt $t2, $t0, $t1  # Set $t2 to 1 if $t0 < $t1, 0 otherwise
    bne $t2, $zero, less_equal  # Branch to less_equal if $t2 is not 0 (less than or equal to)
    j exit  # Jump to exit
less_equal:
    la $a0, str2  # Load the address of str2
    li $v0, 4  # Print the string
    syscall

exit:
    li $v0, 10
    syscall