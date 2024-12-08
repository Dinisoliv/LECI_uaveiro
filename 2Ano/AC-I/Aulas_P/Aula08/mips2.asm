# Mapa de registos
# n: $a0 -> $s0
# b: $a1 -> $s1
# s: $a2 -> $s2
# p: $s3
# digit: $t0 
	.data
	
	.text
	.globl main
main:
	
	
	
#***********************
itoa:
	


#***********************
toascii:
	addi $a0, $a0, '0'
if:
	ble $a0, '9', endif
	
	addi $a0, $a0, 7
	
endif:
	move $v0, $a0
	
	jr $ra 
