#include <detpic32.h>

void send2displays(unsigned char value);
void delay(unsigned int ms);
unsigned char toBcd(unsigned char value);

int main(void){
    TRISB = TRISB & 0x80FF;
    TRISD = TRISD & 0xFF9F;
    TRISE = TRISE & 0xFF00;
    TRISB = TRISB | 0x0001;

    int counter = 0;
    int BCDcounter;
    int up;
    while (1)
    {
        int i = 0;
        do
        {
            BCDcounter = toBcd(counter);
            send2displays(BCDcounter);
            LATE = (LATE & 0xFF00) | BCDcounter;
            delay(10);
        } while (++i < 50); 

        up = PORTB & 0x0001;
        if (up){
            counter++;
        }else{
            counter--;
        }
        
        if (counter > 59)
            counter = 0;
        
        if(counter < 0)
            counter = 60;
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

unsigned char toBcd(unsigned char value)
{
    return ((value / 10) << 4) + (value % 10);
} 
