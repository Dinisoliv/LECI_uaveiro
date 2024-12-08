	.data
	
prompt: .asciiz "Introduza dois numeros: "
result: .asciiz "Resultado: "
	
	.text
	.globl main
main:
	li $t0, 0
	li $t4, 0
	
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	
	andi $t1, $v0, 0x0F  
	
	li $v0, 5
	syscall
	
	andi $t2, $v0, 0x0F
	
while:
	beq $t1, $0, endw
	bge $t0, 4, endw
	
	li $t3, 1
	and $t5, $t1, $t3
if:	beq $t5, $0, endif
		
	addu $t4, $t4, $t2
	
endif:
	sll $t2, $t2, 1
	srl $t1, $t1, 1
	
	addi $t0, $t0, 1
	
	j while
	
endw:
	li $v0, 4
	la $a0, result
	syscall
	
	li $v0, 1
	move $a0, $t4
	syscall
	
	jr $ra