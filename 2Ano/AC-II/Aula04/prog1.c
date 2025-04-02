#include <detpic32.h>

void delay(unsigned int ms);

int main(void){

    TRISC = TRISC & 0xBFFF; // 1011 1111 1111 1111
    //TRISCbits.TRISC14 = 0;
    LATC = LATC & 0xBFFF; 
    //LATCbits.LATC14 = 0;

    while (1)
    {
        delay(500);
        LATC = LATC ^ 0x4000; //0100 0000 0000 0000
    }
    return 0;
}

void delay(unsigned int ms)
{
    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);
}
          