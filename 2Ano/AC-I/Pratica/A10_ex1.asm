	.data
	
	.align 2
const:	.float 1.0
	
prompt_x: .asciiz "Digite o valor de x (real): "   # Mensagem para entrada de x
prompt_y: .asciiz "Digite o valor de y (inteiro): " # Mensagem para entrada de y
result_msg: .asciiz "O resultado é "             # Parte inicial da mensagem de saída
newline: .asciiz "\n"                             # Nova linha para saída	

	.text
	.globl main
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	# Saída: "Digite o valor de x (real): "
    	li $v0, 4               # Syscall para imprimir string
    	la $a0, prompt_x        # Carrega o endereço da mensagem
    	syscall

    	# Entrada: leitura de x (float)
    	li $v0, 6               # Syscall para ler float
    	syscall
    	mov.s $f12, $f0             # Salva o valor de x na memória

    	# Saída: "Digite o valor de y (inteiro): "
    	li $v0, 4               # Syscall para imprimir string
    	la $a0, prompt_y        # Carrega o endereço da mensagem
    	syscall

    	# Entrada: leitura de y (inteiro)
    	li $v0, 5               # Syscall para ler inteiro
    	syscall
    	move $a0, $v0            # Salva o valor de y na memória

    	# Chamada da função xtoy(x, y)
    	jal xtoy                # Chama a função xtoy

    	# Saída: "O resultado de "
    	li $v0, 4               # Syscall para imprimir string
    	la $a0, result_msg      # Carrega o endereço da mensagem
    	syscall

    	# Saída: resultado (float)
    	mov.s $f12, $f0       # Carrega o resultado para impressão
    	li $v0, 2               # Syscall para imprimir float
    	syscall

    	# Nova linha
    	li $v0, 4               # Syscall para imprimir string
    	la $a0, newline         # Carrega o endereço da nova linha
    	syscall
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra
	
#********************************************
xtoy:
	addiu $sp, $sp, -20
	sw $ra, 0($sp)			
	sw $s0, 4($sp)			# y
	sw $s1, 8($sp)			# i
	s.s $f20, 12($sp)		# x
	s.s $f22, 16($sp)		# result
	#====================
	
	mov.s $f20, $f12
	move $s0, $a0
	
	li $s1, 0
	
	la $t0, const
	l.s $f22, 0($t0)
	
for_xtoy:
	move $a0, $s0
	jal abs
	
	bge $s1, $v0, endf_xtoy
	
if_xtoy:
	bltz $s0, else_xtoy
	
	mul.s $f22, $f22, $f20 
	
	j endif_xtoy
else_xtoy:
	div.s $f22, $f22, $f20 
endif_xtoy:
	addiu $s1, $s1, 1
		
	j for_xtoy 
	
endf_xtoy:
	mov.s $f0, $f22
	
	#====================
	l.s $f22, 16($sp)
	l.s $f20, 12($sp)
	lw $s1, 8($sp)
	lw $s0, 4($sp)
	lw $ra, 0($sp)
	addiu $sp, $sp, 20

	jr $ra
	
#********************************************
abs:
if_abs:
	bgtz $a0, endif_abs
	
	nor $a0, $a0, $0
	addi $a0, $a0, 1 
	
endif_abs:
	move $v0, $a0
	
	jr $ra
#********************************************
