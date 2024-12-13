	.data
	
	.eqv MAX_STUDENTS, 3

avg:	.asciiz "\nMedia: "
	
nMEC:	.asciiz "N. Mec: "
name:	.asciiz "Primeiro Nome: "
Lname:	.asciiz "Ultimo Nome: "
grade: 	.asciiz "Nota: "
		
	.align 2
st_arr:	.space 176
	
	.align 2
media:	.space 4

const:	.float -20.0, 0.0
	
	.text
	
	.globl main
main:
	addiu $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	la $s0, st_arr
	la $s1, media

	move $a0, $s0
	li $a1, MAX_STUDENTS
	jal read_data
	
	move $a0, $s0
	li $a1, MAX_STUDENTS
	move $a2, $s1
	jal max
	
	move $t7, $v0
	
	li $v0, 4
	la $a0, avg
	syscall
	
	li $v0, 2
	l.s $f12, 0($s1)
	syscall
	li $v0, 11
	li $a0, '\n'
	syscall
	
	move $a0, $t7
	jal print_student

	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)	 
	addiu $sp, $sp, 12
	
	jr $ra
	
#********************************************************
read_data:
#	addiu $sp, $sp, -4
#	sw $ra, 0($sp)
	
	li $t0, 0
	move $t3, $a0
	move $t4, $a1
for_rd:
	bge $t0, $t4, endf_rd
	
	mulu $t1, $t0, 44
	addu $t2, $t3, $t1	#st[i]
	
	li $v0, 4
	la $a0, nMEC
	syscall
	
	li $v0, 5
	syscall
	sw $v0, 0($t2)	
	
	li $v0, 4
	la $a0, name
	syscall
	
	li $v0, 8
	addiu $a0, $t2, 4
	li $a1, 17
	syscall
	
	li $v0, 4
	la $a0, Lname
	syscall
	
	li $v0, 8
	addiu $a0, $t2, 22
	li $a1, 14
	syscall
	
	li $v0, 4
	la $a0, grade
	syscall
	
	li $v0, 6
	syscall
	s.s $f0, 40($t2)
	
	addiu $t0, $t0, 1
	
#	li $v0, 1
#	move $a0, $t0
#	syscall
#	li $v0, 11
#	li $a0, '\n'
#	syscall
	
#	move $a0, $t2
#	jal print_student
	
	j for_rd
endf_rd:
#	lw $ra, 0($sp)
#	addiu $sp, $sp, 4
	
	jr $ra

#********************************************************
max:
	la $t0, const
	l.s $f2, 0($t0)		# max_grade = -20.0
	l.s $f4, 4($t0)		# sum = 0.0
	
	move $t1, $a0		# p = st
	
	mulu $t2, $a1, 44
	addu $t3, $a0, $t2	# st + ns
for_max:
	bge $t1, $t3, endf_max
	
	l.s $f6, 40($t1)	# p->grade
	
	add.s $f4, $f4, $f6	# sum += p->grade
if_max:
	c.le.s $f6, $f2
	bc1t endif_max		#if(p->grade > max_grade)
	
	mov.s $f2, $f6		# max_grade = p->grade
	move $v0, $t1		# pmax = p
endif_max:
	addiu $t1, $t1, 44	# p++
	
	j for_max
endf_max:
	mtc1 $a1, $f10
	cvt.s.w $f16, $f10
	div.s $f8, $f4, $f16
	s.s $f8, 0($a2)
	
	jr $ra

#********************************************************
print_student:
	move $t0, $a0
	
	li $v0, 36
	lw $a0, 0($t0)
	syscall
	
	li $v0, 4
	addiu $a0, $t0, 4
	syscall
	
	li $v0, 4
	addiu $a0, $t0, 22
	syscall
	
	li $v0, 2
	l.s $f12, 40($t0)
	syscall
	
	jr $ra

#********************************************************