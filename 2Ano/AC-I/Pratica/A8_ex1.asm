	.data
	
str1: 	.asciiz "2020 e 2024 sao anos bissextos"
str2:	.space 21
	
	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $a0, str1
	jal atoi
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	
	li $v0, 8
	la $a0, str2
	li $a1, 20
	syscall
	
	la $a0, str2
	jal atoi2
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra

#********************************************************
atoi:
	li $v0, 0
while:
	lb $t0, 0($a0)
	blt $t0, '0', endw
	bgt $t0, '9', endw
	
	li $t2, '0'
	subu $t1, $t0, $t2
	addiu $a0, $a0, 1
	
	mulu $v0, $v0, 10
	addu $v0, $v0, $t1
	
	j while 
endw:
	jr $ra
#********************************************************
atoi2:
	li $v0, 0
while2:
	lb $t0, 0($a0)
	blt $t0, '0', endw
	bgt $t0, '1', endw
	
	li $t2, '0'
	subu $t1, $t0, $t2
	addiu $a0, $a0, 1
	
	mulu $v0, $v0, 2
	addu $v0, $v0, $t1
	
	j while2
endw2:
	jr $ra

#********************************************************