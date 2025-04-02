        .data

        .equ UP, 1
        .equ DOWN, 0
        .equ STOP, -1

test:   .asciiz "Dinis\n"

        .text

        .globl main

# $s0: state
# $s1: cnt

main:
        addiu $sp, $sp, -12
        sw $ra, 0($sp)
        sw $s0, 4($sp)
        sw $s1, 8($sp)

        li $s0, 0
        li $s1, 0

do:
        li $v0, 3
        li $a0, '\r' 
        syscall

        li $v0, 6
        move $a0, $s1
        li $a1, 0x0003000A
        syscall

        li $v0, 3
        li $a0, '\t'
        syscall

        li $v0, 6
        move $a0, $s1
        li $a1, 0x00080002
        syscall

        # li $v0, 8
        # la $a0, test
        # syscall

        li $a0, 5
        jal wait

        # li $v0, 8
        # la $a0, test
        # syscall

        li $v0, 1               # inkey()
        syscall

        move $t2, $v0

        bne $t2, 's', endif0
        li $s0, STOP
endif0:
        bne $t2, '+', endif1
        li $s0, UP
endif1:
        bne $t2, '-', endif2
        li $s0, DOWN
endif2:

        bne $s0, STOP, elsif
        j endif3
elsif:
        bne $s0, UP, else
        addi $s1, $s1, 1
        andi $s1, $s1, 0xFF
        j endif3
else:   
        addi $s1, $s1, -1
        andi $s1, $s1, 0xFF
endif3:
        bne $t2, 'r', endif4
        li $s1, 0
endif4:

        bne $t2, 'q', do

        lw $s1, 8($sp)
        lw $s0, 4($sp)
        lw $ra, 0($sp)
        addiu $sp, $sp, 12 

        jr $ra

#------------------
wait:
        li $t0, 0
        
        li $t1, 515000
        mul $t2, $t1, $a0

        #li $v0, 8
        #la $a0, test
        #syscall
for:
        bge $t0, $t2, endf

        addi $t0, $t0, 1
        
        # li $v0, 7
        # move $a0, $t0
        # syscall
        # li $v0, 3
        # li $a0, '\n'
        # syscall

        #li $v0, 8
        #la $a0, test
        #syscall
        
        j for
endf:
        #li $v0, 8
        #la $a0, test
        #syscall
        
        jr $ra
