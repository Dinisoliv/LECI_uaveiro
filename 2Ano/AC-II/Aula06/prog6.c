#include <detpic32.h>

#define N 4

void send2displays(unsigned char value);
void delay(unsigned int ms);
unsigned char toBcd(unsigned char value);

int main(void){

    TRISBbits.TRISB4 = 1; // RB4 digital output disconnected
    AD1PCFGbits.PCFG4 = 0; // RB4 configured as analog input
    
    AD1CON1bits.SSRC = 7; // Conversion trigger selection bits: in this
                        // mode an internal counter ends sampling and
                        // starts conversion
    AD1CON1bits.CLRASAM = 1; // Stop conversions when the 1st A/D converter
                        // interrupt is generated. At the same time,
                        // hardware clears the ASAM bit
    AD1CON3bits.SAMC = 16; // Sample time is 16 TAD (TAD = 100 ns)
    AD1CON2bits.SMPI = N-1; // Interrupt is generated after N samples
                        // (replace N by the desired number of
                        // consecutive samples)
    AD1CHSbits.CH0SA = 4; // replace x by the desired input
                        // analog channel (0 to 15)
    AD1CON1bits.ON = 1; // Enable A/D converter
                        // This must the last command of the A/D
                        // configuration sequence 

    TRISB = TRISB & 0x80FF;
    TRISD = TRISD & 0xFF9F;

    while (1)
    {
        AD1CON1bits.ASAM = 1;
        while( IFS1bits.AD1IF == 0 );
        LATDbits.LATD11 = 1;
        
        int *p = (int *)(&ADC1BUF0);
        int sum = 0;
        for(; p <= (int *)(&ADC1BUFF); p+=4 ) {
            sum += *p;
        }
        
        int avg = sum / N;
        int voltage = (avg *33 + 511) / 1023;

        printInt(voltage, 10 | 4 << 16); // Print voltage value
        putChar('V');
        putChar('\n');

        int voltageBCD = toBcd(voltage);
        send2displays(voltageBCD);
        
        IFS1bits.AD1IF = 0;
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

