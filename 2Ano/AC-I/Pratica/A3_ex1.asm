# Mapa de registos:
# soma: $t0
# value: $t1
# i: $t2
	
	.data
	
str1:	.asciiz "\nIntroduza um número: "
str2:	.asciiz "Valor ignorado\n"
str3:	.asciiz "\nA soma dos positivos é: "
	
	.text
	.globl main
	
main:	li $t2, 0
	li $t0, 0
	
while: 	bge $t2, 5, endw	# while (i<5)
	
	li $v0, 4
	la $a0, str1
	syscall
	
	li $v0, 5
	syscall
	
	move $t1, $v0
	
	ble $t1, $0, else	#if value > 0
	add $t0, $t0, $t1
	
	j endif
else:
	li $v0, 4
	la $a0, str2
	syscall
	
endif:
	addi $t2, $t2, 1
	j while

endw:	li $v0, 4
	la $a0, str3
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	jr $ra
	
	
	
