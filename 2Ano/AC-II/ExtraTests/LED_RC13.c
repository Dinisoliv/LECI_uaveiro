#include <detpic32.h>

void delay(unsigned int ms);

int main(void) {
    TRISCbits.TRISC13 = 0;
    LATCbits.LATC13 = 1;
    while(1){
        delay(500);
        LATCbits.LATC13 = !LATCbits.LATC13; 
    }
}

void delay(unsigned int ms)
{
    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);
}
