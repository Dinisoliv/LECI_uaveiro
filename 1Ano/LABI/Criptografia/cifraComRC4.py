import sys
from Cryptodome.Cipher import ARC4
from Cryptodome.Hash import SHA256

def processa_chave(chave):
    if len(chave) < 5:
        return SHA256.new(chave.encode()).digest()
    elif len(chave) > 256:
        return chave[:256].encode()
    else:
        return chave.encode()

def cifra_com_rc4(nome_arquivo, chave):
    with open(nome_arquivo, 'rb') as arquivo:
        conteudo = arquivo.read()

    chave_processada = processa_chave(chave)
    cifra = ARC4.new(chave_processada)
    criptograma = cifra.encrypt(conteudo)

    sys.stdout.buffer.write(criptograma)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Uso: python3 cifraComRC4.py <ficheiro> <chave>")
        sys.exit(1)

    nome_arquivo = sys.argv[1]
    chave = sys.argv[2]

    cifra_com_rc4(nome_arquivo, chave)
