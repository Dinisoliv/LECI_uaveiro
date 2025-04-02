    # Still have errors

        .data

str1:   .space 21
str2:   .space 21
str3:   .space 41

msg1:   .asciiz "Introduza 2 strings: "
msg2:   .asciiz "Resultados:\n"
test:   .asciiz "Dinis\n"

        .text
        .globl main
main:
        addiu $sp, $sp, -4
        sw $ra, 0($sp)

        li $v0, 8
        la $a0, msg1
        syscall

        li $v0, 9
        la $a0, str1
        li $a1, 10
        syscall

        li $v0, 9
        la $a0, str2
        li $a1, 10
        syscall

        li $v0, 8
        la $a0, msg2
        syscall

        la $a0, str1 
        jal strlen

        move $a0, $v0
        li $v0, 6
        li $a1, 10
        syscall

        la $a0, str2 
        jal strlen

        move $a0, $v0
        li $v0, 6
        li $a1, 10
        syscall

        la $a0, str3
        la $a1, str1
        jal strcpy

        move $a0, $v0  
        la $a1, str2
        jal strcat

        move $a0, $v0
        li $v0, 8
        syscall

        la $a0, str1
        la $a1, str2
        jal strcmp

        move $a0, $v0
        li $v0, 7
        syscall

        lw $ra, 0($sp)
        addiu $sp, $sp, 4

        jr $ra

#*****************************************
# Mapa de registos
# len : $t0
# s :   $a0
# *s :  $t1

strlen:
	    li $t0, 0
while_strlen:
	    lb $t1, 0($a0)
	    addiu $a0, $a0, 1
	    beq $t1, '\0', endw_strlen
	    addiu $t0, $t0, 1
	
	    j while_strlen
endw_strlen:
	    move $v0, $t0
	    jr $ra

#*********************************************
# Mapa de registos:
# $t0: i
# $t1: 
strcpy:
	    li $t0, 0
do_strcpy:	
	    addu $t2, $a0, $t0
	    addu $t3, $a1, $t0
    
	    lb $t1, 0($t3)
	    sb $t1, 0($t2)
    
	    addiu $t0, $t0, 1
    
	    bne $t1, '\0', do_strcpy
    
	    move $v0, $a0
    
	    jr $ra
#*********************************************
strcat:
	    addiu $sp, $sp, -8
	    sw $ra, 0($sp)
	    sw $s0, 4($sp)
    
	    move $s0, $a0
while_strcat:
	    lb $t1, 0($a0)
    
	    beq $t1, '\0', endw_strcat
	    addiu $a0, $a0, 1
	    j while_strcat
endw_strcat:
	    jal strcpy
    
	    move $v0, $s0
    
	    lw $ra, 0($sp)
	    lw $s0, 4($sp)
	    addiu $sp, $sp, 8

	    jr $ra

#*********************************************
strcmp:
for_strcmp:
        lb $t0, 0($a0)
        lb $t1, 0($a1)

        bne $t0, $t1, endf_str_cmp
        beq $t0, 0, endf_str_cmp

        addiu $a0, $a0, 1
        addiu $a1, $a1, 1

        j for_strcmp

endf_str_cmp:
        sub $v0, $t0, $t1

        jr $ra

#*********************************************
