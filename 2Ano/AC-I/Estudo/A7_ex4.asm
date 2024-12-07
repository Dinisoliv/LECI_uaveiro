	.data
	
	.text
	.globl main
main:


#************************************************
strcat:
	addiu $sp, $sp, -4
	sw $s0, 0($sp)
	
	move $s0, $a0
	move $t0, $a0
while:
	beq $t0, '\0', endw
	addiu $t0, $t0, 1
endw:
	move $a0, $t0
	jal strcpy
	
	move $v0, $a0
	
	lw $s0, 0($sp)
	addiu $sp, $sp, 4

	jr $ra

#*********************************************
# Mapa de registos:
# $t0: i
# $t1: 
strcpy:
	li $t0, 0
do:	
	addu $t2, $a0, $t0
	addu $t3, $a1, $t0
	
	lb $t1, 0($t3)
	sb $t1, 0($t2)
	
	addiu $t0, $t0, 1
	
	bne $t1, '\0', do
	
	move $v0, $a0
	
	jr $ra
#*********************************************