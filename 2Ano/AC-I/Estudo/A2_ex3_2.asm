	.data
	
str1:	.asciiz "Introduza 2 numeros\n"
str2:	.asciiz "A soma dos dois numeros e': "
	
	.eqv print_string, 4
	.eqv read_int, 5
	.eqv print_int10, 1
	
	.text
	.globl main
	
main:	la $a0, str1
	ori $v0, $0, print_string
	syscall
	
	ori $v0, $0, read_int
	syscall
	move $t0, $v0
	
	ori $v0, $0, read_int
	syscall
	move $t1, $v0
	
	add $t2, $t1, $t0
	
	move $a0, $t2
	ori $v0, $0, print_int10
	syscall