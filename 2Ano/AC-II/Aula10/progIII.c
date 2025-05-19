#include <detpic32.h>

void putstr(char *str);
void putc(char byte);

int main(void)
{
    // Configure UART2 (115200, N, 8, 1)
    // Configure UART2:
    // 1 - Configure BaudRate Generator
    U2BRG = (20000000 + 2*115200) / (4*115200) - 1;
    
    // Configure UART2 (19200, N, 8, 1) (2)
    //U2BRG = (20000000 + 2*19200) / (4*19200) - 1;

    U2MODEbits.BRGH = 1;
    // 2 – Configure number of data bits, parity and number of stop bits
    // (see U2MODE register)
    U2MODEbits.PDSEL = 0;
    U2MODEbits.STSEL = 0;
    // 3 – Enable the trasmitter and receiver modules (see register U2STA)
    U2STAbits.URXEN = 1;
    U2STAbits.UTXEN = 1;    
    // 4 – Enable UART2 (see register U2MODE)
    U2MODEbits.ON = 1;
    // config RD11 as output
    TRISD = TRISD & 0xF7FF;
    while(1)
    {
        // Wait while TRMT == 0
        while (U2STA.TRMT == 0); //comment line (3) - test RD11 compare
        // Set RD11 
        LATD = LATD | 0x0800;
        putstr("12345");
        // Reset RD11
        LATD = LATD & 0xF7FF;
        //test INT4 - "123456789", "123456789A", "123456789AB" (1)
    }
    return 0;
}

void putstr(char *str)
{
    // use putc() function to send each charater ('\0' should not be sent)
    while (*str != '\0')
    {
        putc(*str);
        str++;
    }
} 

void putc(char byte)
{
    // wait while UART2 UTXBF == 1
    while (U2STAbits.UTXBF == 1);
    // Copy "byte" to the U2TXREG register
    U2TXREG = byte;
} 
