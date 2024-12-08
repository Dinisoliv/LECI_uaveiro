# i: $t0
# lista: $t1
# lista + i: $t2

	.data 
	
ptr_str:
	.asciiz "\nInsert number: "
	
	.align 2
lista:	.space 20
	
	
	.text
	.globl main
	
main:	
	li $t0, 0		#i = 0
while:
	bge $t0, 5, endw		#while i < SIZE
	
	#imprimir string
	la $a0, ptr_str
	li $v0, 4
	syscall
	
	#ler inteiro
	li $v0, 5
	syscall
	move $t3, $v0
	
	#calcular endereço lista[i]
	la $t1,lista
	sll $t2, $t0, 2
	addu $t2, $t1, $t2	
	sw $t3, 0($t2)
	addi $t0, $t0, 1
	
	j while
	
endw:
	jr $ra