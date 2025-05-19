#include <detpic32.h>

int main(void){

    T3CONbits.TCKPS = 7;    // 1:32 prescaler (i.e. fout_presc = 78.125 KHz)
    PR3 = 39062;            // Fout = 20MHz / (32 * (39062 + 1)) = 10 Hz
    TMR3 = 0;               // Clear timer T2 count register
    T3CONbits.TON = 1;      // Enable timer T2 (must be the last command of the
                            // timer configuration sequence) 

    IPC3bits.T3IP = 2;      // Interrupt priority (must be in range [1..6])
    IEC0bits.T3IE = 1;      // Enable timer T2 interrupts
    IFS0bits.T3IF = 0;      // Reset timer T2 interrupt flag 

    EnableInterrupts();     

    while (1)
    {
        IdleMode();
    }
    return 0;
}

void _int_(12) isr_T3(void) // Replace VECTOR by the timer T3 vector number
{
    static int flag1 = 0;
    if (flag1)
        putChar('.');
    flag1 = !flag1;
    IFS0bits.T3IF = 0;
} 
