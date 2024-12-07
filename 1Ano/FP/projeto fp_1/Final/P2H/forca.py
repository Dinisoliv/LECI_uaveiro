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
        """
           ,
        """
        \033[31m
           ______
          |      |
          O      |
         /|\\     |
         / \\     |
         ________|
         \033[00m
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


#Esta função troca todas as letras que apresentem acentos na palavra por letras que não tenham acentos para quando o jogador tentar adivinhar uma letra, todas as letras, até mesmo com acentos, serem mostradas.
    
def remover_acentos(palavra): 
     acentos = {'Á': 'A', 'Â': 'A', 'Ã': 'A', 'É': 'E', 'Ê': 'E', 'Í': 'I', 'Ó': 'O', 'Ô': 'O', 'Õ': 'O', 'Ú': 'U', 'Ç': 'C'}
     for acentos, letra in acentos.items():
        if acentos in palavra:
            palavra1 = palavra.replace(acentos, letra)
            return palavra1 
            

def main():
    
    import sys                  # INCLUA estas 3 linhas para permitir
    if len(sys.argv) > 1:       # correr o programa com palavras dadas:
        words = sys.argv[1:]    #   python3 forca.py duas palavras
        
    erros = 0 #começa com 0 erros
    count = 0
    ajudas = 2 #começa com 2 ajudas
    
    #Listas de carateres aceitados
    acentos2 = ['Á', 'Â', 'Ã', 'É', 'Ê', 'Í', 'Ó', 'Ô', 'Õ', 'Ú', 'Ç']
    alfabeto = [ 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' ]
    from wordlist import words1, words2
    
    # Descomente a linha que interessar para testar
    #words = words1              # palavras sem acentos nem cedilhas.
    #words = words2             # palavras com acentos ou cedilhas.
    words = words1 + words2    # palavras de ambos os tipos
   
   
   
    # Escolhe palavra aleatoriamente
    palavra = random.choice(words).upper()
    if acentos2 in list(palavra):
        palavra2 = remover_acentos(palavra)
    else:
        palavra2 = palavra
    
    #Titulo do jogo
    print("\n\033[1;33m -=-=-=-=-=-=-\033[00m")
    print("\033[1;33m JOGO DA FORCA\033[00m")
    print("\033[1;33m -=-=-=-=-=-=-\033[00m")
    
    # Complete o programa
    while True:
        print("\n\033[1;32m___{}ª TENTATIVA___\033[00m".format(count+1))
        print("\n     ERROS:", erros)  # Mostra o número de erros
        print("\n", mostrar_forca(erros))
        print(mostrar_palavra(palavra, letras_corretas))
        print("LETRAS ERRADAS:",sorted(letras_erradas))
        print("PARA OBTER AJUDA, ESCREVA ´AJUDA`")
        print("TEM {} AJUDA(S) RESTANTES".format(ajudas))
        print('SE PRETENDE DESISTIR, ESCREVA ´DESISTO` ')
        if count != 0:
            lista = ''.join(alfabeto)
            print("LETRAS RESTANTES:", lista)

            
        if erros != 7 and mostrar_palavra(palavra, letras_corretas) != palavra :
            letra = input("LETRA: ").upper() #Pede a letra
            
        if mostrar_palavra(palavra, letras_corretas) == palavra or letra == palavra2 or letra == palavra:    #Se acertar as letras todas, e a palavra aparecer na função "mostrar_palavra" ...
            print('\n\033[1;32mPARABÉNS VOCÊ GANHOU! A PALAVRA ERA:\033[00m',palavra,"\n")
            print("\033[1;33m\nJOGO CRIADO POR:\nDINIS OLIVEIRA nº119193\nMIGUEL SANTOS nº119649\033[00m\n")
            break # Acaba o jogo
        
        if erros == 7 or letra == 'DESISTO' : #Se o número de erros chegar ao máximo, ou se o jogador desistir, acaba o jogo
            print('\n\033[1;31mNÃO CONSEGUISTE ADIVINHAR! A PALAVRA ERA:\033[00m ',palavra,"\n")
            print("\033[31m---------\033[00m")
            print("\033[31mGAME OVER\033[00m")
            print("\033[31m---------\033[00m\n")
            print("\033[1;33m\nJOGO CRIADO POR:\nDINIS OLIVEIRA nº119193\nMIGUEL SANTOS nº119649\033[00m\n")
            break # Acaba o jogo
            
        
        
        if letra == 'AJUDA':
            ajuda1 = True
            lista_palavra = list(palavra2)
            if ajudas == 0:
                print("\n\033[31mNÃO TENS AJUDAS RESTANTES\033[00m\n")
            else:
                ajudas-=1
                print("\n\033[34mVOCÊ USOU UMA AJUDA\033[00m\n")
                while ajuda1 == True:
                    for letra1 in palavra2:
                        if letra1 in letras_corretas:
                            continue
                        else: 
                            letra = letra1            
                            ajuda1 = False       
            
        if letra in letras_corretas or letra in letras_erradas: #Se a letra já tiver sido guardada volta ao inicio da mesma tentativa
            print("\n\033[34mVOCÊ JÁ ADIVINHOU ESTA LETRA.\033[00m")
            continue
            
        if letra not in acentos2:    
            if letra not in alfabeto and letra != 'AJUDA':
                print("\n\033[31mESSE CARATER É INVÁLIDO \nTENTE OUTRA VEZ.\033[00m" )
                continue
        
        if letra in palavra2:
            letras_corretas.append(letra)   # adiciona a letra à lista das letras corretas, para o caso de voltar a ser escolhida
            for i in range(len(alfabeto)):
                if alfabeto[i] ==letra:
                    alfabeto[i] = "+"
        elif(letra not in palavra2 and letra != 'AJUDA'):
            letras_erradas.append(letra)    #adiciona a letra à lista das erradas e aumenta o erro em 1
            erros += 1
            for i in range(len(alfabeto)):
                if alfabeto[i] ==letra:
                    alfabeto[i] = "-"
                    
        #Estas linhas de codigo adicionam à lista de letras corretas , as letras com acentos          
        if 'A' in letras_corretas:
            letras_corretas.append('Á')
            letras_corretas.append('Â')
            letras_corretas.append('Ã')
        if 'E' in letras_corretas:
            letras_corretas.append('É')
            letras_corretas.append('Ê')
        if 'I' in letras_corretas:
            letras_corretas.append('Í')
        if 'O' in letras_corretas:
            letras_corretas.append('Ó')
            letras_corretas.append('Ô')
        if 'U' in letras_corretas:
            letras_corretas.append('Ú')
        if 'C' in letras_corretas:
       	    letras_corretas.append('Ç')
       
        count += 1

if __name__ == "__main__":
    main()
