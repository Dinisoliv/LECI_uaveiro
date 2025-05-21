#include <detpic32.h>

#define N 2

unsigned char toBcd(unsigned char value);
void send2displays(unsigned char value);


volatile int temp;

int main(void){
    
    TRISBbits.TRISB4 = 1; 
    AD1PCFGbits.PCFG4 = 0; 
    AD1CON1bits.SSRC = 7; 
    AD1CON1bits.CLRASAM = 1; 
    AD1CON3bits.SAMC = 16; 
    AD1CON2bits.SMPI = N-1;     //number of samples

    AD1CHSbits.CH0SA = 4;  
    AD1CON1bits.ON = 1;

    T3CONbits.TCKPS = 2;
    PR3 = 33332;
    TMR3 = 0;
    T3CONbits.TON = 1;
    
    IPC3bits.T3IP = 2;
    IEC0bits.T3IE = 1;
    IFS0bits.T3IF = 0; 

    EnableInterrupts();

    TRISB = TRISB & 0x80FF;
    TRISD = TRISD & 0xFF9F;

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

        resetCoreTimer();
        while( readCoreTimer() < 4000000);

        IFS1bits.AD1IF = 0;

        temp = (avg * 65 + 511) / 1023 + 10;
    }
    return 0;
}

void _int_(12) isr_T3(void)
{
    int tempBCD = toBcd(temp);
    send2displays(tempBCD);
    // Reset T3IF flag
    IFS0bits.T3IF = 0;
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

unsigned char toBcd(unsigned char value)
{
    return ((value / 10) << 4) + (value % 10);
} 
