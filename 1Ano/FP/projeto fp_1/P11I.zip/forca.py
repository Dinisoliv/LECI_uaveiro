# Preencha a lista com os números mecanográficos dos autores.
AUTORES = [120515]

import random

# Defina funções aqui.

print("-----JOGO DA FORCA-----")
boneco0= """__________ 
|
|     
| 
|
|__________ """

boneco1= """__________ 
|
|     o
| 
|
|__________ """
         
boneco2= """__________ 
|
|     o
|     | 
|
|__________ """

boneco3="""__________ 
|
|     o
|    /| 
|
|__________ """

boneco4="""__________ 
|
|     o
|    /|\ 
|
|__________ """

boneco5="""__________ 
|
|     o
|    /|\ 
|    /
|__________ """

boneco6="""__________ 
|
|     o
|    /|\ 
|    / \\
|__________ """

print(boneco0)
print("\n")
print("Palavra: ")

def adicionar_acentos(letra):
    # Dicionário de mapeamento de letras sem acento para letras com acento
    acentos = {
        'a': ['à', 'á', 'ã', 'â'],
        'e': ['é', 'ê'],
        'i': ['í'], 
        'o': ['ó', 'õ'],
        'u': ['ú'],
        'c': ['ç']
    }

    variacoes_letra = [letra]
    if letra in acentos:
        variacoes_letra += acentos[letra]

    # Retorna todas as correspondências possíveis da letra
    return variacoes_letra


def expandir_letras_corretas(letras_corretas):
    # Converte uma lista de letras corretas numa lista que contêm
    # todas as variações possíveis dessas letras com acentos
    resultado = []
    for letra in letras_corretas:
        resultado += adicionar_acentos(letra)
    return resultado

def mostrar_boneco(tentativas):
    if tentativas == 6:
        print(boneco0)
    elif tentativas == 5:
        print(boneco1)
    elif tentativas == 4:
        print(boneco2)
    elif tentativas == 3:
        print(boneco3)
    elif tentativas == 2:
        print(boneco4)
    elif tentativas == 1:
        print(boneco5)
    else:
        print(boneco6)


letras_erradas = []
letras_corretas = []
vidas = 6

def main():  
    
    from wordlist import words1, words2
    
    # Descomente a linha que interessar para testar
    #words = words1              # palavras sem acentos nem cedilhas.
    words = words2             # palavras com acentos ou cedilhas.
    #words = words1 + words2    # palavras de ambos os tipos
  
    import sys                  # INCLUA estas 3 linhas para permitir
    if len(sys.argv) > 1:       # correr o programa com palavras dadas:
        words = sys.argv[1:]    #   python3 forca.py duas palavras  
  
  # Escolhe palavra aleatoriamente
    secret = random.choice(words)
    print(secret)
    word = secret
    letras_corretas = []
    tentativas = 6

    while True:
        letras_corretas_com_acentos = expandir_letras_corretas(letras_corretas)
        palavra_oculta = ""
        for letra in word:
            if letra in letras_corretas_com_acentos:
                palavra_oculta += letra
            else:
                palavra_oculta += "_"

        print("\nPalavra: " + palavra_oculta)
        print("Tentativas restantes: " + str(tentativas))

        if palavra_oculta == word:
            print("Parabéns! Conseguiste.\nA palavra era: " + word)
            break

        if tentativas == 0:
            print("Perdeste! Tenta para a próxima.\nA palavra era: " + word)
            break

        letra = input("Letra: ").lower()
        
        if len(letra) != 1 or not letra.isalpha():
            print("Escolhe uma letra de cada vez!")
            continue

        if letra in letras_corretas:
            print("Já tentaste essa letra.")
            continue

        # Obter as variações possível da letra
        # Exemplo: um input de 'a' é válido para 'á', 'â', etc
        variacoes_letra = adicionar_acentos(letra)

        # Pelo menos uma das variações possíveis da letra está presente na palavra?
        letra_foi_encontrada = False
        for letra_acentuada in variacoes_letra:
            if letra_acentuada in word:
                letras_corretas.append(letra)
                print("Letras corretas: ",letras_corretas)
                mostrar_boneco(tentativas)
                letra_foi_encontrada = True
                break

        # Se nenhuma das variações estiver presente na palavra, então a letra está errada
        if not letra_foi_encontrada:
            tentativas -= 1
            letras_erradas.append(letra)
            print("Letras erradas: ", letras_erradas)
            mostrar_boneco(tentativas)
            print("Letra incorreta. Tente novamente.")
            


if __name__ == "__main__":
    print("Bem-vindo ao jogo da forca!")
    main()
