#include <stdio.h>

int recursive1(int n, int* count);
int recursive2(int n, int* count);
int recursive3(int n, int* count);

int main(){
    int countA, countB, countC;

    for (int i = 0; i < 1025; i++)
    {
        countA = 0; countB = 0, countC = 0;
        recursive1(i, &countA);
        printf("rcrs(%d): %-5d", i, countA);

        recursive2(i, &countB);
        printf("rcrs(%d): %-5d", i, countB);

        recursive3(i, &countC);
        printf("rcrs(%d): %-5d", i, countC);

        printf("\n");
        
    }
    

    return 0;
}

int recursive1(int n, int *count){
    if (n<1)
    {
        return -1;
    }
    
    if (n == 1)
    {
        return 1;
    }

    (*count)++;

    return recursive1(n/2, count) + n;
}

int recursive2(int n, int* count){
    if (n<1)
    {
        return -1;
    }
    
    if (n == 1)
    {
        return 1;
    }

    (*count) += 2;

    return recursive2(n/2, count) + recursive2((n+1)/2, count) + n;
}

int recursive3(int n, int* count){
    if (n<1)
    {
        return -1;
    }
    
    if (n == 1)
    {
        return 1;
    }
    
    (*count)++;

    if (n%2 == 0)
    {
        return 2* recursive3(n/2, count) + n;
    }

    (*count)++;

    return recursive3(n/2, count) + recursive3((n+1) / 2, count) + n;
    
}