#include <detpic32.h>

int main(void){

    TRISE = TRISE & 0xFF00;
    TRISB = TRISB | 0x000F;

    while (1)
    {
        LATEbits.LATE7 = PORTBbits.RB0;
        LATEbits.LATE6 = PORTBbits.RB1;
        LATEbits.LATE5 = PORTBbits.RB2;
        LATEbits.LATE4 = PORTBbits.RB3;

        int value = PORTB & 0x000F;

        LATE = (LATE & 0xFFF0) | value;

    }
    return 0;
}
