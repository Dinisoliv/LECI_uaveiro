#include <detpic32.h>

void putc(char c);

int main(void){
    U2BRG = (20000000 + 8*9600) / (16*9600) - 1;

    U2MODEbits.BRGH = 0;

    U2MODEbits.PDSEL = 2;
    U2MODEbits.STSEL = 1;

    U2STAbits.URXEN = 1;
    U2STAbits.UTXEN = 1;

    U2MODEbits.ON = 1;

    IEC1bits.U2RXIE = 1;
    IEC1bits.U2TXIE = 0;

    IPC8bits.U2IP = 2;
    
    IFS1bits.U2RXIF = 0;
    
    U2STAbits.URXISEL = 0;
    
    EnableInterrupts(); 

    TRISB = TRISB | 0x000F;

    while (1)
    {
        IdleMode();
    }
    

    return 0;
}

void _int_(32) isr_uart2(void){
    if (IFS1bits.U2RXIF == 1){
        // Read character from FIFO (U2RXREG)
        char ch = U2RXREG;

        putc(ch);

        if (ch == 'D')
        {
            char* str = "DSD= ";
            while (*str != '\0')
            {
                putc(*str);
                str++;
            }
            
            int DSD = PORTB & 0x000F;
            putc(DSD / 10 + 0x30);
            putc(DSD % 10 + 0x30);
        }
        
        // Clear UART2 Rx interrupt flag
        IFS1bits.U2RXIF = 0;
    }
}

void putc(char byte)
{
    // wait while UART2 UTXBF == 1
    while (U2STAbits.UTXBF == 1);
    // Copy "byte" to the U2TXREG register
    U2TXREG = byte;
} 
