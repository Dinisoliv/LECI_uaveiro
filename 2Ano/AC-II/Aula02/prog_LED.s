        .data

        .text

        .globl main

main:
        addiu $sp, $sp, -4
        sw $ra, 0($sp)

        jal configD11

while:
        li $a0, 1
        jal outD11

        li $a0, 500
        jal delay

        li $a0, 0
        jal outD11

        li $a0, 600
        jal delay

        li $a0, 1
        jal outD11

        li $a0, 200
        jal delay

        li $a0, 0
        jal outD11

        li $a0, 150
        jal delay

        li $a0, 1
        jal outD11

        li $a0, 100
        jal delay

        li $a0, 0
        jal outD11

        li $a0, 600
        jal delay

        j while


        lw $ra, 0($sp)
        addiu $sp, $sp, 4

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

#============================
delay2:
        li $v0, 12
        syscall

        li $t0, 20000
        mul $t0, $t0, $a0
while_delay2:  
        li $v0, 11
        syscall

        blt $v0, $t0, while_delay2

endw_delay2:
        jr $ra

#============================
configD11:
        lui $t0,0xBF88
        lw $t1,0x6080($t0)
        andi $t1,$t1,0xBFFF
        sw $t1,0x6080($t0)
        jr $ra 

#============================
outD11:
        lui $t0,0xBF88
        lw $t1,0x60A0($t0)
        andi $t1,$t1,0xBFFF
        sll $a0,$a0,14
        or $t1,$t1,$a0
        sw $t1,0x60A0($t0)
        jr $ra 
        