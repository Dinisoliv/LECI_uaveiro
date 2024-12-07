	.data
	
lista:	.word 8, -4, 3, 5, 124, -15, 87, 9, 27, 15
	
str1: 	.asciiz "\nConteudo do array: \n"
str2: 	.asciiz "; "
	.text
	.globl main
	
main:
	la $a0, str1
	li $v0, 4
	syscall
	
	la $t0, lista
	li $t3 , 10
	sll $t3, $t3, 2
	addu $t2, $t0, $t3
	
while:
	bgeu $t0, $t2, endw
	
	lw $t1, 0($t0)
	
	move $a0, $t1
	li $v0, 1
	syscall
	
	la $a0, str2
	li $v0, 4
	syscall
	
	addiu $t0, $t0, 4
	
	j while

endw:

	jr $ra