	.data
x:	.word 2
y:	.word 3
z:	.word 4
p:	.word 0
q:	.word 0

	.text
MAIN:
	la $t0, x		#Reads x value for creating a register
	lw $s0, 0($t0)		#Stores x value
	la $t0, y		#Reads y value for creating a register
	lw $s1, 0($t0)		#Stores y value
	la $t0, z		#Reads z value for creating a register
	lw $s2, 0($t0)
	
	add $a0, $s0, $zero
	add $a1, $s1, $zero
	add $a2, $s2, $zero
	
	jal FOO
	
	add $t1, $s0, $s1	#Adds x and y
	add $t2, $s2, $v0	#Adds z and foo(x+y+z)
	add $s2, $t1, $t2	#Adds sum of x and y with sum of z and foo(x+y+z)
	
	add $a0, $s2, $zero
	
	li $v0, 1 
	
	syscall
	j END
	
BAR:
	sub $t1, $a2, $a0	#Subtracts a from c
	sllv $v0, $t1, $a1	#Bit shifts by b's value
	jr $ra

FOO:
	addi $sp, $sp, -20	#Backsup
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $s0, 16($sp)
	
	add $a0, $s0, $s1	
	add $a1, $s1, $s2
	add $a2, $s2, $s0
	
	jal BAR			#Calls bar function
	
	la $t0, p
	lw $s0, 0($t0)
	
	add $t2, $s0, $v0
	
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $s0, 16($sp)
	addi $sp, $sp, 20	#Restore
	
	addi $sp, $sp, -20	#Backsup
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $s1, 16($sp)
	
	sub $a0, $s0, $s2
	sub $a1, $s1, $s0
	mul $a2, $s1, 2
	
	jal BAR			#Calls bar function
	
	la $t0, q
	lw $s1, 0($t0)
	
	add $t3, $s1, $v0
	
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $s1, 16($sp)
	addi $sp, $sp, 20	#Restores
	
	add $v0, $t2, $t3
	
	jr $ra			#Returns back to main
	
END:
	li $v0, 10
	syscall