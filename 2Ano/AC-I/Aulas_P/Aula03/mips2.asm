	.data 
	
str1:	.asciiz 
str2:	.asciiz 
	
	.eqv print_string, 4
	.eqv print, int10, 3
	.eqv read_int10, 1
	
	.text
	.globl main

main:	
	li $t0, print_str
		