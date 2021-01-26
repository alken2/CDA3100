# Use .set noreorder to prevent the assembler from filling branch
# delay slots, if you want to fill delay slots manually.
# .set noreorder

.global _start

.text
	_start:
		jal main
	main:
		la $s0, string # Loads string address into s0
		jal pushAndPop # Goes to pushAndPop
		li $v0, 10 # Tells the system to prepare to exit the program
		syscall # Calls the system to perform an action (end program)
	pushAndPop:
		add $t0, $zero, $zero # Initializes t0 (Loop counter)
		add $t1, $zero, $zero # Initializes t1 (String pointer)
	push:
		addiu $sp, $sp, -4 # Adds a spot in stack
		add $t1, $s0, $t0 # Puts the string address at a position of the loop counter in the string pointer
		lb $t2, 0($t1) # Loads the character from the string pointer into t2
		addi $t0, $t0, 1 # Increments the loop counter
		sw $t2, 0($sp) # Stores character into stack (push)
		beqz $t2, pop # Branches out of the loop if there is no character in t2
		j push # Continues the loop
	pop:
		lw $t2, 0($sp) # Loads character from stack (pop)
		li $v0, 11 # Tells the system to prepare to print a character
		add $a0, $t2, $zero # Stores the content of t2 for it to be printed
		syscall # Calls the system to perform an action (print character)
		addiu $t0, $t0, -1 # Increments the loop counter
		addiu $sp, $sp, 4 # Removes a spot in stack
		beqz $t0, exitLoop # Branches out of the loop if there is no character in t2
		j pop # Continues the loop
	exitLoop:
		jr $ra # Jumps to the return address of pop
.data
   string: .asciiz "Computing is Awesome!"
