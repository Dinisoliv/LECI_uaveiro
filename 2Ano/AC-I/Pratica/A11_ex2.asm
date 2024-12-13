	.data
	
s1:
	.asciiz "St1"
	.space 6
	#.space 6
	.double 3.141592653589
	.word 291, 756
	.byte 'X'
	#.space 3
	.float 1.983
	
	.text
	.globl main
main:
	addiu $sp, $sp, -4 
	sw $ra, 0($sp)
	
	jal f1
	
	mov.s $f12, $f0	
	li $v0, 2
	syscall
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra
	
#**********************************************	
f1:
	la $t0, s1
	
	l.d $f2, 16($t0)
	lw $t1, 28($t0)
	mtc1 $t1, $f4
	cvt.d.w $f4, $f4
	l.s $f6, 36($t0)
	cvt.d.s $f6, $f6
	
	mul.d $f0, $f2, $f4
	div.d $f0, $f0, $f6
	
	cvt.s.d $f0, $f0
	
	jr $ra
	
#**********************************************