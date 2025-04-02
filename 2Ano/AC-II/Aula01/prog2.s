# int main(void)
# {
#   char c;
#   int cnt = 0;
#   do
#   {
#       c = getChar();
#       putChar( c );
#       cnt++;
#   } while( c != '\n' );
#   printInt(cnt, 10);
#   return 0;
# } 
        .data

#char:   .space 1

        .text

        .globl main
main:
        li $t0, 0
do:
        li $v0, 2
        syscall

        move $t1, $v0

        li $v0, 3       
        addi $a0, $t1, 1
        syscall

        addi $t0, $t0, 1

        bne $t1, '\n', do

        li $v0, 7
        move $a0, $t0
        syscall

        jr $ra
