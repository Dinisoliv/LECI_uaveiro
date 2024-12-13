	.data
	
str1:	.asciiz "Arquitetura de "
str2:	.space 50
str3: 	.asciiz "Computadores I"
	
	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $a0, str2
	la $a1, str1
	jal strcpy
	
	move $a0, $v0
	li $v0, 4
	syscall
	
	li $v0, 11
	li $a0, '\n'
	syscall
	
	la $a0, str2
	la $a1, str3
	jal strcat
	
	move $a0, $v0
	li $v0, 4
	syscall
	
	sw $ra, 0($sp)
	addiu $sp, $sp, 4

	jr $ra

#************************************************
strcat:
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	
	move $s0, $a0
while:
	lb $t1, 0($a0)
	
	beq $t1, '\0', endw
	addiu $a0, $a0, 1
	j while
endw:
	jal strcpy
	
	move $v0, $s0
	
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	addiu $sp, $sp, 8

	jr $ra

#*********************************************
# Mapa de registos:
# $t0: i
# $t1: 
strcpy:
	li $t0, 0
do:	
	addu $t2, $a0, $t0
	addu $t3, $a1, $t0
	
	lb $t1, 0($t3)
	sb $t1, 0($t2)
	
	addiu $t0, $t0, 1
	
	bne $t1, '\0', do
	
	move $v0, $a0
	
	jr $ra
#*********************************************