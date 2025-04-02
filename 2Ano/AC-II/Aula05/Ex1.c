#include <detpic32.h>

void send2displays(unsigned char value);
void delay(unsigned int ms);

int main(void){
    TRISB = TRISB & 0x80FF;
    TRISD = TRISD & 0xFF9F;

    while (1)
    {
        send2displays(0x15);
        delay(200);
    }
    
    return 0;
}

void send2displays(unsigned char value){
    static const char disp7Scodes[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 
        0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71};
    int dh, dl;

    // select display high
    LATD=(LATD & 0xFF9F) | (0x0040);
    
    // send digit_high (dh) to display:
    dh = value >> 4;
    LATB = (LATB & 0x80FF) | (disp7Scodes[dh] << 8);
    
    // select display low
    // send digit_low (dl) to display:
    dl = value & 0x0F;
    LATD=(LATD & 0xFF9F) | (0x0020);
    LATB = (LATB & 0x80FF) | (disp7Scodes[dl] << 8); 
}

void delay(unsigned int ms)
{
    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);
}
