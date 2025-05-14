#include <detpic32.h>

int main(void)
{
    // Configure ports, Timer T2, interrupts and external interrupt INT1
    TRISD = TRISD | 0x0100;
    TRISE = TRISE & 0xFFFE;

    T2CONbits.TCKPS = 7;
    PR2 = 39062;
    TMR2 = 0;

    IPC2bits.T2IP = 2;
    IEC0bits.T2IE = 1;
    IFS0bits.T2IF = 0;

    INTCONbits.INT1EP = 0;

    IPC1bits.INT1IP = 2;
    IEC0bits.INT1IE = 1;
    IFS0bits.INT1IF = 0;

    EnableInterrupts();
    while(1){
        IdleMode();
    }
    return 0;
}

void _int_(8) isr_T2(void)
{
    static int counter = 0;
    counter++;
    //putChar('.');
    if (counter > 5){
        LATE = LATE & 0xFFFE;
        counter = 0;
        T2CONbits.TON = 0;
    }
    IFS0bits.T2IF = 0;
}

void _int_(7) isr_INT1(void)
{
    T2CONbits.TON = 1;

    LATE = LATE | 0x0001;

    IFS0bits.INT1IF = 0;
} 
