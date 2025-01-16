//
// TO DO : desenvolva um algoritmo para verificar se um numero inteiro positivo
//         e uma capicua
//         Exemplos: 12321 e uma capiacua, mas 123456 nao e
//         USE uma PILHA DE INTEIROS (STACK) e uma FILA DE INTEIROS (QUEUE)
//
// TO DO : design an algorithm to check if the digits of a positive decimal
//         integer number constitue a palindrome
//         Examples: 12321 is a palindrome, but 123456 is not
//         USE a STACK of integers and a QUEUE of integers
//

#include <stdio.h>

#include "IntegersQueue.h"
#include "IntegersStack.h"

int isCapicua(int n);

int main(void) { 
    int number;

    printf("Digite número inteiro positivo: ");
    scanf("%d", &number);

    if (number < 0) {
        printf("Número inválido! Por favor, insira um número positivo.\n");
        return 1;
    }

    if (isCapicua(number)){
        printf("O número %d é uma capicua.\n", number);
    }
    else{
        printf("O número %d não é uma capicua.\n", number);
    }
    
    return 0; 
}

int isCapicua(int n){
    Stack* s = StackCreate(15);
    Queue* q = QueueCreate(15);

    while (n > 0)
    {
        int digit = n % 10;
        StackPush(s, digit);
        QueueEnqueue(q, digit);
        n /= 10;
    }
    int capicua = 1;

    /*
    while (!StackIsEmpty(s) && !QueueIsEmpty(q))
    {
        if (StackPop(s) != QueueDequeue(q))
        {
            capicua = 0;
            break;
        }
    }
    */
    
    int half_size = StackSize(s) / 2;
    for (int i = 0; i < half_size; ++i) {
        if (StackPop(s) != QueueDequeue(q)) {
            capicua = 0;
            break;
        }
    }

    StackDestroy(&s);
    QueueDestroy(&q);

    return capicua;
}
