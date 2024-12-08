# Mapa de registros:
# num: $t0
# p (ponteiro): $t1
# valor (*p): $t2

	.data

	.eqv SIZE, 20
	.eqv read_string, 8
	.eqv print_int10, 1

str:    .space 21  # Array de string com 21 bytes (20 + 1 para '\0')

	.text
    	.globl main

main:
    li $v0, read_string
    la $a0, str          # Carrega o endereço de str
    li $a1, SIZE         # Tamanho da string
    syscall              # Chama o syscall para leitura da string

    li $t0, 0            # Inicializa num = 0
    la $t1, str          # Inicializa o ponteiro p = str

while:  # while (*p != '\0')
    lb $t2, 0($t1)       # Carrega o valor do byte apontado por $t1 (*p)
    beq $t2, '\0', endw  # Se *p == '\0', termina o loop

if:    
    blt $t2, '0', endif  # Se *p < '0', vai para endif
    bgt $t2, '9', endif  # Se *p > '9', vai para endif

    addiu $t0, $t0, 1    # Incrementa num se *p for um dígito

endif:
    addiu $t1, $t1, 4    # Incrementa o ponteiro p (p++)
    j while              # Volta para o início do loop

endw:
    li $v0, print_int10   # Prepara o syscall para imprimir num
    move $a0, $t0
    syscall

    jr $ra               # Retorna
