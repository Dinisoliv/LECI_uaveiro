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
	
for_i:
	bge $t2, 9, end_for_i
	
	addi $t3, $t2, 1
for_j:
	bge $t3, 10, end_for_j
	
	sll $t4, $t2, 2
	addu $t4, $t4, $t0
	lw $t6, 0($t4) 
	
	sll $t5, $t3, 2
	addu $t5, $t5, $t0
	lw $t7, 0($t5)
	
if:	ble $t6, $t7, endif

	sw $t6, 0($t5)
	sw $t7, 0($t4) 
	
endif:
	addi $t3, $t3, 1
	
	j for_j
	
end_for_j:

	addi $t2, $t2, 1
	
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