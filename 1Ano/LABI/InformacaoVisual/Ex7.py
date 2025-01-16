from PIL import Image
import sys

def main(filenames):
    for fname in filenames:
        im = Image.open(fname)
        print(f"Arquivo: {fname}, Mode: {im.mode}")

if __name__ == "__main__":
    # Lista de arquivos fornecida como argumentos da linha de comando
    main(sys.argv[1:])