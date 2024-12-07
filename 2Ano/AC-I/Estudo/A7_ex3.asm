	.data
	
	.eqv STR_MAX_SIZE, 30
	
str1:	.asciiz "I serodatupmoC ed arutetiuqrA"
	
str2:	.space 31

longMsg: .asciiz "String too long: "
newLine: .asciiz "\n"

	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $a0, str1
	jal strlen
	
	move $t0, $v0
if:	
	bgt $t0, STR_MAX_SIZE, else
	
	la $a0, str2
	la $a1, str1
	jal strcpy
	
	move $a0, $v0
	li $v0, 4
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	la $a0, str2
	jal strrev
	
	move $a0, $v0
	li $v0, 4
	syscall
	
	j endif
else:	
	li $v0, 4
	la $a0, longMsg
	syscall
	
	la $a0, str1
	jal strlen
	
	move $a0, $v0
	li $v0, 1
	syscall

endif:	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4

	jr $ra

#*********************************************
# Mapa de registos:
# $t0: i
# $t1: 
strcpy:
	li $t0, 0
do:	
	addu $t2, $a0, $t0
	addu $t3, $a1, $t0
	
	lb $t1, 0($t3)
	sb $t1, 0($t2)
	
	addiu $t0, $t0, 1
	
	bne $t1, '\0', do
	
	move $v0, $a0
	
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
	beq $s1, $s2, endw2
	
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
	
	#move $t2, $t0
	#move $t0, $t1
	#move $t1, $t2
	#sb $t0, 0($a0)
	#sb $t1, 0($a1)
	
	sb $t1, 0($a0)
	sb $t0, 0($a1)
	
	jr $ra
	
#*****************************************
# Mapa de registos
# len : $t0
# s :   $a0
# *s :  $t1

strlen:
	li $t0, 0
while:
	lb $t1, 0($a0)
	addiu $a0, $a0, 1
	beq $t1, '\0', endw
	addiu $t0, $t0, 1
	
	j while
endw:
	move $v0, $t0
	jr $ra

#*****************************************
