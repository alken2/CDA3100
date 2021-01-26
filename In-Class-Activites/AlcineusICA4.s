##################################### PROBLEM 1 #############################################

# Use .set noreorder to prevent the assembler from filling branch
# delay slots, if you want to fill delay slots manually.
# .set noreorder

.global _start

.text
	_start:
		jal main
		li $v0, 10
		syscall
	main:
		lw $t0, n
		add $t1, $zero, $zero # Loop counter 1
		add $t2, $zero, $zero # Loop counter 2 (number of lines)
		add $t3, $zero, $zero # Number of stars in a line
		add $s0, $ra, $zero # Stores address in a register
	L1:
		beq $t1, $t3, L2 # Check whether or not to continue loop
		addi $t1, $t1, 1 # Increment the loop counter
		
		li $v0, 4 # Tells the system to prepare to print a string
		la $a0, star # Loads the address of times for it to be printed
		syscall # Call the system to perform an action (print value of times)
		
		j L1 # Jump to the beginning of the loop
	L2:
   		beq $t2, $t0, exit # Check whether or not to continue loop
		addi $t2, $t2, 1 # Increment the loop counter
		
		li $v0, 4 # Tells the system to prepare to print a string
		la $a0, newLine # Loads the address of newLine for it to be printed
		syscall # Call the system to perform an action (print value of newLine)
		
		add $t1, $zero, $zero # Reset loop counter 1
		addi $t3, $t3, 1 # Number of stars in a line
		
		j L1 # Jump to the beginning of the loop
	exit:
		jr $s0 # Jump to stored address
	
.data
   n: .word 10   # Variable
   star: .asciiz "* "
   newLine: .asciiz "\n"
