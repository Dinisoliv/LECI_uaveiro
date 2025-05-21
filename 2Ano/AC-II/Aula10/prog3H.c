#include <detpic32.h>

char getc(void);
void putc(char byte);

int main(void)
{
    // Configure UART2 (115200, N, 8, 1)
    // Configure UART2:
    // 1 - Configure BaudRate Generator
    U1BRG = (20000000 + 2*115200) / (4*115200) - 1;
    U1MODEbits.BRGH = 1;
    // 2 – Configure number of data bits, parity and number of stop bits
    U1MODEbits.PDSEL = 0;
    U1MODEbits.STSEL = 0;
    // 3 – Enable the trasmitter and receiver modules (see register U2STA)
    U1STAbits.URXEN = 1;
    U1STAbits.UTXEN = 1;    
    // 4 – Enable UART2 (see register U2MODE)
    U1MODEbits.ON = 1;
    
    char ch;
    
    while(1)
    {
        ch = getc();
        //putChar(ch);
        ch = '.';
        putc(ch);
    }
    return 0;
}

void putc(char byte)
{
    // wait while UART2 UTXBF == 1
    while (U1STAbits.UTXBF == 1);
    // Copy "byte" to the U2TXREG register
    U1TXREG = byte;
} 

char getc(void)
{
    // If OERR == 1 then reset OERR 
    if (U1STAbits.OERR) 
        U1STAbits.OERR = 0;
    // Wait while URXDA == 0
    while (U1STAbits.URXDA == 0);
    // Return U2RXREG
    return U1RXREG;
} 
