	.data

array:	.word 8, 4, 15, -1987, 327, -9, 27, 16
	
str:	.asciiz "Result is: "
	
	.eqv SIZE, 8
		
	.text
	.globl main
main:
	li $t0, 0
	
do1:
	la $t1, array
	sll $t2, $t0, 2
	addu $t1, $t1, $t2
	
	lw $t3, 0($t1)
	
	li $t4, SIZE
	sll $t4, $t4, 1
	addu $t5, $t4, $t1
	
	lw $t6, 0($t5)
	
	sw $t6, 0($t1)
	
	sw $t3, 0($t5)
	
	addiu $t0, $t0, 1
	srl $t4, $t4, 2
	
	blt $t0, $t4, do1
	
	li $v0, 4
	la $a0, str
	syscall
	
	li $t0, 0
	
do2:
	la $t1, array
	sll $t2, $t0, 2
	addu $t1, $t1, $t2
	
	li $v0, 1
	lw $a0, 0($t1)
	syscall
	
	addiu $t0, $t0, 1
	
	li $v0, 11
	li $a0, ','
	syscall
	
	blt $t0, SIZE, do2
	
	jr $ra