# Preencha a lista com os números mecanográficos dos autores.
AUTORES = [119193,119649]

import random

letras_erradas = []
letras_corretas = []

# Defina funções aqui.

#Função para desenhar a forca tendo em conta os erros
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
         /|\\     |
                 |
         ________|
        """,
        """
           ______
          |      |
          O      |
         /|\\     |
         /       |
         ________|
        """,
        """
           ______
          |      |
          O      |
         /|\\     |
         / \\     |
         ________|
        """,
        """\033[31m
           ______
          |      |
          O      |
         /|\\     |
         / \\     |
         ________|\033[00m\n
        """
    ]
    if erros < len(desenho_forca):  #Tendo em conta os erros, muda de imagem
        return desenho_forca[erros]
    else:
        return desenho_forca[-1]

def mostrar_palavra(palavra, letras_corretas):
    resultado = ''
    for letra in palavra:
        if letra in letras_corretas:
            resultado+= letra
        else: resultado += '_' #Vai substituir cada letra por "_"
    return resultado

def main():
    erros = 0
    count = 0
    ajudas = 2
    
    
    alfabeto = [ 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' ]
    from wordlist import words1, words2
    
    # Descomente a linha que interessar para testar
    #words = words1              # palavras sem acentos nem cedilhas.
    words = words2             # palavras com acentos ou cedilhas.
    #words = words1 + words2    # palavras de ambos os tipos
   
    
   
    # Escolhe palavra aleatoriamente
    palavra = random.choice(words).upper()
    
    #Titulo do jogo
    print("\033[1;33m -=-=-=-=-=-=-\033[00m")
    print("\033[1;33m JOGO DA FORCA\033[00m")
    print("\033[1;33m -=-=-=-=-=-=-\033[00m")
    
    #Para testar (apagar depois)
    print("\n",palavra,"\n")
    
    # Complete o programa
    while True:
        print("\n\033[1;32m___{}ª TENTATIVA___\033[00m".format(count+1))
        print("\n     ERROS:", erros)  # Mostra o número de erros
        print("\n", mostrar_forca(erros))
        print(mostrar_palavra(palavra, letras_corretas))
        print("LETRAS ERRADAS:",sorted(letras_erradas))
        print("PARA OBTER AJUDA, ESCREVA ´AJUDA`")
        print("TEM {} AJUDA(S) RESTANTES".format(ajudas))
        if count != 0:
            lista = ''.join(alfabeto)
            print("LETRAS RESTANTES:", lista)

        if mostrar_palavra(palavra, letras_corretas) == palavra:    #Se acertar as letras todas, e a palavra aparecer na função "mostrar_palavra" ...
            print('\n\033[1;32mPARABÉNS VOCÊ GANHOU! A PALAVRA ERA:\033[00m',palavra,"\n")
            break # Acaba o jogo
            
        if erros == 7: #Se o número de erros chegar ao máximo, acaba o jogo
            print('\n\033[1;31mNÃO CONSEGUISTE ADIVINHAR! A PALAVRA ERA:\033[00m ',palavra,"\n")
            print("\033[31m---------\033[00m")
            print("\033[31mGAME OVER\033[00m")
            print("\033[31m---------\033[00m\n")
            break # Acaba o jogo 
                
            
        letra = input("LETRA: ").upper() #Pede a letra
        
        if ('Ã' in palavra) and letra == 'A':
            resultado = 'Ã'
        if ('Á' in palavra) and letra == 'A':
            resultado = 'Á'
        if ('É' in palavra) and letra == 'E':
            resultado = 'É'
        if ('Ê' in palavra) and letra == 'E':
            resultado = 'Ê'
        if ('Í' in palavra) and letra == 'I':
            resultado = 'Í'
        if ('Õ' in palavra) and letra == 'O':
            resultado = 'Õ'
        if ('Ó' in palavra) and letra == 'O':
            resultado = 'Ó'
        if ('Ú' in palavra) and letra == 'U':
            resultado = 'Ú'
        
        if letra == 'AJUDA':
            ajuda1 = True
            lista_palavra = list(palavra)
            if ajudas == 0:
                print("\n\033[31mNÃO TENS AJUDAS RESTANTES\033[00m\n")
            else:
                ajudas-=1
                print("\n\033[34mVOCÊ USOU UMA AJUDA\033[00m\n")
                while ajuda1 == True:
                    for i in range(0,len(lista_palavra)):
                        letra1 = lista_palavra[i]
                        if letra1 in letras_corretas:
                            continue
                        else: 
                            letra = letra1            
                            ajuda1 = False
        
            
        if letra in letras_corretas or letra in letras_erradas: #Se a letra já tiver sido guardada volta ao inicio da mesma tentativa
            print("\n\033[34mVOCÊ JÁ ADIVINHOU ESTA LETRA.\033[00m")
            continue
            
        if letra not in alfabeto and letra != 'AJUDA':
            print("\n\033[31mESSE CARATER É INVÁLIDO \nTENTE OUTRA VEZ.\033[00m" )
            continue
        
        if letra in palavra:
            letras_corretas.append(letra)   # adiciona a letra à lista das letras corretas, para o caso de voltar a ser escolhida
            for i in range(len(alfabeto)):
                if alfabeto[i] ==letra:
                    alfabeto[i] = "+"
        elif(letra not in palavra and letra != 'AJUDA'):
            letras_erradas.append(letra)    #adiciona a letra à lista das erradas e aumenta o erro em 1
            erros += 1
            for i in range(len(alfabeto)):
                if alfabeto[i] ==letra:
                    alfabeto[i] = "-"
                    
        #Estas linhas de codigo adicionam à lista de letras corretas , as letras com acentos          
        
            
        
        count += 1

if __name__ == "__main__":
    main()
