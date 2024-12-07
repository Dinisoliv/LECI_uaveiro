# Mapa de registos:
# gray: $t0
# mask: $t1
# bin: $t2 	
	.data
	
str1:	.asciiz "Introduza um numero: "
prtgray: .asciiz "\nValor em código Gray: "
prtbin:	.asciiz "\nValor em binario: "

	.eqv print_string, 4
	.eqv read_int, 5
	.eqv print_bin, 35

	.text
	.globl main
	
main:
	li $v0, print_string
	la $a0, str1
	syscall
	
	li $v0, read_int
	syscall
	
	move $t0, $v0
	
	srl $t1, $t0, 1
	move $t2, $t0
	
while:
	beq $t1, $0, endw
	
	xor $t2, $t2, $t1
	srl $t1, $t1, 1
	
	j while

endw:
	li $v0, print_string
	la $a0, prtgray
	syscall
	
	li $v0, print_bin
	move $a0, $t0
	syscall
	
	li $v0, print_string
	la $a0, prtbin
	syscall
	
	li $v0, print_bin
	move $a0, $t2
	syscall
	
	jr $ra