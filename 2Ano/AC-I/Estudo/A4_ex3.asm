# Mapa de registos
# p: $t0
# pultimo:$t1
# *p: $t2
# soma: $t3

	.data
	
array:	.word 7692, 23, 5, 234
	
	.eqv print_int10, 1
	.eqv SIZE, 4
	
	.text
	.globl main
	
main:
	li $t3, 0
	
	li $t4, SIZE
	addi $t4, $t4, -1
	sll $t4, $t4, 2
	
	la $t0, array
	addu $t1, $t0, $t4 
	
while:
	bgt $t0, $t1, endw
	lw $t2, 0($t0)
	add $t3, $t3, $t2
	
	addi $t0, $t0, 4
	
	j while
endw:
	li $v0, print_int10
	move $a0, $t3
	syscall
	
	jr $ra
	
