	.data
	
	.eqv val_x, 3
	.text
	.globl main
	
main:	
	ori $t0, $0, val_x
	
	add $t1, $t0, $t0
	addi $t1, $t1, 8
	
	jr $ra