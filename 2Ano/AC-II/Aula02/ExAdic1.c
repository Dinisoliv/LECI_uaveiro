int main(void){
    int cnt1 = 0;
    int cnt5 = 0;
    int cnt10 = 0;

    while (1)
    {
        putchar('\r');
        printInt(cnt1, 10 | 4 << 16);
        printInt(cnt5, 10 | 4 << 16);
        printInt(cnt10, 10 | 4 << 16);
        delay(100);
        cnt10++;
        if (cnt10%2 == 0)
            cnt5++;
        if (cnt10%10 == 0)
            cnt1++;   
    }
    return 0;
}