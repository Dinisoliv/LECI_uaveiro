#include <detpic32.h>

#define N 1

int main(void){

    TRISD = TRISD & 0xFF7F;

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

    AD1CON1bits.ASAM = 1;   //start conversion

    while (1)
    {
    }
    
}

// Interrupt service routine (interrupt handler)
void _int_(27) isr_adc(void) // Replace VECTOR by the A/D vector
{
    // Reset RD11 (LATD11 = 0)
    LATD = LATD & 0xF7FF;
    // ISR actions
    printInt(ADC1BUF0, 16 | 4 << 16);
    putChar('\n');
    AD1CON1bits.ASAM = 1;
    // Set RD11 (LATD11 = 1)
    LATD = LATD | 0x0800;
    
    IFS1bits.AD1IF = 0; // Reset AD1IF flag
}  

// Read with osciloscope time at '1'
