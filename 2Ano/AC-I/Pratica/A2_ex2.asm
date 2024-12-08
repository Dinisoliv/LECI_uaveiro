	.data
	
	.eqv val_1, 109
	.eqv shft_amnt, 1
	
	.text
	.globl main
	
main:
	li $t0, val_1

	sll $t2, $t0, shft_amnt
	srl $t3, $t0, shft_amnt
	sra $t4, $t0, shft_amnt

	li $v0, 1
	move $a0, $t0
	syscall
		
	#gray code
	srl $t5, $t0, 1
	xor $t1, $t0, $t5
	
	li $v0, 11
	li $a0, '-'
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	move $t6, $t1
	
	#gray to bin
	srl $t7, $t6, 4
	xor $t6, $t6, $t7	 
	
	
	srl $t7, $t6, 2
	xor $t6, $t6, $t7
	
	srl $t7, $t6, 1
	xor $t6, $t6, $t7
	
	li $v0, 11
	li $a0, '-'
	syscall
	
	li $v0, 1
	move $a0, $t6
	syscall 
	
	jr $ra
