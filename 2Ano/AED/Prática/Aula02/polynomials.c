#include <stdio.h>

void DisplayPol(double* coef, size_t degree);
double ComputePol(double* coef, size_t degree, double x);

int main(void){

}

void DisplayPol(double* coef, size_t degree){
    if (coef == NULL || degree < 0)
    {
        return NULL;
    }

    for (size_t i = 0; i < degree; i++)
    {
        if (coef[i] != 0)
        {
            printf("%.6lf * x^%d + ", coef[i], degree-i);
        }
    }
    printf("%d \n", coef[degree]);    
    
}

double ComputePol(double* coef, size_t degree, double x){
    if (coef == NULL || degree < 0)
    {
        return 0;
    }


}