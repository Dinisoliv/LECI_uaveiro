	.data
	
str0:	.asciiz "Array"
str1:	.asciiz "de"
str2:	.asciiz "ponteiros"

array:	.word str0, str1, str2
	
	.eqv SIZE, 3
	.eqv print_string, 4
	.eqv print_char, 11
	
	.text
	.globl main
	
main:
	li $t0, 0
	
while:
	bge $t0, SIZE, endw
	
	la $t1, array
	sll $t2, $t0, 2
	addu $t1, $t1, $t2
	lw $a0, 0($t1)
	
	li $v0, print_string
	syscall
	
	li $v0, print_char
	li $a0, '\n'
	syscall
	
	addi $t0, $t0, 1
	
	j while
	
endw:
	jr $ra
