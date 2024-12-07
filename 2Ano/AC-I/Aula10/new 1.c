#include <stdio.h>

// Declaração das funções
float xtoy(float x, int y);
int abs(int val);

int main() {
    float x;
    int y;
    float result;

    // Solicita ao usuário os valores de x e y
    printf("Digite o valor de x (real): ");
    scanf("%f", &x);

    printf("Digite o valor de y (inteiro): ");
    scanf("%d", &y);

    // Calcula x^y chamando a função xtoy
    result = xtoy(x, y);

    // Exibe o resultado
    printf("O resultado de %.2f elevado a %d é: %.2f\n", x, y, result);

    return 0;
}
