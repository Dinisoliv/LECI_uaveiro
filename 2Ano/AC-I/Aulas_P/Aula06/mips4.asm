	.data
	
nrpara:	.asciiz "Nr. de parametros: "
new_l:	.asciiz "\nP"
space:	.asciiz ": "

	.eqv print_string, 4
		
	.text
	.globl main
main:
	li $v0, print_string
	la $a0, nrpara
	syscall
	