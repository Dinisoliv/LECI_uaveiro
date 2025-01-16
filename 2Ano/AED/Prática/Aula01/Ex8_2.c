#include <stdio.h>
#include <math.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

int main(void){
    printf("Tabela de senos e cossenos \n");

    printf("Insira o menor ângulo (em graus): ");
    int smallAngle;
    scanf("%d", &smallAngle);
    printf("\n");

    printf("Insira o maior ângulo: ");
    int bigAngle;
    scanf("%d", &bigAngle); 
    printf("\n");

    printf("Espaçamento entre ângulos: ");
    int spacingAngles;
    scanf("%d", &spacingAngles);
    printf("\n");

    FILE *file = fopen("file.txt", "w");

    if (file == NULL){
        printf("Erro ao abrir o arquivo!\n");
        return 1;
    }

    fprintf(file, "%-3s %-13s %-13s \n", "ang", "sin(ang)", "cos(ang)");
    fprintf(file, "%-3s %-13s %-13s \n", "---", "-------------", "-------------");

    for (int i = smallAngle; i <= bigAngle; i +=spacingAngles)
    {
        double seno = sin(i * M_PI / 180.0);
        double coseno = cos(i * M_PI / 180.0);
        fprintf(file, "%-3d %-13.11f %-13.11f \n" , i, seno, coseno);
        //printf("%f", seno*seno + coseno*coseno);
        //printf("\n");
    }

    fclose(file);

    return 0;
}