#include <detpic32.h>

void putc(char byte);

int main(void){
    // Configure UART2: 115200, N, 8, 1
    U2BRG = (20000000 + 8*115200) / (16*115200) - 1;
    U2MODEbits.BRGH = 0;
    
    U2MODEbits.PDSEL = 0;
    U2MODEbits.STSEL = 0;
    
    U2STAbits.URXEN = 1;
    U2STAbits.UTXEN = 1; 
    
    U2MODEbits.ON = 1;

    // Configure UART2 interrupts, with RX interrupts enabled
    // and TX interrupts disabled:
    // enable U2RXIE, disable U2TXIE (register IEC1)
    // set UART2 priority level (register IPC8)
    // clear Interrupt Flag bit U2RXIF (register IFS1)
    // define RX interrupt mode (URXISEL bits)
    
    IEC1bits.U2RXIE = 1;
    IEC1bits.U2TXIE = 0;
    
    IPC8bits.U2IP = 2;
    
    IFS1bits.U2RXIF = 0;  
    
    U2STAbits.URXISEL = 0;

    // Enable global Interrupts
    EnableInterrupts(); 

    TRISC = TRISC & 0xBFFF;

    while (1)
    {
        IdleMode();
    }
    return 0;
}

void _int_(32) isr_uart2(void)
{
    if (IFS1bits.U2RXIF == 1)
    {
        // Read character from FIFO (U2RXREG)
        char ch = U2RXREG;
        // Send the character using putc()
        if (ch == '?')
        {
            char* str = "AC2-Guiao 11";
            while (*str != '\0')
            {
                putc(*str);
                str++;
            }   
        }else{
            putc(ch);
        }

        if (ch == 'T')
        {
            LATC = LATC | 0x4000;
        }
        if (ch == 't')
        {
            LATC = LATC & 0xBFFF;
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
