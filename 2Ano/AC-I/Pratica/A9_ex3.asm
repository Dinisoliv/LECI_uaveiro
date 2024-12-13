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
	jal average
	
	mov.d $f12, $f0
	li $v0, 3
	syscall
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra
	
#******************************************
average:
	addiu $t0, $a1, -1
	la $t1, zero
	l.d $f2, 0($t1)
	
for_avg:
	blt $t0, $0, endf_avg
	
	sll $t2, $t0, 3
	addu $t3, $t2, $a0
	l.d $f4, 0($t3) 
	
	add.d $f2, $f2, $f4 
	
	addiu $t0, $t0, -1
	
	j for_avg
endf_avg:
	mtc1 $a1, $f6
	cvt.d.w $f8, $f6
	div.d $f0, $f2, $f8
	
	jr $ra
	
#******************************************
