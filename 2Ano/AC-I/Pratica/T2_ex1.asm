	.data
	
	.eqv SIZE, 15
	
prompt:	.asciiz "Invalid argc"
	
	.text
	.globl func1
# Mapa de registos:
# f1: $a0 -> $s0
# k: $a1 ->  $s1
# av: $a2 -> $s2
# i: $s4
# res: $v0
func1:
	addiu $sp, $sp, -20
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s0, 16($sp)
	
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	move $s3, $a3
	
if:
	blt $s1, 2, else
	bgt $s1, SIZE, else
	
	li $s4, 2 
do:
	addu $a0, $s2, $s4
	jal toi
	
	sll $t0, $s4, 2
	addu $t1, $s0, $t0
	sw $v0, 0($t1)
	
	addiu $s4, $s4, 1

	blt $s4, $s1, do	# } while (i < k) 
	
	move $a0, $s0
	move $a1, $s1
	jal avz
	
	j endif
else:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, -1
	
endif:	
	
	lw $s4, 16($sp)
	lw $s3, 12($sp)
	lw $s2, 12($sp)
	lw $s1, 8($sp)
	lw $s0, 4($sp)
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra