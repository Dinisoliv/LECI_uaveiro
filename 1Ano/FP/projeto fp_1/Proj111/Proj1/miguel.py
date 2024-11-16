import random
palavras = ["python",'adeus','koala']
palavra = random.choice(palavras).upper() #Letras maiúsculas
erros = 0
letras_erradas = []
letras_corretas = []
alfabeto = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
        

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
        else:
            resultado += '_' #Vai substituir cada letra por "_"
    return resultado
    

 
while True:
    print("\n" + mostrar_forca(erros))
    print(mostrar_palavra(palavra, letras_corretas))
    print("LETRAS ERRADAS:",sorted(letras_erradas))
    print("NÚMERO DE ERROS:", erros)  # Mostra o número de erros    

    if mostrar_palavra(palavra, letras_corretas) == palavra:    #Se acertar as letras todas, e a palavra aparecer na função "mostrar_palavra" ...
        print('PARABÉNS VOCÊ GANHOU! A PALAVRA ERA:',palavra,"\n")
        break # Acaba o jogo
            
    if erros == 7: #Se o número de erros chegar ao máximo, acaba o jogo
        print('NÃO CONSEGUISTE ADIVINHAR! A PALAVRA ERA: ',palavra,"\n")
        break # Acaba o jogo
        
    letra = input("LETRA: ").upper() #Pede a letra
    
    if letra not in alfabeto:
        print("\nESSE CARATER É INVÁLIDO \nTENTE OUTRA VEZ." )
        continue
        
    if letra in letras_corretas or letra in letras_erradas: #Se a letra já tiver sido guardada volta ao inicio da mesma tentativa
        print("VOCÊ JÁ ADIVINHOU ESTA LETRA.")
        continue
        
    if letra in palavra:
        letras_corretas.append(letra) # adiciona a letra à lista das letras corretas, para o caso de voltar a ser escolhida
    else:
        letras_erradas.append(letra)    #adiciona a letra à lista das erradas e aumenta o erro em 1
        erros += 1
            