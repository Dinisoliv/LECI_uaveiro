# Preencha a lista com os números mecanográficos dos autores.
AUTORES = [...]

import random

# Defina funções aqui.
...


def main():
    from wordlist import words1, words2
    
    # Descomente a linha que interessar para testar
    words = words1              # palavras sem acentos nem cedilhas.
    #words = words2             # palavras com acentos ou cedilhas.
    #words = words1 + words2    # palavras de ambos os tipos
   
    # Escolhe palavra aleatoriamente
    secret = random.choice(words).upper()

    # Complete o programa
    ...


if __name__ == "__main__":
    main()

