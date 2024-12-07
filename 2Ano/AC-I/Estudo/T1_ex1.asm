	.data 
	
str:	.asciiz "Digite ate 20 inteiros (zero para terminar):"
outstr: .asciiz "Máximo/mínimo são: "
	
	.eqv min, 0x7FFFFFFF
	.eqv max, 0x80000000
	
	.text
	.globl main
main:
	li $v0, 4
	la $a0, str
	syscall
	
	li $t0, 0
	
	lui $t2, 0x7FFF
	ori $t2, $t2 ,0xFFFF
	
	lui $t1, 0x8000
	ori $t1, $t1, 0x0000
	
do:
	li $v0, 5
	syscall
	
	move $t3, $v0
	
if:	beq $t3, $0, endif

	ble $t3, $t1, notmax
	move $t1, $t3
notmax:	
	bge $t3, $t2, notmin 	
	move $t2, $t3
notmin:
endif:
	addiu $t0, $t0, 1
	
	bge $t0, 20, doend
	bne $t3, $0, do

doend:	
	li $v0, 4
	la $a0, outstr
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 11
	li $a0, ':'
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	jr $ra



	
