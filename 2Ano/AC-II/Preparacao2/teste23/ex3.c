#include <detpic32.h>

void putc(char c);

static int counter = 0;

int main(void){
    // Configure UART2: 2400, E, 8, 2
    U2BRG = (20000000 + 8*2400) / (16*2400) - 1;
    //U2BRG = (20000000 + 8*115200) / (16*115200) - 1;
    U2MODEbits.BRGH = 0;
    
    U2MODEbits.PDSEL = 1;
    U2MODEbits.STSEL = 1;

    //U2MODEbits.PDSEL = 0;
    //U2MODEbits.STSEL = 0;
    
    U2STAbits.URXEN = 1;
    U2STAbits.UTXEN = 1; 
    
    U2MODEbits.ON = 1;

    IEC1bits.U2RXIE = 1;
    IEC1bits.U2TXIE = 0;
    
    IPC8bits.U2IP = 2;
    
    IFS1bits.U2RXIF = 0;
    
    U2STAbits.URXISEL = 0;

    // Enable global Interrupts
    EnableInterrupts(); 

    TRISE = TRISE & 0xFFF0;

    while (1)
    {
        
    }
    
    return 0;
}

void _int_(32) isr_uart2(void){
    if (IFS1bits.U2RXIF == 1){
        // Read character from FIFO (U2RXREG)
        char ch = U2RXREG;

        putc(ch);

        if (ch == 'F')
        {
            counter = (counter + 1) % 10;
        }
        if (ch == 'C')
        {
            counter = 0 ;
            char* str = "VALOR MINIMO";
            while (*str != '\0')
            {
                putc(*str);
                str++;
            }   
        }
        LATE = (LATE & 0xFFF0) | (counter & 0x000F);

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
