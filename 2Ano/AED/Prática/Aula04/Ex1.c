#include <stdio.h>

int checkCondition(unsigned * array, size_t n);

int NCOMPS;

int main(void){
    int array0[] = {1,2,3,4,5,6,7,8,9,10}; 
    int array1[] = {1,2,1,4,5,6,7,8,9,10};
    int array2[] = {1,2,1,3,2,6,7,8,9,10};
    int array3[] = {0,2,2,0,3,3,0,4,4,0};
    int array4[] = {0,0,0,0,0,0,0,0,0,0};
    int* arrays[] = {array0,array1,array2,array3,array4};

    for (int i = 0; i < 5; i++)
    {
        int n_sucess;
        NCOMPS = 0;
        n_sucess = checkCondition(arrays[i], 10);

        printf("Número de sucessos: %d, array%d\n", n_sucess, i);
        printf("Número de comparações: %d\n", NCOMPS);
    }
    

    return 0;
}

int checkCondition(unsigned int* array, size_t n){
    if (n < 2)
    {
        return 0;
        //NCOMPS++;
    }
    
    int count = 0;

    for (int i = 1; i < n-1; i++)
    {
        if (array[i] == array[i + 1] + array[i - 1])
        {
            count++;
        }
        NCOMPS++;
    }

    return count;
}