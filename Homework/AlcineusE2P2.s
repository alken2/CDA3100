# Use .set noreorder to prevent the assembler from filling branch
# delay slots, if you want to fill delay slots manually.
# .set noreorder

# Much of this code is based off of my Homework 4 submission (AlcineusHW4)

.global _start
_start:
	jal main
	li $v0, 10
	syscall		# Use syscall 10 to stop simulation

main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	li.s $f0, 0
	li.s $f1, 1.0
	li.s $f2, 2.0
	
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	slt $t1, $t0, $zero
	beq $t1, $zero, L1
	
	jal badInput
	
	L1:
	add.s $f0, $f1, $f0
	beqz $t0, L2
	
	addi $t0, $t0, -1
	div.s $f1, $f1, $f2
	
	j L1
	
	L2:
	li $v0, 4
	la $a0, result
	syscall
	
	li $v0, 2
	mov.s $f12, $f0
	syscall 
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
	
badInput:
	li $v0, 4
	la $a0, negative
	syscall
	
	abs $t0, $t0
	
	jr $ra

.data
   prompt: .asciiz "Enter a non negative integer: "
   result: .asciiz "\nThe result is: "
   negative: .asciiz "\nThe input is negative! Using the absolute value instead..."
