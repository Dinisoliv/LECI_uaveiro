        .equ ADDR_BASE_HI, 0xBF88

        .equ TRISE, 0x6100
        .equ PORTE,0x6110 
        .equ LATE,0x6120 
        
        .equ RESETCORETIMER, 12
        .equ READCORETIMER, 11

        .data

        .text

        .globl main
main:
        lui $t0, ADDR_BASE_HI

        lw $t1, TRISE($t0)
        andi $t1, $t1, 0xFF83   #1000 0011
        sw $t1, TRISE($t0)
        
        li $t2, 1
while:
        lw $t1, LATE($t0)
        sll $t3, $t2, 2
        andi $t1, $t1, 0xFF83
        or $t1, $t1, $t3
        sw $t1, LATE($t0)

        sll $t2, $t2, 1
        andi $t2, $t2, 0x001F

        li $v0, RESETCORETIMER
        syscall

delay:
        li $v0, READCORETIMER
        syscall
        ble $v0, 8695652, delay

        bne $t2, $0, while

        li $t2, 1

        j while
