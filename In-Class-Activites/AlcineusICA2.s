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
		lw $t0, m
		lw $t1, n
		add $t2, $zero, $zero
		add $s0, $zero, $zero
		add $s1, $ra, $zero # Stores address in a register
	L1:
		beq $t2, $t0, L2 # Check whether or not to continue loop
		addi $t2, $t2, 1 # Increment the loop counter
		mult $t1, $t2 # n * [loop counter]
  		mflo $s0 # [result]
		
		li $v0, 1 # Tells the system to prepare to print an integer
		add $a0, $t1, $zero # Stores the content of $t1 for it to be printed
		syscall # Call the system to perform an action (print value of n)
		
		li $v0, 4 # Tells the system to prepare to print a string
		la $a0, times # Loads the address of times for it to be printed
		syscall # Call the system to perform an action (print value of times)
		
		li $v0, 1 # Tells the system to prepare to print an integer
		add $a0, $t2, $zero # Stores the content of $t2 for it to be printed
		syscall # Call the system to perform an action (print value of [loop couter])
		
		li $v0, 4 # Tells the system to prepare to print a string
		la $a0, equals # Loads the address of equals for it to be printed
		syscall # Call the system to perform an action (print value of equals)
		
		li $v0, 1 # Tells the system to prepare to print an integer
		add $a0, $s0, $zero # Stores the content of $s0 for it to be printed
		syscall # Call the system to perform an action (print value of [result])
		
		li $v0, 4 # Tells the system to prepare to print a string
		la $a0, newLine # Loads the address of newLine for it to be printed
		syscall # Call the system to perform an action (print value of newLine)
		
		j L1 # Jump to the beginning of the loop
	L2:
   		jr $s1 # Jump to stored address
	
.data
   m: .word 5   # Variable
   n: .word 10   # Variable
   times: .asciiz " * "
   equals: .asciiz " = "
   newLine: .asciiz "\n"
