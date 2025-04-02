        .data

str:    .asciiz "Test\n"
        
        .text
        .globl main
main:
        addiu $sp, $sp, -16
        sw $ra, 0($sp)
        sw $s0, 4($sp)
        sw $s1, 8($sp)
        sw $s2, 12($sp)

        li $v0, 8
        la $a1, str
        syscall
while:
        li $v0, 3
        li $a0, '\r'
        syscall

        li $v0, 6
        move $a0, $s0
        li $a1, 0x0004000A
        syscall

        li $v0, 6
        move $a0, $s1
        li $a1, 0x0004000A
        syscall

        li $v0, 6
        move $a0, $s2
        li $a1, 0x0004000A
        syscall

        li $a0, 100
        jal delay

        addi $s2, $s2, 1

        rem $t0, $s2, 2
        bne $t0, $0, endif0
        addi $s1, $s1, 1
endif0:
        rem $t0, $s2, 10
        bne $t0, $0, endif1
        addi $s1, $s1, 1
endif1: 

        j while

        lw $s2, 12($sp)
        lw $s1, 8($sp)
        lw $s0, 4($sp)
        lw $ra, 0($sp)
        addiu $sp, $sp, 16

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
