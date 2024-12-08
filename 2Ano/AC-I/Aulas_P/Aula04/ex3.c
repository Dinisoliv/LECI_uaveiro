//Código C - Guião 4 - exercicio 3 - Índices

#define SIZE 4
int array[4] = {7692, 23, 5, 234};

void main(void)
{
	int soma = 0;

	int i = 0;

	while (i < SIZE)
	{
		soma = soma + array[i];
	}
	print_int10(soma);
}