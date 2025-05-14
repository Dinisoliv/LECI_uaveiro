#include <detpic32.h>

void putc(char byte);
void putc1(char byte);

int main(void){
    // Configure UART1:
    // 1 - Configure BaudRate Generator
    U2BRG = (20000000 + 8*115200) / (16*115200) - 1;
    //U2BRG = (20000000 + 2*115200) / (4*115200) - 1;
    U2MODEbits.BRGH = 0;
    //U2MODEbits.BRGH = 1;
    // 2 – Configure number of data bits, parity and number of stop bits
    // (see U2MODE register)
    U2MODEbits.PDSEL = 1;
    U2MODEbits.STSEL = 0;
    // 3 – Enable the trasmitter and receiver modules (see register U2STA)
    U2STAbits.URXEN = 1;
    U2STAbits.UTXEN = 1;
    // 4 – Enable UART2 (see register U2MODE)
    U2MODEbits.ON = 1;

    while (1)
    {
        resetCoreTimer();
        while (readCoreTimer() < 200000);
        putc1(0x5A);
        //teste OC4 - start bit, o bit de paridade, o stop bit
        //0xA5, 0xF0, 0x0F, 0xFF, 0x00
    }

    return 0;
}

void putc1(char byte)
{
    // wait while UART2 UTXBF == 1
    while (U1STAbits.UTXBF == 1);
    // Copy "byte" to the U2TXREG register
    U1TXREG = byte;
} 
