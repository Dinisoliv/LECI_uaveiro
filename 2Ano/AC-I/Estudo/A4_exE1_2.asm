	.data 
	
	.eqv SIZE, 20
	
string:	.space 21
	
str1:	.asciiz "Introduza uma string: "
	
	.text
	.globl main
	
main:
	li $v0, 4
	la $a0, str1
	syscall
	
	li $v0, 8
	la $a0, string
	li $a1, SIZE
	syscall
	
	la $t0, string
	
while:
	lb $t1, 0($t0)
	
	beq $t1, '\0', endw

	li $t2, 'A' 	#0x41
	li $t3, 'Z'	#0x5A
	
	blt $t1, $t2, skip_convert
	bgt $t1, $t3, skip_convert
	
	li $t4, 'a'
	
	sub $t1, $t1, $t2
	add $t1, $t1, $t4
	
	sb $t1, 0($t0)
	
skip_convert:

	addiu $t0, $t0, 1
	
	j while
endw:
	li $v0, 4
	la $a0, string
	syscall
	
	jr $ra