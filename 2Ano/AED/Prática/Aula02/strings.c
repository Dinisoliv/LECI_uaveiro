#include<stdio.h>
#include<string.h>

char stringToLower(char string[]); 

int main(void){
    char string1[20];
    printf("Escreva uma string1: ");
    scanf("%s", string1);
    char string2[20];
    printf("\nEscreva uma string2: ");
    scanf("%s", string2);

    int count = 0; 
    for (int i = 0; i < 20; i++)
    {
        if (isalpha(string1[i]))
        {
            count += 1;
        }
        
    }

    printf("Número de letras em string1: %s", count);

    //Contar caracteres
    count = 0;
    while (1)
    {
        int i = 0;
        if (isupper(string2[i]))
        {
            count += 1;
        }
        if (string2[i] == '\0')
        {
            break;
        }
        i++;
    }

    printf("Número de caractéres maisculos em string 2: %d", count);

    printf("lower - string1: %s", stringToLower(string1));
    printf("lower - string2: %s", stringToLower(string2));    

    compareStrings(string1, string2);

    char strcopy[20];
    mencpy(string2, strcopy, strlen(string2));
    printf("%s", strcopy);

    char *concatStr = (char *)malloc((strlen(string2) + strlen(strcopy) + 1) * sizeof(char));
    if (concatStr == NULL) {
        printf("Erro ao alocar memória!\n");
        free(strcopy); // Liberar a memória da cópia em caso de erro
        return 1;
    }

    strcpy(concatStr, string2);
    strcat(concatStr, strcopy);

    printf("String resultante da concatenação: %s\n", concatStr);

    free(concatStr);

    return 0; //END MAIN
}

char stringToLower(char string[]){
    for (int i = 0; i < 20; i++)
    {
    if (string[i] == '\0')
    {
        break;
    }
    string[i] = toLower(string[i]);  
    }

    return string;
}

void compareStrings(char str1[], char str2[]){
    int result = strcmp(str1, str2);
    
    if (result < 0) {
        printf("\"%s\" comes before \"%s\" lexicographically.\n", str1, str2);
    } else if (result > 0) {
        printf("\"%s\" comes after \"%s\" lexicographically.\n", str1, str2);
    } else {
        printf("\"%s\" and \"%s\" are lexicographically equal.\n", str1, str2);
    }
}

char* stringCopy(char str[]){
    char* str2;
    str2 = (char*)malloc(20);

    strcpy(str2, str);
    return (char*)str2;
}