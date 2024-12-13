	.data
	
const:	.float 2.5937, 0.0
	
	.text
	.globl main
main:

do:
	li $v0, 5
	syscall
	
	mtc1 $v0, $f2
	cvt.s.w $f2, $f2
	
	la $t1, const
	l.s $f4, 0($t1)
	l.s $f8, 4($t1)
	
	mul.s $f6, $f4, $f2
	
	li $v0, 2
	mov.s $f12, $f6
	syscall
	
	c.eq.s $f6, $f8
	bc1f do
	
	jr $ra