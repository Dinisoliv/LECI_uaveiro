#define SIZE 10

void main(void) {
    static int lista[SIZE];
    int i, j, aux;

    // inserir aqui o código para leitura de valores e
    // preenchimento do array

    for (i = 0; i < SIZE - 1; i++) {
        for (j = i + 1; j < SIZE; j++) {
            if (lista[i] > lista[j]) {
                aux = lista[i];
                lista[i] = lista[j];
                lista[j] = aux;
            }
        }
    }

    // inserir aqui o código de impressão do conteúdo do array
}

#define SIZE 10

void main(void){
	static int lista[SIZE];
	int *pi, *pj , aux;
	
	for (pi = lista; pi < lista + (SIZE - 1), pi++){
		for(pj = lista + 1; pj < lista + SIZE, pj++){
			if(*pi > *pj){
				aux = *pi;
				*pi = *pj;
				*pj = aux;
			}
		}
	}
}