#include <detpic32.h>

int main(void){
    TRISE = TRISE & 0xFFC3;
    TRISB = TRISB | 0x0004;
    
    int cnt = 0;
    while (1)
    {
        int frq_decider = (PORTB & 0x0004) >> 2;
        
        resetCoreTimer();
        if (frq_decider){
            while (readCoreTimer() < 3846153); //5.2 Hz
        }
        else{
            while (readCoreTimer() < 8695652); //2.3 Hz
        }
        cnt++;
        cnt = cnt % 10;

        LATE = (LATE & 0xFFC3) | (cnt << 2);
        
    }
    
}
