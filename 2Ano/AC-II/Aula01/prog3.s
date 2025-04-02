#int main(void)
#     {
#     char c;
#     int cnt = 0;
#     do {
#        c = inkey();
#        if( c != 0 )
#            putChar( c );
#        else
#           putChar('.');
#        cnt++;
#     } while( c != '\n' );
#     printInt(cnt, 10);
#     return 0;
# } 

        .data

        .text

        .globl main

main:
        li $t0, 0
    
do:     li $v0, 1
        syscall

        move $t1, $v0

if:     beq $t1, 0, else
        li $v0, 3
        move $a0, $t1
        syscall
        j endif

else:   li $v0, 3
        li $a0, '.' 
        syscall

endif:
        addi $t0, $t0, 1

        bne $t1, '\n', do

        li $v0, 7
        move $a0, $t0
        syscall

        jr $ra
        