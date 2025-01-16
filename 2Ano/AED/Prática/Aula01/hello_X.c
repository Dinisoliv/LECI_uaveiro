#include <stdio.h>

int main(void){
    printf("Insira o seu nome: ");
    char name[30];
    scanf(" %[^\n]", name);
    printf("\nHello %s!\n", name);

    return 0;
}

/*
#include <stdio.h>

int main(void){
    printf("Insira o seu nome: ");
    char name[30];
    fgets(name, sizeof(name), stdin);
    printf("\nHello World %s!\n", name);
    return 0;
}

#include <stdio.h>

int main(void){
    printf("Insira o seu nome: ");
    char name[30];
    gets(name);
    printf("\nHello World %s!\n", name);
    return 0;
}
*/
