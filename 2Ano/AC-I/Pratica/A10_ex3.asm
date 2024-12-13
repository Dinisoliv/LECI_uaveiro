	.data
	
	.eqv SIZE, 5
	
zero:	.double 0.0
const:	.double 1.0, 0.0, 0.5
	
	.align 3
arr:	.space 40
	
	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $t0, 0
	la $t1, arr
	
for:	bge $t0, SIZE, endf
	
	sll $t2, $t0, 3
	addu $t3, $t2, $t1
	
	li $v0, 7
	syscall
	
	s.d $f0, 0($t3)
	
	addiu $t0, $t0, 1
	j for
endf:
	la $a0, arr
	li $a1, SIZE
	jal average
	mov.d $f12, $f0
	
	la $a0, arr
	li $a1, SIZE
	jal var
	mov.d $f12, $f0
	
	la $a0, arr
	li $a1, SIZE
	jal stdev
	mov.d $f12, $f0
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra
#****************************************************
# $s0: array
# $s1: nval
# $s2: i
# $f20: media
# $f22: soma
var:
	addiu $sp, $sp, -32
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	s.d $f20, 16($sp)
	s.d $f22, 24($sp)
	
	move $s0, $a0
	move $s1, $a1
	
	jal average
	cvt.s.d $f20, $f0		# mov.d $f20, $f0

	li $s2, 0
	la $t0, zero
	l.s $f22, 0($t0)
for_var:
	bge $s2, $s1, endf_var
	
	sll $t1, $s2, 3
	addu $t3, $t1, $s0
	l.d $f2, 0($t3)
	cvt.s.d $f12, $f2
	sub.s $f12, $f12, $f20			# sub.d $f12, $f2, $f20

	li $a0, 2
	
	jal xtoy
	
	add.s $f22, $f22, $f0
	
	addiu $s2, $s2, 1
	j for_var
	
endf_var:
	cvt.d.s $f6, $f22
	mtc1 $s1, $f4
	cvt.d.w $f4, $f4
	div.d $f0, $f6, $f4

	l.d $f22, 24($sp)
	l.d $f20, 16($sp)
	lw $s2, 12($sp)
	lw $s1, 8($sp)
	lw $s0, 4($sp)	
	lw $ra, 0($sp)
	addiu $sp, $sp, 24
	
	jr $ra
#****************************************************
stdev:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal var
	mov.d $f12, $f0
	jal sqrt
	
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
xtoy:
	addiu $sp, $sp, -20
	sw $ra, 0($sp)			
	sw $s0, 4($sp)			# y
	sw $s1, 8($sp)			# i
	s.s $f20, 12($sp)		# x
	s.s $f22, 16($sp)		# result
	#====================
	
	mov.s $f20, $f12
	move $s0, $a0
	
	li $s1, 0
	
	la $t0, const
	l.s $f22, 0($t0)
	
for_xtoy:
	move $a0, $s0
	jal abs
	
	bge $s1, $v0, endf_xtoy
	
if_xtoy:
	bltz $s0, else_xtoy
	
	mul.s $f22, $f22, $f20 
	
	j endif_xtoy
else_xtoy:
	div.s $f22, $f22, $f20 
endif_xtoy:
	addiu $s1, $s1, 1
		
	j for_xtoy 
	
endf_xtoy:
	mov.s $f0, $f22
	
	#====================
	l.s $f22, 16($sp)
	l.s $f20, 12($sp)
	lw $s1, 8($sp)
	lw $s0, 4($sp)
	lw $ra, 0($sp)
	addiu $sp, $sp, 20

	jr $ra
	
#********************************************
abs:
if_abs:
	bgtz $a0, endif_abs
	
	nor $a0, $a0, $0
	addi $a0, $a0, 1 
	
endif_abs:
	move $v0, $a0
	
	jr $ra
#********************************************
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