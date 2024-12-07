# Mapa de registos
# p: $t0
# *p: $t1
# lista+Size: $t2
	
	.data

array:	.word 8, -4, 3, 5, 124, -15, 87, 9, 27, 15

str1:	.asciiz "\nConteudo do array:\n"
coma:	.asciiz "; "
	
	.eqv print_string, 4
	.eqv print_int10, 1
	.eqv SIZE, 10
		
	.text
	.globl main
	
main:
	li $v0, print_string
	la $a0, str1
	syscall
	
	la $t0, array
	
	li $t3, SIZE
	sll $t3, $t3, 2
	add $t2, $t0, $t3
	
while:
	bge $t0, $t2, endw
	
	lw $t1, 0($t0)
	
	li $v0, print_int10
	move $a0, $t1
	syscall
	
	li $v0, print_string
	la $a0, coma
	syscall
	
	addi $t0, $t0, 4
	
	j while
	
endw:
	jr $ra
	
