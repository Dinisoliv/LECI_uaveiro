 import random

erros = 0
tentativas_maximas = 6
letras_corretas = []
letras_erradas = []

# Defina funções aqui.
def mostrar_forca(erros):
    desenho_forca = [
        """
           ______
          |      |
                 |
                 |
                 |
         ________|
        """,
        """
           ______
          |      |
          O      |
                 |
                 |
         ________|
        """,
        """
           ______
          |      |
          O      |
          |      |
                 |
         ________|
        """,
        """
           ______
          |      |
          O      |
         /|      |
                 |
         ________|
        """,
        """
           ______
          |      |
          O      |
         /|\\    |
                 |
         ________|
        """,
        """
           ______
          |      |
          O      |
         /|\\    |
         /       |
         ________|
        """,
        """
           ______
          |      |
          O      |
         /|\\    |
         / \\    |
         ________|
        """
    ]
    if erros < len(desenho_forca):
        return desenho_forca[erros]
    else:
        return desenho_forca[-1]

def mostrar_palavra(palavra, letras_corretas):
    resultado = ''
    for letra in palavra:
        if letra in letras_corretas:
            resultado += letra
        else:
            resultado += '_'
    return resultado

def main():
    from wordlist import words1, words2
    
    # Descomente a linha que interessar para testar
    words = words1              # palavras sem acentos nem cedilhas.
    #words = words2             # palavras com acentos ou cedilhas.
    #words = words1 + words2    # palavras de ambos os tipos
   
    # Escolhe palavra aleatoriamente
    secret = random.choice(words).upper()

    while True:
        print('\n', mostrar_forca(erros))
        print(mostrar_palavra(secret, letras_corretas))
        print("Letras erradas:", ' '.join(sorted(letras_erradas))
        print("Número de erros:", erros)  # Mostra o número de erros
    
        if mostrar_palavra(secret, letras_corretas) == secret:
            print("\nParabéns, você ganhou! A palavra era:", secret)
            break

        if erros == tentativas_maximas:
            print("\nVocê perdeu! A palavra era:", secret)
            break
        
        letra = input("Adivinhe uma letra: ").upper()

        if letra in secret:
            letras_corretas.append(letra)
        else:
            letras_erradas.append(letra)
            erros += 1

if __name__ == "__main__":
    main()
