#include <detpic32.h>

void send2displays(unsigned char value);

int main(void){
    TRISE = TRISE & 0xFFF0;
    TRISB = TRISB & 0x80FF;
    TRISD = TRISD & 0xFF9F;

    LATE = LATE & 0xFFF0;

    int value_dips = 0;
    int value_valid = 0;

    while (1)
    {
        char value = inkey();
        
        if (value != 0)
        {
            if (value == '0')
            {
                LATE = (LATE & 0xFFF0) | 0x0001;
                value_dips = 0;
                value_valid = 1;
            }
            else if (value == '1')
            {
                LATE = (LATE & 0xFFF0) | 0x0002;
                value_dips = 1;
                value_valid = 1;
            }
            else if (value == '2')
            {
                LATE = (LATE & 0xFFF0) | 0x0004;
                value_dips = 2;
                value_valid = 1;
            }
            else if (value == '3')
            {
                LATE = (LATE & 0xFFF0) | 0x0008;
                value_dips = 3;
                value_valid = 1;
            }
            else{
                LATE = (LATE & 0xFFF0) | 0x000F;
                int i=0;
                for(; i < 100; i++){
                        send2displays(0xFF);
                        resetCoreTimer();
                        while(readCoreTimer()<200000);
                    }
                
                LATE = LATE & 0xFFF0;
                value_dips = 0x00;
                value_valid = 0;
            }
            
        }
        resetCoreTimer();
        while(readCoreTimer() < 200000);
        if (value_valid)
        {
            send2displays(value_dips);
        }else{
            LATD=(LATD | 0x0060);
            LATB=(LATB & 0x80FF);  
        }
        
    }


    return 0;
}


void send2displays(unsigned char value){
    static const char disp7Scodes[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 
        0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71};
    static char displayFlag = 0;
    int dh = value >> 4;
    int dl = value & 0x0F;

    if(displayFlag == 0){
        LATD=(LATD & 0xFF9F) | (0x0020);
        LATB = (LATB & 0x80FF) | (disp7Scodes[dl] << 8); 
    }
    else{
        LATD=(LATD & 0xFF9F) | (0x0040);
        LATB = (LATB & 0x80FF) | (disp7Scodes[dh] << 8);
    }
    displayFlag = !displayFlag;
}
