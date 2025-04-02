        .equ ADDR_BASE_HI, 0xBF88

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
        lui $t0, ADDR_BASE_HI
        lw $t1, TRISE($t0)
        andi $t1, $t1, 0xFF00
        sw $t1, TRISE($t0)

        lw $t1, TRISB($t0)
        ori $t1, $t1, 0x000F
        sw $t1, TRISB($t0)

while:
        li $t4, 0x0000
        lw $t1, PORTB($t0)
        andi $t1, $t1, 0x000F

        andi $t3, $t1, 0x0001 
        sll $t3, $t3, 3
        or $t4, $t4, $t3

        andi $t3, $t1, 0x0002
        sll $t3, $t3, 1
        or $t4, $t4, $t3

        andi $t3, $t1, 0x0004 
        srl $t3, $t3, 1
        or $t4, $t4, $t3

        andi $t3, $t1, 0x0008 
        srl $t3, $t3, 3
        or $t4, $t4, $t3

        lw $t2, LATE($t0)
        andi $t2, $t2, 0xFFF0
        
        or $t2, $t2, $t4

        sll $t2, $t2, 4
        or $t2, $t2, $t1
        
        sw $t2, LATE($t0)

        j while

        jr $ra
