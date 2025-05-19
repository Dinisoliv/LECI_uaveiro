#include <detpic32.h>

void delay(unsigned int ms);

int main(void){
    TRISD = TRISD | 0x0100;
    TRISE = TRISE & 0xFFFE;

    while (1)
    {
        LATE = LATE & 0xFFFE;
        while ((PORTD & 0x0100) != 0);
        LATE = LATE | 0x0001;
        delay(3000);
    }    
}

void delay(unsigned int ms)
{
    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);
}
