        .data

        .text
        .globl main

main:
        addiu $sp, $sp, -8
        sw $ra, 0($sp)
        sw $s0, 4($sp)

        li $s0, 0
while:
        li $v0, 3
        li $a0, '\r'
        syscall
        
        li $v0, 6
        move $a0, $s0
        li $a1, 0x0004000A
        syscall

        li $a0, 1000
        jal delay

        addi $s0, $s0, 1

        j while

        lw $s0, 4($sp)
        lw $ra, 0($sp)
        addiu $sp, $sp, 8
        
        jr $ra

#============================
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

