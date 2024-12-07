# i: $t0
# lista: $t1
# lista + i: $t2 

	.data
	
	.align 2
array:	.space 20
		
str1:	.asciiz "\nIntroduza um numero:"
	
	.eqv SIZE, 5
	.eqv print_string, 4
	.eqv read_int, 5
	
	.text
	.globl main
	
main:
	li $t0, 0

while:
	bge $t0, SIZE, endw
	
	li $v0, print_string
	la $a0, str1
	syscall
	
	li $v0, read_int
	syscall
	move $t3, $v0
	
	la $t1, array
	sll $t2, $t0, 2
	addu $t2, $t2, $t1
	sw $t3, 0($t2)
	
	addi $t0, $t0, 1
	
	j while
endw:

	jr $ra