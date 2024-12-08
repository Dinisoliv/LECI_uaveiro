# Mapa de registros:
# p (ponteiro): $t0
# pultimo: $t1
# soma: $t2
# valor (*p): $t3

	.data

    	.eqv print_int10, 1  # syscall para printar inteiros
    	.eqv SIZE, 4

array:  .word 7692, 23, 5, 234  # Declara o array com 4 posições e inicializa-o

	.text
    	.globl main

main:
    # Inicializando o ponteiro p com o endereço do primeiro elemento do array
    la $t0, array          # p = array
    
    # Inicializando o ponteiro pultimo com o endereço do último elemento do array
    la $t1, array          # pultimo = array
    addiu $t1, $t1, SIZE*4-4  # pultimo = &array[SIZE-1], SIZE*4 = 16 bytes, então subtraímos 4 para o último elemento

    # Inicializando soma = 0
    li $t2, 0              # soma = 0

while:
    # Verificando se p <= pultimo
    bgtu $t0, $t1, endwhile  # Se p > pultimo, termina o loop

    # Soma = soma + (*p)
    lw $t3, 0($t0)          # Carrega o valor apontado por p (*p)
    addu $t2, $t2, $t3      # soma = soma + *p
    
    # Incrementa p (p++)
    addiu $t0, $t0, 4       # Incrementa o ponteiro p (p += 4, pois é um inteiro de 4 bytes)

    j while                 # Volta para o início do loop

endwhile:
    # Imprime o valor de soma
    li $v0, print_int10      # syscall para imprimir o inteiro
    move $a0, $t2            # Move o valor de soma para $a0
    syscall

    jr $ra                   # Retorna da função
