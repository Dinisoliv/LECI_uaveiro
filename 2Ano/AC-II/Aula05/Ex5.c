#include <detpic32.h>

void send2displays(unsigned char value);
void delay(unsigned int ms);

int main(void){
    TRISB = TRISB & 0x80FF;
    TRISD = TRISD & 0xFF9F;
    int counter = 0;
    while (1)
    {
        int i = 0;
        do
        {
            send2displays(counter);
            delay(20); //10
        } while (++i < 10); //20
        counter++;
        //rst
    }
    return 0;    
}

void send2displays(unsigned char value){
    static const char disp7Scodes[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 
        0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71};
    static char displayFlag = 0;
    int dh = value >> 4;
    int dl = value & 0x0F;

    if(displayFlag == 0){
        LATD=(LATD & 0xFF9F) | (0x0020);
        LATB = (LATB & 0x80FF) | (disp7Scodes[dl] << 8); 
    }
    else{
        LATD=(LATD & 0xFF9F) | (0x0040);
        LATB = (LATB & 0x80FF) | (disp7Scodes[dh] << 8);
    }
    displayFlag = !displayFlag;
}

void delay(unsigned int ms)
{
    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);
}

