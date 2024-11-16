# Preencha a lista com os números mecanográficos dos autores.
import os  # Importei a livraria que me permite usar a função para limpar o ecrã
import random
#import termcolor
AUTORES = [118772]


def hangman(c):  
    """Esta função desenha o boneco na forca conforme o nº de erros."""

    hangpose = ("""        
_____
|   |
|   
|  
|  
|_______   """,
                """
_____
|   |
|   O
|  
|  
|_______  """,
                """
_____
|   |
|   O
|   |
|  
|_______  """,
                """
_____
|   |
|   O
|  /|
|  
|_______  """,
                """
_____
|   |
|   O
|  /|\\
|  
|_______  """,
                """
_____
|   |
|   O
|  /|\\
|  /
|_______  """,
                """
_____
|   |
|   O
|  /|\\
|  / \\
|_______  """)
    return (hangpose[c])


def funny ():  
    """Esta função é funny."""
    print("""
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠴⠒⠒⠲⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢀⡤⠶⠲⠦⣄⠀⠀⠀⣀⣀⣀⣀⣤⣤⣼⣃⣀⡴⠋⠛⢦⢻⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⣰⢋⡴⠖⠦⣄⣨⠷⠚⠉⠉⠀⠀⠀⠀⠀⠀⠈⠉⠲⢤⡀⢈⡇⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⣏⢸⠀⠀⣰⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣼⠃⠀⠀⠀⠀⠀⠀⠀⢀⣀⡠⠤⠤⠤⠤⠄⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢻⡜⢦⡞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡄⠀⠀⠀⠀⢀⠴⠋⢡⣦⣤⣀⠀⠀⠀⠀⠀⠀⠉⠑⠲⠤⣀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢹⡾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⠀⠀⠀⠀⠀⢷⠀⠀⠀⣰⠃⠀⠀⣾⣿⠛⠻⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠢⣄⠀⠀⠀⠀
⠀⠀⠀⢸⡇⠀⠀⠀⠀⠐⠶⠆⠀⠀⠀⠀⠀⠀⠀⠉⠁⠀⠀⠀⠀⠀⢸⡄⠀⠀⡇⠀⠀⣸⣿⣷⣶⣶⠿⠃⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⣄⠀⠀
⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⣠⡀⣀⠤⠒⠋⠉⠙⠒⠾⣿⠇⠀⠀⠀⠀⠀⢧⠀⠀⢧⠀⢠⣿⡏⠀⠈⣿⡦⠀⣿⡇⢀⣼⣶⢄⣀⣀⡀⠀⠀⢠⣦⡌⢣⡀
⠀⠀⠀⢸⡇⠀⠀⠀⠀⠈⢿⠟⠁⠀⠰⢿⡿⠂⠀⠀⠈⢣⠀⠀⠀⠀⠀⠸⡇⠀⠈⢦⠘⠻⠿⣶⣾⡿⠃⠀⣿⣥⣾⠟⢡⣾⡟⠛⢿⣧⠀⣼⣿⠃⠀⢳
⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⡞⠀⠀⣄⣠⣼⢿⣦⣴⠆⠀⠈⡆⠀⠀⠀⠀⢠⡇⠀⠀⠀⠳⣄⠀⠀⠀⠀⠀⣠⣿⡿⠃⠀⣾⣿⠛⠻⢿⡿⢰⣿⠏⠀⠀⢸
⠀⠀⠀⠸⣇⠀⠀⠀⠀⠀⢷⠀⠀⠈⠉⠷⠴⠟⠀⠀⠀⣰⠃⠀⠀⠀⣠⡞⠀⠀⠀⠀⠀⠈⠑⢦⣀⠀⠼⠿⠋⠀⠀⠀⠈⠻⢷⣶⡆⢠⣬⡉⠀⠀⢀⡾
⠀⠀⠀⠀⠹⣄⠀⠀⠀⠀⠈⠣⣀⠀⠀⠀⠀⠀⠀⢀⡴⠃⠀⣀⡤⠞⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢑⡶⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠛⠁⣀⡤⠞⠀
⠀⠀⠀⠀⠀⠈⠓⢦⣤⣄⣀⣀⣈⣓⣒⣤⣤⣶⡾⠿⢶⣾⣯⣭⣤⣤⣤⣤⣤⣀⡀⠀⠀⠀⠀⠀⡴⠋⠀⠀⣄⣠⡴⠞⠒⠢⠤⠀⠐⠒⠚⠋⠉⠀⠀⠀
⠀⠀⠀⠀⣀⣤⠶⠚⠉⠁⣸⠟⠉⠉⠙⢧⣀⠀⠀⠀⡸⢻⠀⠀⠀⠀⠀⠀⠀⠀⠙⢦⡀⠀⠀⠀⠑⠒⠊⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣸⠋⠉⠉⠁⠀⠀⠀⠀⣰⠏⠀⠀⠀⠀⠀⠈⠑⠒⠚⠁⢸⡟⠶⢤⣄⡀⠀⠀⢠⣦⣤⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢹⡄⠀⠀⠀⠀⠀⠀⣴⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠈⠙⢳⣄⠈⢻⣿⡞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠈⠳⣤⣀⣀⣀⣤⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠇⠀⠀⠀⠀⠀⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠹⣏⢿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠙⠿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢻⠀⠀⢀⣄⠀⠀⠀⠀⠀⠀⠀⠀⣠⠞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢸⡀⠀⠀⠉⠻⣦⠀⠀⠀⣀⣤⠞⠛⠲⣤⣀⣤⠶⠶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠘⣟⠛⢿⡁⠀⠀⠀⠀⠀⠀⠀⠀⢿⢸⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢸⠁⠀⠀⠀⠀⠀⠈⢳⠀⠛⢦⣄⠀⠀⠀⠀⠀⣰⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢸⣄⠀⠀⢀⣤⠀⣠⡾⠀⠀⠀⠙⠷⣄⣀⢀⣾⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠉⠙⠛⠛⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
""")


def acento(let):   
    """Converte letras com acentos nas letras sem acentos correspondentes."""
    dict_acento = {
        'C': ['Ç'],
        'A': ['Á', 'À', 'Ã', 'Â', 'Ä'],
        'E': ['É', 'È', 'Ê', 'Ë'],
        'I': ['Í', 'Ì', 'Î', 'Ï'],
        'O': ['Ó', 'Ò', 'Õ', 'Ô', 'Ö'],
        'U': ['Ú', 'Ù', 'Û', 'Ü']
    }
    keys = list(dict_acento.keys()) # criei uma lista com as keys do dicionário
    
    for i in keys: # Este loop percorre as keys do dicionário e verifica se a letra se encontra na lista associada à key
        if let in dict_acento.get(i):
            let = i # Caso se verifique, a letra passa ter o valor da key correspondente, ou seja, a letra com acento passa a ser a letra sem acento correspondente
            break
    return let


def acento_palavra(word):  
    """Substitui as letras com acentos de uma palavra pelas letras sem acentos correspondentes, usando a função anterior."""
    word = list(word)
    for i in range(len(word)):
        word[i] = acento(word[i])

    return list_to_string(word)


def verify(car, string):   
    """Verifica se a letra está na palavra."""

    if car in string:
        return True
    else:
        return False


def check_guess_in_word(letter, lacuna, word, ogword):  
    """Verifica se a letra colocada pelo jogador está na palavra e retorna a lacuna preenchida com essa letra."""

    for i in range(len(word)):
        if letter == word[i]:
            lacuna[i] = (ogword[i].upper())
    return lacuna


def list_to_string(list):   
    """Converte listas em strings."""
    string = str("")
    for i in list:
        string += i
    return string


def display_string(list):   
    """Dá display da list na consola com espaços entre cada letra como no exemplo: "JOGO_DA_FORCA" --> "J O G O _ D A _ F O R C A ". """
    string = ""
    for i in list:
        string += i + " "
    return string


def used(car, list):  
    """Remove um elemento de uma lista."""
    if car in list:
        list.remove(car)
    return (list)


def main():
    from wordlist import words1, words2

    # Descomente a linha que interessar para testar
    # words = words1              # palavras sem acentos nem cedilhas.
    # words = words2             # palavras com acentos ou cedilhas.
    words = words1 + words2    # palavras de ambos os tipos
    import sys                  # INCLUA estas 3 linhas para permitir
    if len(sys.argv) > 1:       # correr o programa com palavras dadas:
         words = sys.argv[1:]    #   python3 forca.py duas palavras
    answer = 'Y'
    while answer == 'Y':

        answer = ''

        # Escolhe palavra aleatoriamente
        ogsecret = random.choice(words).upper()
        # Cria uma versão da palavra sem os acentos
        secret = acento_palavra(ogsecret)
        # Lista das letras disponíveis
        available_guess = list("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

        c = 0  # define o número de erros para 0
        lacuna = list(len(secret) * "_")  # gera uma lacuna com o mesmo tamanho da palavra
        usadas = [] # Lista das letras introduzidas
        message = "" # mensagem adicional imprimida no início de cada tentativa
                
        while c < 6:

            os.system('cls') # Limpa o ecrã
            print(hangman(c), '\n')
            print(display_string(list_to_string(lacuna))) 
            print("\n========================================================================")
            print("\nERROS:", c)
            print("\nUSED LETTERS:      " + display_string(list_to_string(usadas)))
            print("\nAVAILABLE GUESSES: " + display_string(list_to_string(available_guess)))
            print("\n========================================================================")
            if message != "":
                print(message)
            message = ""
            letter = acento_palavra((input("\nGUESS: ")).upper()) # Converte o input em letras maiúsculas e remove os acentos

            if letter.isalpha() == False:
                message = "\n[!] You must enter a valid letter or word. [!]" # Caso o input não seja uma letra ou um conjunto de letras, um aviso é mostrado na próxima jogada
                continue

            if len(letter) == 1:
                
                if not letter in available_guess:
                    message = "\n[!] Already used this one. [!]" # Caso o utilizador introduza uma letra repetida, um aviso é mostrado na próxima jogada
                    continue
                
                available_guess = used(letter, available_guess) # A lista de letras disponiveis perde o elemento correspondente ao input
                usadas.append(letter) # A lista de letras usadas ganha um elemento correspondente ao input
                
                if verify(letter, secret) == True:
                    lacuna = check_guess_in_word(letter, lacuna, secret, ogsecret)

                    if list_to_string(lacuna) == ogsecret: 
                        break

                
                else:
                    c+=1
                    continue

            elif len(letter) == len(ogsecret):

                if letter == secret:
                    break

                else:
                    c += 1

        os.system('cls')
        print(hangman(c))
        print("\n========= ! ! !  G A M E    O V E R  ! ! ! =========")
        print("\nERROS:", c)
        print("\nUSED LETTERS:", display_string(list_to_string(usadas)))
        print("\nCORRECT WORD:", ogsecret)
        print("\n========= ! ! !  G A M E    O V E R  ! ! ! =========\n")
        
        if c == 6:
            print("\nY O U   L O S T   . . . ")
        else: 
            print("\nY O U   W O N   ! ! !")

        print("\n")
        
        while answer != 'Y':
            answer = (input("TRY AGAIN? (Y/N): ").upper())
            os.system('cls')
            if answer == 'N':
                break
    funny()
    

main()
