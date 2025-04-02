#include <detpic32.h>

int main(void){

    TRISB = TRISB | 0x000F;

    while (1)
    {
        int value = PORTB & 0x000F;
        
        putChar('\r');
        printStr("DS=");

        int i;
        for (i = 0; i < 4; i++)
        {
            putChar(value & (1<<i) ? '1' : '0');
        }
        //putChar('\n');

        resetCoreTimer();
        while (readCoreTimer() < 20000000);
        
    }    
}
