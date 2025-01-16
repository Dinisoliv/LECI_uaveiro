#include <stdio.h>

int checkIfGeometric(int* array, size_t n, int* count_calc);

int main(void){
    int arr0[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    int arr1[] = {1, 2, 4, 4, 5, 6, 7, 8, 9, 10};
    int arr2[] = {1, 2, 4, 8, 5, 6, 7, 8, 9, 10};
    int arr3[] = {1, 2, 4, 8, 16, 6, 7, 8, 9, 10};
    int arr4[] = {1, 2, 4, 8, 16, 32, 7, 8, 9, 10};
    int arr5[] = {1, 2, 4, 8, 16, 32, 64, 8, 9, 10};
    int arr6[] = {1, 2, 4, 8, 16, 32, 64, 128, 9, 10};
    int arr7[] = {1, 2, 4, 8, 16, 32, 64, 128, 256, 10};
    int arr8[] = {1, 2, 4, 8, 16, 32, 64, 128, 256, 512};

    int* arrays[] = {arr0, arr1, arr2, arr3, arr4, arr5, arr6, arr7, arr8};

    for (int i = 0; i < 9; i++)
    {
        int sucess;
        int count_calc;
        sucess = checkIfGeometric(arrays[i], 10, &count_calc);

        printf("Número de opereções: %d\n", count_calc);
        if(sucess){
            printf("É progressão Geométrica\n");
        }
        else{
            printf("Não é progressão\n");
        }
    }
    
}


int checkIfGeometric(int* array, size_t n, int* count_calc){
    int r = array[1] / array[0];

    *count_calc = 1;

    for (int i = 1; i < n; i++)
    {
        (*count_calc)++;
        if (array[i] != (r * array[i-1]))   
        {
            return 0;
        }
    }
    return 1;
}
