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

        lw $s1, TRISB($s0)
        ori $s1, $s1, 0x000E
        sw $s1, TRISB($s0)

        li $s2, 0x0001

while:
        lw $s3, PORTB($s0)
        andi $s3, $s3, 0x0001

        lw $s1, LATE($s0)
        andi $s1, $s1, 0xFFE1
        sll $t3, $s2, 1
        or $s1, $s1, $t3
        sw $s1, LATE($s0)

#        li $a0, 167
#        jal delay

        li $v0, RESET_CORE_TIMER
        syscall
wait:   li $v0, READ_CORE_TIMER
        syscall
        blt $v0, 3333333, wait

        bne $s3, $0, leftShf
        andi $t2, $s2, 0x0001
        xor $t2, $t2, 0x0001
        sll $t2, $t2, 3
        srl $s2, $s2, 1
        andi $s2, $s2, 0x0007
        or $s2, $s2, $t2
        j endCnt
leftShf:
        andi $t2, $s2, 0x0008
        xor $t2, $t2, 0x0008
        srl $t2, $t2, 3
        sll $s2, $s2, 1
        andi $s2, $s2, 0x000E
        or $s2, $s2, $t2
endCnt:
        #andi $s2, $s2, 0x000F 
        
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
