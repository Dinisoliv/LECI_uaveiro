	.data
	
str1:	.asciiz "Nr. de parametros: "
str2: 	.asciiz "\nP"
str3: 	.asciiz ": "

	.eqv shft_amnt, ?

	.text
	.globl main
main:
	move $t1, $a0
	
	li $v0, 4
	la $a0, str1
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $t0, 0
	
for:
	bge $t0, $t1, endf
	
	li $v0, 4
	la $a0, str2
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, str3
	syscall	
	
	sll $t2, $t0, shft_amnt 
	
	move $t4, $a1
	
	addu $t3, $t2, $t4
	
	lw $t5, 0($t3)
	
	li $v0, 4
	move $a0, $t5
	syscall 
	
	j for

endf:
	jr $ra