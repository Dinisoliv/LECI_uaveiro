#include <detpic32.h>

#define N 1

int main(void){

    TRISB = TRISB | 0x000F;

    TRISBbits.TRISB4 = 1; 
    AD1PCFGbits.PCFG4 = 0; 
    AD1CON1bits.SSRC = 7; 
    AD1CON1bits.CLRASAM = 1; 
    AD1CON3bits.SAMC = 16; 
    AD1CON2bits.SMPI = N-1;     //number of samples

    AD1CHSbits.CH0SA = 4;  
    AD1CON1bits.ON = 1; 

    
    while (1)
    {
        AD1CON1bits.ASAM = 1;   //start conversion

        int value = PORTB & 0x000F;
        
        //putChar('\r');
        printStr("DS=");

        int i;
        for (i = 0; i < 4; i++)
        {
            putChar(value & (1<<i) ? '1' : '0');
        }
        putChar('\n');

        resetCoreTimer();
        while (readCoreTimer() < 20000000 / (ADC1BUF0 * 4 / 1023 + 1));
        
        IFS1bits.AD1IF = 0;
    }    
}
