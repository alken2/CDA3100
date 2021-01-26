# Use .set noreorder to prevent the assembler from filling branch
# delay slots, if you want to fill delay slots manually.
# .set noreorder

.global _start
_start:
	jal main
	li $v0, 10
	syscall		# Use syscall 10 to stop simulation

main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp) # Stores _start address
	
	li.s $f1, 2.0
	li.s $f2, 1.0
	div.s $f3, $f0, $f1 # x_cur
	add.s $f4, $f3, $f2 # x_next
	
	li $v0, 4 # Tells the system to prepare to print a string
	la $a0, prompt
	syscall
	
	li $v0, 6 # Tells the system to prepare to get input float and store it $f0
	syscall
	
	mtc1 $zero, $f8 # Sets $f8 equal to zero
	c.le.s $f0, $f8 # Sets condition based on whether $f0 <= $f8
	bc1f L1 # Branch to L1 if coprocessor 1 is false
	
	jal badInput # Goes to badInput
	
	L1:
	sub.s $f5, $f3, $f4
	abs.s $f6, $f5
	li.s $f7, 0.0000001
	c.le.s $f6, $f7 # Sets condition based on whether $f6 <= $f7
	bc1t L2 # Goes to L2 if true
	
	mov.s $f3, $f4
	div.s $f9, $f0, $f3
	add.s $f10, $f9, $f3
	div.s $f4, $f10, $f1
	
	j L1
	
	L2:
	li $v0, 4 # Tells the system to prepare to print a string
	la $a0, answer
	syscall
	
	li $v0, 2 # Tells the system to prepare to print a float
	mov.s $f12, $f3
	syscall 
	
	lw $ra, 0($sp) # Loads _start address
	addiu $sp, $sp, 4
	jr $ra
	
badInput:
	li $v0, 4 # Tells the system to prepare to print a string
	la $a0, negative
	syscall
	
	abs.s $f0, $f0
	
	jr $ra

.data
   prompt: .asciiz "Enter a non negative number: "
   answer: .asciiz "\nThe square root of the number is: "
   negative: .asciiz "\nThe input is negative! Using the absolute value instead..."
