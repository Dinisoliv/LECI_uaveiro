	.data
	
	.text
	.globl main
main:
	addiu $sp, $sp, -4
	lw $ra, 0($sp)
	#********************
	
	#********************
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra
	
###############################################################
abs:
# Mapa de registos:
# val: $a0
	move $a0, $v0
if0:	bge $a0, 0, endif0
	sub $v0, $0, $a0
endif0:
	jr $ra
###############################################################
xtoy:
	addiu $sp, $sp, -20
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	s.s $f20, 12($sp)
	s.s $f22, 16($sp)
	
	#====================
	
	# init
	mov.s $f20, $f12
	la $t0, k0
	l.s $f22, 0($t0)
	move $s0, $a0
	li $s1, 0
	
	# for
	
for: 	move $a0, $s0
	jal abs
	bge $s1
	
	mov.s $f0, $f22 #return result
	
	#====================
	l.s $f22, 16($sp)
	l.s $f20, 12($sp)
	lw $s1, 8($sp)
	lw $s0, 4($sp)
	lw $ra, 0($sp)
	addiu $sp, $sp, 20
	jr $ra

###############################################################
