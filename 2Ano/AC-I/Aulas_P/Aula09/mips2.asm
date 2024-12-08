	.data

k1:	.float 5.0, 9.0, 32.0

	.text
	.globl main
main:
	addi $sp, $sp, -4 
while:

endw:	
	jr $ra

f2c:
	la $t0, k1
	l.d $f2, 0($t0)
	l.d $f4, 8($t0)
	l.d $f6, 16($t0)

	div.d $f0, $f2, $f4
	sub.d $f2, $f12, $f5
	mul.d $f0, $f0, $f2
	
	jr $ra