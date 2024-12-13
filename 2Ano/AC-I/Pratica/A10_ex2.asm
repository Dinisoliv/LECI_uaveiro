	.data
	
	.align 3
const:	.double 1.0, 0.0, 0.5

	.text
	.globl main	
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $v0, 7
	syscall
	
	mov.d $f12, $f0
	jal sqrt
	
	li $v0, 3
	mov.d $f12, $f0
	syscall
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4

	jr $ra
#************************************************
# Mapa de registos:
# $f0: xn
# $f2/$f6: const
# $f4: aux
# $f8: inter.
# $f12: val  
sqrt:
	la $t1, const
	l.d $f0, 0($t1)
	
	li $t0, 0
if_sqrt:
	l.d $f2, 8($t1)
	c.le.d $f12, $f2
	bc1t else_sqrt
do_sqrt:
	mov.d $f4, $f2
	
	l.d $f6, 16($t1)
	div.d $f8, $f12, $f0
	add.d $f8, $f8, $f0
	mul.d $f0, $f6, $f8
	
	addiu $t0, $t0, 1
	
	c.eq.d $f4, $f0
	bc1t endif_sqrt
	bge $t0, 25, endif_sqrt

	j do_sqrt
	
else_sqrt:
	mov.d $f0, $f2
endif_sqrt:
	
	jr $ra
	
#************************************************