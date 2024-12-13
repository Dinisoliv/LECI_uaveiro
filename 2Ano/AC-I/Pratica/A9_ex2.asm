	.data
	
const:	.double 5.0, 9.0, 32.0
zero:	.double 0.0
const2:	.double 100.0
	
	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $t0, zero
	l.d $f12, 0($t0)
	l.d $f2, 0($t0)
	
	la $t1, const2
	l.d $f22, 0($t1)

while:
	c.le.d $f2, $f22
	bc1f endw
	
	li $v0, 7
	syscall
	
	mov.d $f12, $f0
	jal f2c
	
	mov.d $f2, $f0
	
	li $v0, 3
	mov.d $f12, $f0
	syscall
	
	j while
endw:
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra
	
#*********************************************
f2c:
	la $t0, const
	l.d $f2, 0($t0)
	l.d $f4, 8($t0)
	l.d $f6, 16($t0)
	
	div.d $f0, $f2, $f4
	sub.d $f8, $f12, $f6
	mul.d $f0, $f0, $f8
	
	jr $ra
#*********************************************