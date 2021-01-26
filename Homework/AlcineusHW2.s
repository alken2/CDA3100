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
		add $s0, $ra, $zero # Stores address in a register
		lw $t0, m
		lw $t1, n
		jal part1
		add $s4, $zero, $zero
		jal part2
		jr $s0 # Goes to stored address
		
	part1:
		add $s1, $ra, $zero # Stores address in a register
		slti $t2, $t0, 1 # Checks if m is less than one
		beq $t2, $zero, printStringAndLoop # Branch to label if false
		jr $s1 # Goes to stored address

	part2:
		add $s2, $ra, $zero # Stores address in a register
		add $s4, $t1, $s4 # Sets a register equal to n + itself
		slti $t3, $t1, 1 # Checks if  n is less than one
		beq $t3, $zero, loopInteger # Branch to label if false
		bne $t3, $zero, printInteger # Branch to label if true
		jr $s2 # Goes to stored address

	printStringAndLoop:
		li $v0, 4 # Tells the system to prepare to print a string
		la $a0, myString # Loads the address of the string for it to be printed
		syscall
		addi $t0, $t0, -1 # Sets m equal to m - 1
		j part1 # Returns to the beginning of part 1

	loopInteger:
		addi $t1, $t1, -1 # Sets n equal to n - 1
		j part2 # Returns to the beginning of part 2

	printInteger:
		add $s3, $ra, $zero # Stores address in a register
		li $v0, 1 # Tells the system to prepare to print an integer
		add $a0, $s4, $zero # Stores the content of $t1 for it to be printed
		syscall
		jr $s3 # Goes to stored address

	
.data
   m: .word 3   # Variable
   n: .word 5   # Variable
   myString: .asciiz "Hello UNF\n"
