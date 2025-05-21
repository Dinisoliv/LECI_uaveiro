#include <detpic32.h>

int main(void)
{    
    T3CONbits.TCKPS = 2;
    PR3 = 38461;
    TMR3 = 0;
    T3CONbits.TON = 1;
    
    IPC3bits.T3IP = 2;
    IEC0bits.T3IE = 1;
    
    OC4CONbits.OCM = 6;
    OC4CONbits.OCTSEL = 1;

    OC4RS = 19230;   
    
    OC4CONbits.ON = 1; 

    TRISB = TRISB | 0x0002;
    int freq = 0;

    while (1)
    {
        resetCoreTimer();
        while (readCoreTimer() < 15384614);
        if (!(LATB & 0x0002))
        {
            if (!freq)
                OC2RS = (38461+1) / 4;
            if (freq)
                OC2RS = (38461+1) * 3 / 4;
            freq = !freq;
        }
    }    

    return 1;
}
