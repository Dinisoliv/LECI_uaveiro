#include <detpic32.h>

int main(void){
    TRISB = TRISB & 0x80FF;      //1000 0000 1111 1111
    TRISD = TRISD & 0xFF9F;      //1111 1111 1001 1111

    LATB = LATB & 0x80FF;

    LATDbits.LATD5 = 0;
    LATDbits.LATD6 = 1;

    while (1)
    {
        char ch = getChar();
        if(ch >= 'a' && ch <= 'g') {
            ch = ch - 'a';
            LATB = (LATB & 0x80FF) | 1 << (ch + 8);
        }  
    }
    return 0;
}
