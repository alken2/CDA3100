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
		lw $a0, v
		lw $a1, k
		add $s0, $ra, $zero # Stores address in a register
	L1:
   		jr $s0 # Jump to stored address
	
.data
   v: .word 1, 2, 3, 4, 5   # Array with 5 elements
   k: .word 3   # Index
