	.data
	
str:	.space 34
buf:	.space 34
prompt:	.asciiz "test"
	
	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
do: 
	li $v0, 5
	syscall
	move $s6, $v0
	
	move $a0, $s6
	li $a1, 2
	la $a2, str
	jal print_int_ac1
	li $v0, 11
	li $a0, '\n'
	syscall
#	move $a0, $s6
#	li $a1, 2
#	la $a2, str
#	jal itoa
	
#	move $a0, $v0
#	li $v0, 4
#	syscall
#	li $v0, 11
#	li $a0, '\n'
#	syscall
	
	move $a0, $s6
	li $a1, 8
	la $a2, str
	jal print_int_ac1
	li $v0, 11
	li $a0, '\n'
	syscall
#	move $a0, $s6
#	li $a1, 8
#	la $a2, str
#	jal itoa

#	move $a0, $v0
#	li $v0, 4
#	syscall
#	li $v0, 11
#	li $a0, '\n'
#	syscall
	
	move $a0, $s6
	li $a1, 16
	la $a2, str
	jal print_int_ac1
	li $v0, 11
	li $a0, '\n'
	syscall
#	move $a0, $s6
#	li $a1, 16
#	la $a2, str
#	jal itoa
	
#	move $a0, $v0
#	li $v0, 4
#	syscall
#	li $v0, 11
#	li $a0, '\n'
#	syscall
	
	bne $s6, $0, do
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4

	jr $ra

#*********************************************
# Mapa de registos
# n: $a0 -> $s0
# b: $a1 -> $s1
# s: $a2 -> $s2
# p: $s3
# digit: $t0 
itoa:
	addiu $sp, $sp, -20
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	move $s3, $a2
	
do_itoa:	
	rem $t1, $s0, $s1
	div $s0, $s0, $s1
	
	move $a0, $t1
	jal toascii
	
	sb $v0, 0($s3)
	addiu $s3, $s3, 1
	
	bgt $s0, $0, do_itoa 

	sb $0, 0($s3)
	
	move $a0, $s2
	jal strrev

	move $v0, $s2	 
	
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	addiu $sp, $sp, 20
	
	jr $ra
	
#*********************************************
toascii:
	addi $v0, $a0, '0'
if:	
	ble $v0, '9', endif
	addi $v0, $v0, 7
endif:
	jr $ra

#*********************************************
print_int_ac1:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $a2, buf
	jal itoa
	
	move $a0, $v0
	li $v0, 4
	syscall
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra
		
#*********************************************
# Mapa de registos:
# str: $a0 -> $s0 (argumento é passado em $a0)
# p1: $s1 (registo callee-saved)
# p2: $s2 (registo callee-saved)
# p2* : $t0

strrev: 
	addiu $sp, $sp, -16
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	
	move $s0, $a0
	move $s1, $a0
	move $s2, $a0
	
while1:
	lb $t0, 0($s2)
	beq $t0, '\0', endw1
	addiu $s2, $s2, 1
	
	j while1
endw1:
	addiu $s2, $s2, -1

while2:
	bgeu $s1, $s2, endw2
	
	move $a0, $s1
	move $a1, $s2
	jal exchange
	
	addiu $s1, $s1, 1
	addiu $s2, $s2, -1
	
	j while2
endw2:
	move $v0, $s0
	
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	
	addiu $sp, $sp, 16
	
	jr $ra

#*********************************************

exchange:
	lb $t0, 0($a0)
	lb $t1, 0($a1)
	
	sb $t1, 0($a0)
	sb $t0, 0($a1)
	
	jr $ra
	
#*****************************************