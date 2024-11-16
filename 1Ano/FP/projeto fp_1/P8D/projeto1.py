# Preencha a lista com os números mecanográficos dos autores.
#AUTORES = ['120009', '106962']

import random
def PrintWord(guess, secretlist, secret):
	for i in range(len(secret)):
		if secret[i]==guess:
			secretlist[i]=guess
	return secretlist

def forca(erros):
	if erros==0:
		print('_____ ')
		print('| ')
		print('| ')
		print('| ')
	elif erros==1:
		print('_____ ')
		print('|  o ')
		print('| ')
		print('| ')
	elif erros==2:
		print('_____ ')
		print('|  o ')
		print('|  | ')
		print('| ')
	elif erros==3:
		print('_____ ')
		print('|  o ')
		print('| /| ')
		print('| ')
	elif erros==4:
		print('_____ ')
		print('|  o ')
		print('| /|\ ')
		print('| ')
	elif erros==5:
		print('_____ ')
		print('|  o ')
		print('| /|\ ')
		print('| / ')
	else:
		print('_____ ')
		print('|  o ')
		print('| /|\ ')
		print('| / \ ')


def main():
	
    	#from wordlist import words1, words2
	with open("wordlist.py", "r") as doc: 
		a = doc.readline()
		b = doc.readline()
		words1 = a.split(",")
		words2 = b.split(",")

	words = words1              # palavras sem acentos nem cedilhas.
	#words = words2             # palavras com acentos ou cedilhas.
	#words = words1 + words2    # palavras de ambos os tipos

	import sys                  # INCLUA estas 3 linhas para permitir
	if len(sys.argv) > 1:       # correr o programa com palavras dadas
		words = sys.argv[1:]    #   python3 forca.py duas palavras
	
	# Escolhe palavra aleatoriamente
	secret = random.choice(words).upper()
	#Variaveis
	word = []
	secretlist = []
	erros = 0
    	
	print(secret)
	for i in secret:
		word.append(i)
		secretlist.append('_ ')
	print(secretlist)

	while erros<7:
		forca(erros)
		guess=input('Escolha uma letra ').upper()
		if guess==secret:
			print(secret)
			break
		else:
			comumletters=0
			for i in secret:
				if i==guess:
					comumletters=1
					break
				else:
					comumletters=0
			if comumletters==0:
				erros+=1
			print('Erros:', erros)
			print(PrintWord(guess, secretlist, secret))


if __name__ == "__main__":
    main()