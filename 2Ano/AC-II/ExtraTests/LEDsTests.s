        .equ ADDR_BASE_HI,0xBF88 # Base address: 16 MSbits
        .equ TRISE,0x6100 # TRISE address is 0xBF886100
        .equ PORTE,0x6110 # PORTE address is 0xBF886110
        .equ LATE,0x6120 # LATE address is 0xBF886120 

        .data

        .text

        .globl main
main:
        lui $t1,ADDR_BASE_HI # $t1=0xBF880000
        lw $t2,TRISE($t1) # READ (Mem_addr = 0xBF880000 + 0x6100)
        andi $t2,$t2,0xFF00 # MODIFY (bit0=bit3=0 (0 means OUTPUT))
        sw $t2,TRISE($t1) # WRITE (Write TRISE register)

        lui $t1,ADDR_BASE_HI # $t1=0xBF880000
        lw $t2,LATE($t1) # READ (Read LATE register)
        andi $t2,$t2,0xFF00 # MODIFY (bit0 = 0)
        ori $t2,$t2,0x00FF # MODIFY (bit3 = 1)
        sw $t2,LATE($t1) # WRITE (Write LATE register) 

        jr $ra
