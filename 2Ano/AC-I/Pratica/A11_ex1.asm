	.data
	
stg:
	.word 72343
	.asciiz "Napoleao"
	.space 9
	.asciiz "Bonaparte"
	.space 5
	.space 3
	.float 5.1
	
nmec: 	.asciiz "\nN. Mec: "
name: 	.asciiz "\nNome: "
nota: 	.asciiz "\nNota: "

	
	.text
	.globl main
main:
	la $t0, stg
	
	li $v0, 4
	la $a0, nmec
	syscall
	
	li $v0, 36
	lw $a0, 0($t0)
	syscall
	
	li $v0, 4
	la $a0, name
	syscall

	li $v0, 4
	addiu $a0, $t0, 4
	syscall

	li $v0, 11
	li $a0, ','
	syscall
	
	li $v0, 4
	addiu $a0, $t0, 22
	syscall
			
	li $v0, 4
	la $a0, nota
	syscall
	
	li $v0, 2
	l.s $f12, 40($t0)
	syscall
	
	jr $ra