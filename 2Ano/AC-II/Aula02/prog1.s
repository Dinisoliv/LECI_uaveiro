        .equ READ_CORE_TIMER, 11
        .equ RESET_CORE_TIMER, 12
        .equ PUT_CHAR, 3
        .equ PRINT_INT, 6
        
        .data
        
        .text
        .globl main
main:
        li $t0, 0
while:
        li $v0, PUT_CHAR
        li $a0, '\r'
        syscall

        li $v0, PRINT_INT
        move $a0, $t0
        li $a1, 10
        li $t1, 4
        sll $t1, $t1, 16
        or $a1, $a1, $t1
        syscall

        li $v0, RESET_CORE_TIMER
        syscall

while2:
        li $v0, READ_CORE_TIMER
        syscall

        li $t1, 10000000
        bge $v0, $t1, endw2

        j while2
endw2:
        addi $t0, $t0, 1

        j while

        jr $ra
