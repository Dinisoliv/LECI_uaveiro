# Mapa de registos:
# value: $t0
# bit: $t1
# i: $t2 	
	.data
	
str1:	.asciiz "Introduza um numero: "
str2:	.asciiz "\nO valor em binário é: "
space:	.asciiz " "

	.text
	.globl main
	
main:
	li $v0, 4
	la $a0, str1
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $v0, 4
	la $a0, str2
	syscall
	
	li $t2, 0
	li $t3, 0
	#li $t4, 0x80000000
	
while:	bge $t2, 32, endw	#while (i<32)
	
	#and $t1, $t0, $t4
	srl $t1, $t0, 31 
	
	bne $t3, $0, printbit	
	bne $t1, $0, printbit
	
	j nextbit
printbit:
	li $t3, 1
	
	rem $t5, $t2, 4
	bne $t5, $0, nospace
	li $v0, 4
	la $a0, space
	syscall
nospace:
	addi $t1, $t1, 0x30
	
	li $v0, 11		
	move $a0, $t1
	syscall
	
nextbit:
	sll $t0, $t0, 1
	
	addi $t2, $t2, 1
	j while
	
endw:
	jr $ra