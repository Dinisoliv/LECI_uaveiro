#include <detpic32.h>

int main(void){
    TRISE = TRISE & 0xFF87; //1111 1111 1000 0111
    int counter = 0;
    while (1)
    {
       LATE = (LATE & 0XFF87) | (counter << 3);
       resetCoreTimer();
       while (readCoreTimer() < 7407407);
       counter = (counter + 9) % 10; 
    }
     
    return 0;
}
