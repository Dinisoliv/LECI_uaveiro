	.data
	
zero:	.double 0.0
	
	.eqv SIZE, 4
	
array:	.space 80
	
	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $t0, 0
for:
	bge $t0, SIZE, endf
	
	li $v0, 7
	syscall
	
	la $t2, array
	sll $t1, $t0, 3
	addu $t3, $t2, $t1
	
	s.d $f0, 0($t3)
	
	addiu $t0, $t0, 1
 
	j for
endf:
	move $a0, $t2
	li $a1, SIZE
	jal max
	
	mov.d $f12, $f0
	li $v0, 3
	syscall
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra
	
#******************************************
max:
	move $t0, $a0
	addi $a1, $a1, -1
	sll $a1, $a1, 3
	addu $t1, $t0, $a1

	l.d $f2, 0($t0)
	addiu $t0, $t0, 8
for_max:
	bgt $t0, $t1, endf_max
	
	l.d $f4, 0($t0)
	
if_max:	
	c.le.d $f4, $f2
	bc1t endif_max
	
	mov.d $f2, $f4

endif_max:	 
	addiu $t0, $t0, 8
	
	j for_max
endf_max:
	
	mov.d $f0, $f2
	
	jr $ra
	
#******************************************