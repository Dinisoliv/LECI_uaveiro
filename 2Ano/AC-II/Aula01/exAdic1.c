#define UP 1
#define DOWN 0 
#define STOP -1

int main(){
    int state; int cnt;
    char c = inkey();
    if (c != 's')
    {
        if( c == '+' )
            state = UP;
        if( c == '-' )
            state = DOWN;
        if( state == UP )
            cnt = (cnt + 1) & 0xFF; // Up counter MOD 256
        else
            cnt = (cnt - 1) & 0xFF; // Down counter MOD 256
    }

    if(c == 'r'){
        cnt = 0;
    }
    
}