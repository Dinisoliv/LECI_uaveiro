from unidecode import unidecode

# Palavra com acentos
palavra = "maçã"

# Remova a acentuação da palavra
palavra_sem_acentos = unidecode(palavra)

# Letra inserida pelo jogador (pode ser sem acento)
letra_jogador = "a"

# Normalize a letra inserida pelo jogador
letra_jogador_sem_acentos = unidecode(letra_jogador)

# Verifique se a letra do jogador sem acento está na palavra sem acentos
if letra_jogador_sem_acentos in palavra_sem_acentos:
    print(f"A letra '{letra_jogador}' faz parte da palavra.")
else:
    print(f"A letra '{letra_jogador}' não faz parte da palavra.")

