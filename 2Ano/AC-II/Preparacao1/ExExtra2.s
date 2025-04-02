        .equ ADDR_BASE_HI, 0xBF88

        .equ TRISE, 0x6100
        .equ PORTE,0x6110 
        .equ LATE,0x6120 

        .equ INKEY, 1
        .equ RESETCORETIMER, 12
        .equ READCORETIMER, 11

        .data

        .text

        .globl main
main:
        lui $t0, ADDR_BASE_HI
        
        lw $t1, TRISE($t0)
        andi $t1, $t1, 0xFFF0
        sw $t1, TRISE($t0) 

        lw $t1, LATE($t0)
        andi $t1, $t1, 0xFFF0
        sw $t1, LATE($t0)

while:
        li $v0, INKEY
        syscall

        beq $v0, 0, while

        beq $v0, '0', key0
        beq $v0, '1', key1
        beq $v0, '2', key2
        beq $v0, '3', key3

        j keyX
key0:
        lw $t1, LATE($t0)
        andi $t1, $t1, 0xFFF0
        ori $t1, $t1, 0x0001
        sw $t1, LATE($t0)

        j while
key1:
        lw $t1, LATE($t0)
        andi $t1, $t1, 0xFFF0
        ori $t1, $t1, 0x0002
        sw $t1, LATE($t0)

        j while
key2:
        lw $t1, LATE($t0)
        andi $t1, $t1, 0xFFF0
        ori $t1, $t1, 0x0004
        sw $t1, LATE($t0)

        j while
key3:
        lw $t1, LATE($t0)
        andi $t1, $t1, 0xFFF0
        ori $t1, $t1, 0x0008
        sw $t1, LATE($t0)

        j while
keyX:
        lw $t1, LATE($t0)
        ori $t1, $t1, 0x000F
        sw $t1, LATE($t0)

        li $v0, RESETCORETIMER
        syscall

wait:
        li $v0, READCORETIMER
        syscall

        blt $v0, 20000000, wait 

        lw $t1, LATE($t0)
        andi $t1, $t1, 0xFFF0
        sw $t1, LATE($t0)

        j while
