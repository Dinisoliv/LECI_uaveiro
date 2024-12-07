	.data
	
stg:	.space 44
	
nLine: 	.asciiz "\n"          # Quebra de linha
nmecL: 	.asciiz "N. Mec: "
nameL: 	.asciiz "Nome: "
fnameL: .asciiz "Primeiro Nome: "
lnameL: .asciiz "Último Nome: "
notaL: 	.asciiz "Nota: "
comma: 	.asciiz ","
	
	.text
	.globl main
	
main:
	la $t0, stg
	
	li $v0, 4
	la $a0, nmecL
	syscall
	
	#read_int(stg.id_number)
	li $v0, 5
	syscall
	sw $v0, 0($t0)
	
	li $v0, 4
	la $a0, nLine
	syscall
	li $v0, 4
	la $a0, fnameL
	syscall 
	
	#read_string(stg.last_name)
	li $v0, 8
	addiu $a0, $t0, 4
	li $a1, 18
	syscall
	
	li $v0, 4
	la $a0, nLine
	syscall
	li $v0, 4
	la $a0, lnameL
	syscall 
	
	#read_string(stg.first_name)
	li $v0, 8
	addiu $a0, $t0, 22
	li $a1, 15
	syscall
	
	li $v0, 4
	la $a0, nLine
	syscall
	
	li $v0, 4
	la $a0, notaL
	syscall
	
	#read_float(stg.grade)
	li $v0, 6
	syscall
	s.s $f0, 40($t0)
	
	li $v0, 4
	la $a0, nmecL
	syscall
	
	#print_int10(stg.id_number)
	li $v0, 36
	lw $a0, 0($t0)
	syscall
	
	li $v0, 4
	la $a0, nLine
	syscall
	li $v0, 4
	la $a0, nameL
	syscall 
	
	#print_string(stg.last_name)
	li $v0, 4
	addiu $a0, $t0, 22
	syscall
	
	li $v0, 4
	la $a0, comma
	syscall
	
	#print_string(stg.first_name)
	li $v0, 4
	addiu $a0, $t0, 4
	syscall
	
	li $v0, 4
	la $a0, nLine
	syscall
	
	li $v0, 4
	la $a0, notaL
	syscall
	
	#print_float(stg.grade)
	li $v0, 2
	l.s $f12, 40($t0)
	syscall
	
	jr $ra 
	