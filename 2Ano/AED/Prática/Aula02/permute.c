#include<stdio.h>

void Permute(int* a, int* b, int* c);

int main(void){
    int x, y, z;
    x= 1, y=2, z=3;
    printf("x: %d y: %d z: %d",x ,y ,z);
    Permute(&x, &y ,&z);
    printf("x: %d y: %d z: %d",x ,y ,z);
}

void Permute(int* a, int* b, int* c){
    int aux;
    aux = *a;
    *a = *b;
    *b = *c;
    *c = aux;
}

