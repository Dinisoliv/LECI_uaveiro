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
        if (ch == 'a') LATB = (LATB & 0x80FF) | (1 << 8);
        if (ch == 'b') LATB = (LATB & 0x80FF) | (1 << 9);
        if (ch == 'c') LATB = (LATB & 0x80FF) | (1 << 10);
        if (ch == 'd') LATB = (LATB & 0x80FF) | (1 << 11);
        if (ch == 'e') LATB = (LATB & 0x80FF) | (1 << 12);
        if (ch == 'f') LATB = (LATB & 0x80FF) | (1 << 13);
        if (ch == 'g') LATB = (LATB & 0x80FF) | (1 << 14);    
    }
    return 0;
}
