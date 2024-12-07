	.data
	.text
	.eqv val_1,0xF0F0
	.eqv val_2,0x1234
	.globl	main
	
main:	ori $t0, $0, 0xF0F0
	ori $t1, $0, 0x1234
	and $t2, $t0, $t1
	or $t3, $t0, $t1
	nor $t4, $t0, $t1
	xor $t5, $t0, $t1
	nor $t6, $t0, $t0
	nor $t7, $t1, $0
	jr $ra
