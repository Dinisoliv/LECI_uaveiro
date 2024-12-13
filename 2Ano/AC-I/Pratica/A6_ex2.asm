# p : $t1
# pultimo: $t2 
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
	la $t1, array
	
	li $t0, SIZE
	sll $t0, $t0, 2
	
	add $t2, $t1, $t0
	
while:
	bge $t1, $t2, endw
	
	lw $a0, 0($t1)
	
	li $v0, print_string
	syscall
	
	li $v0, print_char
	li $a0, '\n'
	syscall
	
	addi $t1, $t1, 4

	j while
		
endw:
	jr $ra
