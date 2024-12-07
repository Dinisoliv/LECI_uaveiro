# Mapa de registos:
# value: $t0
# bit: $t1
# i: $t2 	
	.data
	
str1:	.asciiz "Introduza um numero: "
str2:	.asciiz "\nO valor em binário é: "
char1:	.asciiz "1"
char0:	.asciiz "0" 
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
	
	li $t2, 0
	li $t3, 0x80000000
	
while:	bge $t2, 32, endw	#while (i<32)
	
	rem $t4, $t2, 4
	bne $t4, $0, skipif
	li $v0, 4
	la $a0, space
	syscall
skipif:
	and $t1, $t0, $t3
	srl $t1, $t1, 31 
	addi $t1, $t1, 0x30
	
	#beq $t1, $0, else	#if (bit != 0)
	li $v0, 11		
	move $a0, $t1
	#la $a0, char1
	syscall
	#j endif
	
#else:
	#li $v0, 11
	#la $a0, char0
	#syscall
endif:
	sll $t0, $t0, 1
	addi $t2, $t2, 1
	j while
	
endw:
	jr $ra