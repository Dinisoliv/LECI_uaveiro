#include <stdio.h>
#include <math.h>

int main(void) {
    printf("Tabela com os quadrados e as raízes quadradas dos primeiros números naturais\n");
    printf("Insira o número de linhas: ");
    
    int numberLines, i;
    scanf("%d", &numberLines); 

    printf("%-10s %-10s %-10s\n", "Nº", "Square", "Square Root");
    for (i = 1; i <= numberLines; i++) { 
        printf("%-10d%-10d %-10.3f\n", i, i * i, sqrt(i));
    }

    return 0;
}
