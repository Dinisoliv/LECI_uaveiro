	.data
	
s2:
	.asciiz "Str_1"
	.space 8
	.word 2023
	.double 2.718281828459045
	.asciiz "Str_2"
	
const:	.double 0.35
	
	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $a0, s2
	jal f2
	
	mov.d $f12, $f0 
	li $v0, 3
	syscall
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra
#**************************************
f2:	
	l.d $f2, 24($a0)
	lw $t1, 16($a0)
	mtc1 $t1, $f4
	cvt.d.w $f4, $f4
	
	mul.d $f0, $f2, $f4
	
	la $t0, const
	l.d $f8, 0($t0)
	
	div.d $f0, $f0, $f8
	
	jr $ra
	
#**************************************