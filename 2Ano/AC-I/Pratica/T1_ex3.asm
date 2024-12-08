# Mapa de registos
# $t0 : n_even
# $t1 : n_odd
# $t2 : p1
# $t3 : p2
# $t4 : *p1 % 2
# $t5 : *p1
# $t6 : a + N
# $t7 : a
# $t8 : *p2
# %t9 : b + n_odd
	
	.data
	
	.eqv N, 10
	
arr_a:	.space 140
arr_b: 	.space 140
	
	.text
	.globl main
main:
	li $t0, 0
	li $t1, 0
	
	la $t2, arr_a
	
for1:
	li $t6, N
	sll $t6, $t6, 2
	la $t7, arr_a
	add $t6, $t6, $t7
	
	bge $t2, $t6, endf1
	
	li $v0, 5
	syscall
	
	move $t5, $v0
	
	sw $t5, 0($t2)
	
	addiu $t2, $t2, 4
	
	j for1 
	
endf1: 
	la $t2, arr_a
	la $t3, arr_b
	
for2:
	li $t6, N
	sll $t6, $t6, 2
	la $t7, arr_a
	add $t6, $t6, $t7
	
	bge $t2, $t6, endf2
	
	lw $t5, 0($t2)
	rem $t4, $t5, 2
	
if:	beq $t4, $0, else
	
	sw $t5, 0($t3)
	addiu $t3, $t3, 4
	addiu $t1, $t1, 1
	
	j endif
	
else:	addiu $t0, $t0, 1

endif:	
	addiu $t2, $t2, 4
	
	j for2
	
endf2:
	la $t3, arr_b

	sll $t1, $t1, 2
for3:
	la $t9, arr_b
	addu $t9, $t9, $t1
	
	bge $t3, $t9, endf3
	
	lw $t8, 0($t3)
	
	li $v0, 1
	move $a0, $t8
	syscall
	
	addiu $t3, $t3, 4
	
	j for3
	
endf3:

	jr $ra