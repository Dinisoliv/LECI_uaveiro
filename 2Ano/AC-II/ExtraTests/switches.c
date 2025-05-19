#include <detpic32.h>

int main(void) {
    TRISE = TRISE & 0xFFF0;
    TRISB = TRISB | 0x000F;

    while (1)
    {
        //LATE = (LATE & 0xFFF0) | (PORTB & 0x000F);
        LATE = LATE | 0x000F;
        if (PORTB & 0x0001)
            putChar('1');
        if (PORTB & 0x0002)
            putChar('2');
        if (PORTB & 0x0004)
            putChar('3');
        if (PORTB & 0x0008)
            putChar('4');
        putChar('\n');
    }    

}
