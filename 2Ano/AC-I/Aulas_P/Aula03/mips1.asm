	#Mapa de registos:
	#  soma:  $t0
	#  value: $t1
	#  i:     $t2
	
	.data
	
str1:	.asciiz "Intruduza o número"
str2:	.asciiz "Valor ignorado \n"
str3: 	.asciiz "A soma dos positivos é: "

	.eqv print_string, 4 
	.eqv read_int, 3
	.eqv print_int10, 1
	
	.text
	
	.globl main
	
main:
	
	li $t0, 0		#soma = 0
	li $t2, 0		#i = 0
	
for:
	slti $t3, $t2, 5	#i < 5
	beq $t3, $0, endfor	#
	
	li $v0, print_string
	la $a0, str1
	syscall 
	
	li $v0, read_int
	syscall
	
	or $t1, $0, $v0
if:
	ble $t1, $0, else
	add $t0, $t0, $t1
	j endif
else:
	li $v0, print_string
	la $a0, str2
	syscall

endif:
	
	addi $t2, $t2, 1 	#i++ 
	j for
endfor:
	li $v0, print_string
	la $a0, str3
	syscall
	
	li $v0, print_int10
	or $a0, $0, $t0	
	syscall
	
	jr $ra