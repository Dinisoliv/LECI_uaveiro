#include <detpic32.h>

void putstr(char *str);
void putc(char byte);

int main(void)
{
    // Configure UART2 (115200, N, 8, 1)    
    //600,N,8,1; 1200,O,8,2; 9600,E,8,1; 19200,N,8,2; 115200,E,8,1; 230400,E,8,2; 460800,O,8,1; 576000,N,8,1
    // Configure UART2:
    // 1 - Configure BaudRate Generator
    U2BRG = (20000000 + 8*115200) / (16*115200) - 1;
    U2MODEbits.BRGH = 0;    
    // 2 – Configure number of data bits, parity and number of stop bits
    // (see U2MODE register)
    U2MODEbits.PDSEL = 0;
    U2MODEbits.STSEL = 0;
    // 3 – Enable the trasmitter and receiver modules (see register U2STA)
    U2STAbits.URXEN = 1;
    U2STAbits.UTXEN = 1;    
    // 4 – Enable UART2 (see register U2MODE)
    U2MODEbits.ON = 1;
    
    int counter = 0;

    while(1)
    {
        counter = (counter+1)%10;
        char ch = 0x30 + counter;
        putc(ch);
        // wait 0.2 s
        resetCoreTimer();
        while (readCoreTimer() < 4000000);
    }
    return 0;
}

void putc(char byte)
{
    // wait while UART2 UTXBF == 1
    while (U2STAbits.UTXBF == 1);
    // Copy "byte" to the U2TXREG register
    U2TXREG = byte;
} 
