#include <detpic32.h>

#define N 4

void setPWM(unsigned int dutyCycle);

int main(void)
{
    // Configure Timer T3
    // Configure Output Compare Module 1 (OC1)
    
    T3CONbits.TCKPS = 2;   // 1:32 prescaler (i.e Fout_presc = 625 KHz)
    PR3 = 49999;           // Fout = 20MHz / (32 * (62499 + 1)) = 10 Hz
    TMR3 = 0;              // Reset timer T2 count register
    T3CONbits.TON = 1;     // Enable timer T2 (must be the last command of the
                           // timer configuration sequence)
    
    IPC3bits.T3IP = 2; // Interrupt priority (must be in range [1..6])
    IEC0bits.T3IE = 1; // Enable timer T2 interrupts
    
    OC1CONbits.OCM = 6;     // PWM mode on OCx; fault pin disabled
    OC1CONbits.OCTSEL = 1;  // Use timer T2 as the time base for PWM generation

    setPWM(5); //CHANGE VALUE
    
    OC1CONbits.ON = 1;      // Enable OC1 module 
    
    while(1)
    {
        IdleMode();
    }
    return 0;
} 
//Teste tempo a '1' OC1 -> RD0


void setPWM(unsigned int dutyCycle)
{
    // duty_cycle must be in the range [0, 100]
    if (dutyCycle>0 && dutyCycle<100)
        OC1RS = 50000*dutyCycle/100; // Determine OC1RS as a function of "dutyCycle"
} 
