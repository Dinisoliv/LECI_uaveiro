	.data
	
str0:	.asciiz "Array"
str1:	.asciiz "de"
str2:	.asciiz "ponteiros"
strn:	.asciiz "\nString #"
newstr: .asciiz  ": " 

array:	.word str0, str1, str2
	
	.eqv SIZE, 3
	.eqv print_string, 4
	.eqv print_char, 11
	.eqv print_int10, 1
	
	.text
	.globl main
	
main:
	li $t0, 0
	
while:
	bge $t0, SIZE, endw
	
	li $v0, print_string
	la $a0, strn
	syscall
	
	li $v0, print_int10
	move $a0, $t0
	syscall
	
	li $v0, print_string
	la $a0, newstr
	syscall
	
	li $t1, 0
	
inner_loop:
	la $t3, array
	sll $t2, $t0, 2
	addu $t3, $t3, $t2
	lw $t3, 0($t3)
	addu $t3, $t3, $t1
	lb $t3, 0($t3)
	
	beq $t3, '\0', end_inner
	
	li $v0, print_char
	move $a0, $t3
	syscall
	
	li $a0, '-'
	syscall
	
	addi $t1, $t1, 1
	
	j inner_loop

end_inner:
	addi $t0, $t0 , 1
	
	j while

endw:
	jr $ra