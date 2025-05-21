#include <detpic32.h>

int main(void)
{    
    T3CONbits.TCKPS = 2;
    PR3 = 41666;
    TMR3 = 0;
    T3CONbits.TON = 1;
    
    IPC3bits.T3IP = 2;
    IEC0bits.T3IE = 1;
    
    OC2CONbits.OCM = 6;
    OC2CONbits.OCTSEL = 1;

    OC2RS = 31249;   
    
    OC2CONbits.ON = 1; 

    TRISB = TRISB | 0x0005;
    int freq;

    while (1)
    {
        resetCoreTimer();
        while (readCoreTimer() < 7200);
        freq = (LATB & 0xFFFB) | (LATB & 0xFFFE); 
        if (!freq)
            OC2RS = 22915;
        
        freq = (LATB & 0xFFFB) & (LATB & 0xFFFB);
        if (freq)
            OC2RS = 12499;
    }    

    return 1;
}
