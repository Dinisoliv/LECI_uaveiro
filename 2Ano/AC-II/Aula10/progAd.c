#include <detpic32.h>

void configUart2(unsigned int baud, char parity, unsigned int stopbits)
{
// Configure BaudRate Generator
// Configure number of data bits (8), parity and number of stop bits
// Enable the trasmitter and receiver modules
// Enable UART2

    // Configure UART2:
    // 1 - Configure BaudRate Generator
    U2BRG = (20000000 + 8*115200) / (16*115200) - 1;
    //U2BRG = (20000000 + 2*115200) / (4*115200) - 1;
    U2MODEbits.BRGH = 0;
    //U2MODEbits.BRGH = 1;
    // 2 – Configure number of data bits, parity and number of stop bits
    // (see U2MODE register)
    U2MODEbits.PDSEL = 0;
    U2MODEbits.STSEL = 0;
    // 3 – Enable the trasmitter and receiver modules (see register U2STA)
    U2STAbits.URXEN = 1;
    U2STAbits.UTXEN = 1;
    // 4 – Enable UART2 (see register U2MODE)
    U2MODEbits.ON = 1;

} 