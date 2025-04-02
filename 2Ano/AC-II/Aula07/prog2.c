#include <detpic32.h>

#define N 8

void send2displays(unsigned char value);
void delay(unsigned int ms);
unsigned char toBcd(unsigned char value);

volatile unsigned char voltage = 0; // Global variable 

int main(void){

    unsigned int cnt = 0; 

    TRISBbits.TRISB4 = 1; 
    AD1PCFGbits.PCFG4 = 0; 
    AD1CON1bits.SSRC = 7; 
    AD1CON1bits.CLRASAM = 1; 
    AD1CON3bits.SAMC = 16; 
    AD1CON2bits.SMPI = N-1;     //number of samples

    AD1CHSbits.CH0SA = 4;  
    AD1CON1bits.ON = 1; 

    IPC6bits.AD1IP = 2; // configure priority of A/D interrupts
    IFS1bits.AD1IF = 0; // clear A/D interrupt flag
    IEC1bits.AD1IE = 1; // enable A/D interrupts

    EnableInterrupts(); // Macro defined in "detpic32.h"

    TRISB = TRISB & 0x80FF;
    TRISD = TRISD & 0xFF9F;

    
    while (1)
    {
        if(cnt == 0) // 0, 200 ms, 400 ms, ... (5 samples/second)
        {
            // Start A/D conversion
            AD1CON1bits.ASAM = 1;   
        }
            // Send "voltage" value to displays
            send2displays(voltage);

            cnt = (cnt + 1) % 20;
            // Wait 1 ms
            delay(10); 
    }
    
}

// Interrupt service routine (interrupt handler)
void _int_(27) isr_adc(void) // Replace VECTOR by the A/D vector
{
    // ISR actions
    int *p = (int *)(&ADC1BUF0);
    int sum = 0;

    for(; p <= (int *)(&ADC1BUF7); p+=4 ) {
        sum += *p;
    }

    int avg = sum / N;
    int voltageHEX = (avg *33 + 511) / 1023;

    printInt(voltageHEX, 10 | 4 << 16); // Print voltage value
    putChar('V');
    putChar('\n');

    voltage = toBcd(voltageHEX);
    
    IFS1bits.AD1IF = 0; // Reset AD1IF flag
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
