#include <detpic32.h>

void configUart2(unsigned int baud, char parity, unsigned int stopbits)
{
    
    // Configure BaudRate Generator
    if (baud<600 || baud>576000)
    {
        U2BRG = (20000000 + 8*115200) / (16*115200) - 1;
        U2MODEbits.BRGH = 0;
    }
    else if (baud>115200)
    {
        U2BRG = (20000000 + 2*baud) / (4*baud) - 1;
        U2MODEbits.BRGH = 1;
    }
    else{
        U2BRG = (20000000 + 8*baud) / (16*baud) - 1;
        U2MODEbits.BRGH = 0;
    }
    
    // Configure number of data bits (8), parity and number of stop bits
    if (parity == 'E')
    {
        U2MODEbits.PDSEL = 1;
    }else if ('O')
    {
        U2MODEbits.PDSEL = 2;
    }else{
        U2MODEbits.PDSEL = 0;
    }
    
    U2MODEbits.STSEL = stopbits-1;

    // Enable the trasmitter and receiver modules
    U2STAbits.UTXEN = 1;
    U2STAbits.URXEN = 1;
    // Enable UART2
    U2MODEbits.ON = 1;

} 