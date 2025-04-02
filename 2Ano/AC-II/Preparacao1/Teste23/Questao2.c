#include <detpic32.h>

#define N 2

int main(void){
    static const char disp7Scodes[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 
        0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71};    


    TRISBbits.TRISB4 = 1; 
    AD1PCFGbits.PCFG4 = 0; 
    AD1CON1bits.SSRC = 7; 
    AD1CON1bits.CLRASAM = 1; 
    AD1CON3bits.SAMC = 16; 
    AD1CON2bits.SMPI = N-1;     //number of samples

    AD1CHSbits.CH0SA = 4;  
    AD1CON1bits.ON = 1; 

    TRISB = TRISB & 0x80FF;
    TRISD = TRISD & 0xFFDF;
    TRISE = TRISE & 0xFFFD; //1101

    while (1)
    {
        AD1CON1bits.ASAM = 1;
        while( IFS1bits.AD1IF == 0 );

        int sum = 0;

        int *p = (int*)(&ADC1BUF0);
        for (; p <= (int*)(&ADC1BUF1); p+=4)
        {
            sum += *p;
        }

        int avg = sum / N;

        printInt(avg, 16 | 3 << 16);
        putChar('\n');

        LATD = LATD | 0x0020;
        
        int level = avg * 9 / 1023;

        LATB = (LATB & 0x80FF) | (disp7Scodes[level] << 8);

        LATE = LATE ^ 0x0002;

        resetCoreTimer();
        while(readCoreTimer() < 4000000);

        IFS1bits.AD1IF = 0;
        
    }
    
}
