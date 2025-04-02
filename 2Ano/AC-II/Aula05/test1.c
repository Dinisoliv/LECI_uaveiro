#include <detpic32.h>

void delay(unsigned int ms);

int main(void){
    TRISE = TRISE & 0xFF00;        

    while (1)
    {
        LATE == (LATE & (0xFF00)) | 0x00FF;
        delay(1000);
        LATE == (LATE & (0xFF00));
    }
    return 0;    
}

void delay(unsigned int ms)
{
    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);
}

