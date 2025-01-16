#include <stdio.h>

int main(void){

    
    printf("Fatorião: ");
}

int* fatoriao(){
    int n;

    unsigned long long** fatorials;
    fatorials = precompute_factorial(n);

    while (n < 1000000)
    {
        
        n++;
    }
    
}

int fatorial(int n){
    if (n < 0)
    {
        return -1;
    }
    
    unsigned long long result = 1;
    for (int i = 2; i < n; i++)
    {
        result *= i;
    }

    return result;
}

unsigned long long** precompute_factorial(int n){
    unsigned long long factorials[n+1];
    factorials[0] = 1;
    
    for (int i = 2; i < n; i++)
    {
        factorials[i] = factorials[i-1] * i; 
    }

    return &factorials;
    
}