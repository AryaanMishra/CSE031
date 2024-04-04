# sumAll.s
# Program to calculate the sum of even and odd numbers

.data
prompt:     .asciiz "Please enter a number: "
even_sum_msg:   .asciiz "Sum of even numbers is: "
odd_sum_msg:    .asciiz "Sum of odd numbers is: "

.text
.globl main

main:
    li $t0, 0       # Initialize even_sum to 0
    li $t1, 0       # Initialize odd_sum to 0

loop:
    # Print prompt
    li $v0, 4
    la $a0, prompt
    syscall

    # Read user input
    li $v0, 5
    syscall
    move $t2, $v0   # Store user input in $t2

    beq $t2, $zero, print_sums  # If user input is 0, exit loop

    andi $t3, $t2, 1    # Check if number is odd
    beq $t3, $zero, even_sum     # If even, add to even_sum
    addu $t1, $t1, $t2  # Otherwise, add to odd_sum
    j loop

even_sum:
    addu $t0, $t0, $t2  # Add to even_sum
    j loop

print_sums:
    # Print even_sum
    li $v0, 4
    la $a0, even_sum_msg
    syscall
    li $v0, 1
    move $a0, $t0
    syscall
    li $v0, 11
    li $a0, 10  # Print newline
    syscall

    # Print odd_sum
    li $v0, 4
    la $a0, odd_sum_msg
    syscall
    li $v0, 1
    move $a0, $t1
    syscall
    li $v0, 11
    li $a0, 10  # Print newline
    syscall

    # Exit program
    li $v0, 10
    syscall