	.data
	
stg:	.space 44
	
nmec: 	.asciiz "\nN. Mec: "
name: 	.asciiz "\nNome: "
nota: 	.asciiz "\nNota: "
fname: .asciiz "\nPrimeiro Nome: "
lname: .asciiz "\nÚltimo Nome: "
	
	.text
	.globl main
main:
	la $t0, stg
	
	li $v0, 4
	la $a0, nmec
	syscall
	
	li $v0, 5
	syscall
	
	sw $v0, 0($t0)
	
	li $v0, 4
	la $a0, fname
	syscall
	
	li $v0, 8
	addiu $a0, $t0, 4
	li $a1, 18
	syscall
	
	li $v0, 4
	la $a0, lname
	syscall
	
	li $v0, 8
	addiu $a0, $t0, 22
	li $a1, 15
	syscall
	
	li $v0, 4
	la $a0, nota
	syscall
	
	li $v0, 6
	syscall
	
	s.s $f0, 40($t0)
	
	#=================
	
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