        .equ ADDR_BASE_HI,0xBF88

        .equ TRISE, 0x6100
        .equ PORTE,0x6110 
        .equ LATE,0x6120 

        .equ TRISB, 0x6040
        .equ PORTB,0x6050 
        .equ LATB,0x6060 

        .equ RESET_CORE_TIMER, 12
        .equ READ_CORE_TIMER, 11

        .data

test:   .asciiz "test\n"

        .text
        .globl main
main:
        addiu $sp, $sp, -16
        sw $ra, 0($sp)
        sw $s0, 4($sp)
        sw $s1, 8($sp)
        sw $s2, 12($sp)

        lui $s0, ADDR_BASE_HI
        lw $s1, TRISE($s0)
        andi $s1, $s1, 0xFFE1 #1111 1111 1110 0001
        sw $s1, TRISE($s0)

        li $s2, 0 

while:
        lw $s1, LATE($s0)
        andi $s1, $s1, 0xFFE1
        sll $t3, $s2, 1
        or $s1, $s1, $t3
        sw $s1, LATE($s0)

        li $a0, 1000
        jal delay

        # li $v0, 8
        # la $a0, test
        # syscall

        addi $s2, $s2, 1
        andi $s2, $s2, 0x000F

        j while

        lw $s2, 12($sp)
        lw $s1, 8($sp)
        lw $s0, 4($sp)
        lw $ra, 0($sp)
        addiu $sp, $sp, 16

        jr $ra

#============================
#wait time in miliseconds
delay:
        li $v0, 12
        syscall

        li $t0, 20000
        mul $t0, $t0, $a0
while_delay:  
        li $v0, 11
        syscall
        bge $v0, $t0, endw_delay

        j while_delay
endw_delay:
        jr $ra
