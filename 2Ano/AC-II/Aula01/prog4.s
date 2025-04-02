
        .data

str:    .asciiz "\nIntroduza um inteiro (sinal e módulo): "
str2:   .asciiz "\nValor em base 2: "
str16:  .asciiz "\nValor em base 16: "
str10:  .asciiz "\nValor em base 10: "
str10b: .asciiz "\nValor em base 10 (unsigned), formatado: "

        .text

        .globl main

main:

while:
        li $v0, 8
        la $a0, str
        syscall

        li $v0, 5
        syscall

        move $t0, $v0

        # Base 2
        li $v0, 8
        la $a0, str2
        syscall
        
        li $v0, 6
        move $a0, $t0
        li $a1, 2
        syscall

        # Base 16
        li $v0, 8
        la $a0, str16
        syscall

        li $v0, 6
        move $a0, $t0
        li $a1, 16
        syscall

        # Base 10
        li $v0, 8
        la $a0, str10
        syscall

        li $v0, 6
        move $a0, $t0
        li $a1, 10
        syscall

        # Base 10 formatada
        li $v0, 8
        la $a0, str10b
        syscall

        li $v0, 6
        move $a0, $t0
        
        li $t1, 10
        li $t2, 5
        sll $t2, $t2, 16
        or $a1, $t1, $t2

        syscall

        j while

        jr $ra
