        .equ ADDR_BASE_HI,0xBF88
        .equ TRISE, 0x6100
        .equ PORTE,0x6110 
        .equ LATE,0x6120 
        
        .equ TRISB, 0x6040
        .equ PORTB,0x6050 
        .equ LATB,0x6060 

        .data

        .text
        .globl main

main:
        lui $t1, ADDR_BASE_HI
        lw $t2, TRISE($t1)
        andi $t2, $t2, 0xFFFE
        sw $t2, TRISE($t1)

        lw $t2, TRISB($t1)
        ori $t2, $t2, 0x0001
        sw $t2, TRISB($t1)

while:
        lw $t2, PORTB($t1)
        andi $t2, $t2, 0x0001

        lw $t3, LATE($t1)
        andi $t3, $t3, 0xFFFE
        #nor $t2, $t2, $0
        or $t3, $t3, $t2
        sw $t3, LATE($t1)

        j while

        jr $ra
