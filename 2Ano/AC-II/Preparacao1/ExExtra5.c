#include <detpic32.h>

int main(void){
    int cnt = 0;
    unsigned int period = 20000000;
    int freq = 1;
    int value;
    while (1)
    {
        cnt = (cnt+1) % 100;

        putChar('\r');
        printInt(cnt, 10 | 2 << 16);

        value = inkey();
        if (value == '\n')
        {
            putChar('\n');
            printInt10(cnt);
            printStr(", ");
            printInt10(freq);
            printStr("Hz\n");
        }
        
        if((value != 0) && (value <= '4') && (value >= '0')){
            value = value - '0';
            freq = (2*(1+value));
            period = 20000000 / freq;
        }

        resetCoreTimer();
        while(readCoreTimer()<period);
    }
    
}
