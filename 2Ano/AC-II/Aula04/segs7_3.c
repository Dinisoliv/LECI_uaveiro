#include <detpic32.h>

void delay(unsigned int ms);

int main(void)
{
    //LATDbits.LATD5 = 0;
    //LATDbits.LATD6 = 1;
    LATD=(LATD & 0xFFDF) | (0x0020);  //1111 1111 1101 1111
    LATD=(LATD & 0xFFBF);  //1111 1111 1011 1111

    TRISB = TRISB & 0x80FF;      //1000 0000 1111 1111
    TRISD = TRISD & 0xFF9F;      //1111 1111 1001 1111

    //LATB = LATB & 0x80FF;

    while(1)
    {
        int segment = 1;
        segment = segment << 8;
        int i;
        for(i=0; i < 7; i++)
        {
            LATB = (LATB & 0x80FF) | segment;
            delay(500); //change frequency - 100; 20; 10
            segment = segment << 1;
        }
        //LATDbits.LATD5 = !LATDbits.LATD5;
        //LATDbits.LATD6 = !LATDbits.LATD6;
        LATD=(LATD ^ 0x0020);
        LATD=(LATD ^ 0x0040);
    }
    return 0;
} 

void delay(unsigned int ms)
{
    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);
}
