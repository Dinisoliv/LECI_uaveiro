	.data
	
	.eqv SIZE, 10
	
array:	.space SIZE
	
	.text
	.globl main
main:
	la $t0, array
	
	li $t1, SIZE
	sll $t1, $t1, 2
	add $t1, $t0, $t1  
	
input:
	bge $t0, $t1, end_input
	
	li $v0, 5
	syscall
	
	sw $v0, 0($t0)
	
	addiu $t0, $t0, 4
	
	j input
	
end_input:
	
	la $t0, array
	li $t1, SIZE
	addi $t1, $t1, -1
	addi $t9, $t9, 1
	
	li $t2, 0
	
	
	la $t0, array
	li $t1, SIZE
	addi $t1, $t1, -1
	sll $t1, $t1, 2
	addu $t2, $t0, $t1
	
for_i:
	bge $t0, $t2, end_for_i
	
	addiu $t3, $t0, 4
	addiu $t4, $t2, 4
	
for_j:
	bge $t3, $t4, end_for_j

	lw $t5, 0($t0)
	lw $t6, 0($t3)

if:	ble $t5, $t6, endif
	move $t7, $t5
	sw $t6, 0($t0)
	sw $t7, 0($t3)
	
endif:

	addiu $t3, $t3, 4

	j for_j
	
end_for_j:

	addiu $t0, $t0, 4 
	
	j for_i
	
end_for_i:


	la $t0, array
	li $t1, SIZE
	
	sll $t1, $t1, 2
	addu $t1, $t0, $t1
	
output:
	bge $t0, $t1, end_out
	
	lw $a0, 0($t0)
	
	li $v0, 1
	syscall
	
	li $v0, 11
	li $a0, ';'
	syscall
	
	addiu $t0, $t0, 4
	
	j output
end_out:

	jr $ra