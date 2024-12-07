	.data
	
const:	.float 2.59375, 0.0
	
	.text
	.globl main
main:
	
do:
	li $v0, 5
	syscall
	
	move $t0, $v0
	
	mtc1 $t0, $f0
	cvt.s.w $f0, $f0
	
	la $t1, const
	l.s $f2, 0($t1)
	l.s $f6, 4($t1)
	
	mul.s $f4, $f0, $f2
	
	li $v0, 2
	mov.s $f12, $f4
	syscall
	
	c.eq.s $f4, $f6
	bc1f do
	
	jr $ra
	
	