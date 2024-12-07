import sys
import os
from Cryptodome.Cipher import AES
from Cryptodome.Hash import SHA256
from Cryptodome.Util.Padding import unpad

def process_key(key):
    # Se a chave for menor do que 16 bytes, use SHA-256 para sintetizá-la
    if len(key) < 16:
        key = SHA256.new(key.encode()).digest()
    # Use apenas os primeiros 16 bytes da chave
    else:
        key = key[:16]
    return key

def decrypt_with_aes(file_name, key):
    with open(file_name, 'rb') as file:
        iv = file.read(16)  # Lê o vetor de inicialização (IV) do arquivo
        ciphertext = file.read()

    key = process_key(key)
    cipher = AES.new(key, AES.MODE_CBC, iv)

    # Decifra o conteúdo
    decrypted_content = cipher.decrypt(ciphertext)

    # Remove o padding do conteúdo decifrado
    original_content = unpad(decrypted_content, AES.block_size)

    return original_content

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Uso: python3 decifraComAES.py <arquivo_cifrado> <chave>")
        sys.exit(1)

    file_name = sys.argv[1]
    key = sys.argv[2]

    # Verifica se o tamanho do arquivo é múltiplo do tamanho do bloco AES
    file_size = os.path.getsize(file_name)
    if file_size % AES.block_size != 0:
        print("O arquivo cifrado não possui um comprimento alinhado à dimensão do bloco de cifra.")
        sys.exit(1)

    decrypted_content = decrypt_with_aes(file_name, key)

    # Escreve o conteúdo decifrado no stdout (por padrão, a tela)
    sys.stdout.buffer.write(decrypted_content)