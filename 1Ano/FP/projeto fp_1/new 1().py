while True:
    print("\n" + mostrar_forca(erros))
    print(mostrar_palavra(palavra, letras_corretas))
    print("Letras erradas:", ' '.join(sorted(letras_erradas)))
    print("Número de erros:", erros)  # Mostra o número de erros
    
if __name__ == "__main__":