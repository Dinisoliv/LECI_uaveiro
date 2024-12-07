# Mapa de registo:
# $t0 : soma
# $t1 : i
# $t2 : array 
# $t3 : array + i
# $t4 : array[i]
	
	.data

array:	.word 7692, 23, 5, 234
	
	.eqv print_int10, 1
	.eqv SIZE, 4
		
	.text
	.globl main
main:
	li $t0, 0
	
	li $t1, 0
	
while:
	bge $t1, SIZE, endw
	
	la $t2, array
	sll $t3, $t1, 2
	addu $t3, $t3, $t2
	
	lw $t4, 0($t3)
	
	add $t0, $t0, $t4
	
	addi $t1, $t1, 1
	
	j while
	
endw: 
	li $v0, 1
	move $a0, $t0
	syscall