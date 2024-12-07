	.data
	
	.text
	.globl main
	
main:	ori $t0, $0, 3		# $t0 = 3
	ori $t2, $0, 8		# $t2 = 8 
	add $t1, $t0, $t0	# $t1 = $t0 + $t0 = x + x = 2 * x
	sub $t1, $t1, $t2	# $t1 = $t0 + $t0 = x + x = 2 * x
	jr $ra			# fim do programa
	