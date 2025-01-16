#include <stdio.h>

int checkCondition(int* array, size_t n, unsigned int* ncomps);

int main(void){
    int array0[] = {1,2,3,4,5,6,7,8,9,10}; 
    int array1[] = {1,2,1,4,5,6,7,8,9,10};
    int array2[] = {1,2,1,3,2,6,7,8,9,10};
    int array3[] = {0,2,2,0,3,3,0,4,4,0};
    int array4[] = {0,0,0,0,0,0,0,0,0,0};
    int* arrays[] = {array0,array1,array2,array3,array4};
/*
    int array5[] = {1, 2, 3, 4, 5};
    int array6[] = {5, 4, 3, 2, 1};
    int array7[] = {1, 1, 2, 2, 3};
    int array8[] = {0, 1, 2, 0, 4};
    int* arrays5[] = {array5, array6, array7, array8};


    int array9[] = {1, 1, 2, 3, 5, 8, 13, 21, 34, 55};
    int array10[] = {10, 9, 8, 7, 6, 5, 4, 3, 2, 1};
    int array11[] = {1, 0, 1, 0, 1, 0, 1, 0, 1, 0};
    int array12[] = {2, 4, 6, 8, 10, 12, 14, 16, 18, 20};
    int* arrays10[] = {array9, array10, array11, array12};

    int array13[] = {1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765};
    int array14[] = {0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1};
    int array15[] = {3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 48, 51, 54, 57, 60};
    int array16[] = {5, 4, 3, 2, 1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14};
    int* arrays20[] = {array13, array14, array15, array16};

    int array17[] = {0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765, 10946, 17711, 28657, 46368, 75025, 121393, 196418, 317811, 514229, 832040};
    int array18[] = {1, 2, 1, 3, 2, 4, 3, 5, 4, 6, 5, 7, 6, 8, 7, 9, 8, 10, 9, 11, 10, 12, 11, 13, 12, 14, 13, 15, 14, 16};
    int array19[] = {2, 2, 4, 4, 6, 6, 8, 8, 10, 10, 12, 12, 14, 14, 16, 16, 18, 18, 20, 20, 22, 22, 24, 24, 26, 26, 28, 28, 30, 30};
    int array20[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, -1, -2, -3, -4, -5, -6, -7, -8, -9, -10, -11, -12, -13};
    int* arrays30[] = {array17, array18, array19, array20};

    int array21[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40};
    int array22[] = {0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 16, 16, 17, 17, 18, 18, 19, 19};
    int array23[] = {2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80};
    int array24[] = {1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79};
    int* arrays40[] = {array21, array22, array23, array24};
*/
    unsigned int ncomps;

    printf("Arrays ex1\n");

    for (int i = 0; i < 5; i++)
    {
        int n_sucess;

        n_sucess = checkCondition(arrays[i], 10, &ncomps);
        printf("Número de sucessos: %d, array%d\n", n_sucess, i);
        printf("Número de comparações: %d\n", ncomps);
    }
/*
    printf("Arrays de 5\n");

    for (int i = 0; i < 4; i++)
    {
        int n_sucess;

        n_sucess = checkCondition(arrays5[i], 5, &ncomps);
        printf("Número de sucessos: %d, array%d\n", n_sucess, i);
        printf("Número de comparações: %d\n", ncomps);
    }

    printf("Arrays de 10\n");

    for (int i = 0; i < 4; i++)
    {
        int n_sucess;

        n_sucess = checkCondition(arrays10[i], 10, &ncomps);
        printf("Número de sucessos: %d, array%d\n", n_sucess, i);
        printf("Número de comparações: %d\n", ncomps);
    }

    printf("Arrays de 20\n");

    for (int i = 0; i < 4; i++)
    {
        int n_sucess;

        n_sucess = checkCondition(arrays20[i], 20, &ncomps);
        printf("Número de sucessos: %d, array%d\n", n_sucess, i);
        printf("Número de comparações: %d\n", ncomps);
    }

    printf("Arrays de 30\n");
    
    for (int i = 0; i < 4; i++)
    {
        int n_sucess;

        n_sucess = checkCondition(arrays30[i], 30, &ncomps);
        printf("Número de sucessos: %d, array%d\n", n_sucess, i);
        printf("Número de comparações: %d\n", ncomps);
    }

    printf("Arrays de 40\n");

    for (int i = 0; i < 4; i++)
    {
        int n_sucess;

        n_sucess = checkCondition(arrays40[i], 40, &ncomps);
        printf("Número de sucessos: %d, array%d\n", n_sucess, i);
        printf("Número de comparações: %d\n", ncomps);
    }
    */
}


int checkCondition(int* array, size_t n, unsigned int* ncomps){
    int nsucess = 0;
    *ncomps = 0;

    for (int i = 0; i < n-2; i++)
    {
        for (int j = i+1; j < n-1; j++)
        {
            for (int k = k+1; k < n; k++)
            {
                (*ncomps)++;
                if (array[k] == array[i] + array[j])
                {
                    nsucess++;
                }
            }
        }   
    }
    return nsucess;
}