from PIL import Image
import os
import sys

def main(fname):
    # Abrir a imagem JPEG fornecida
    im = Image.open(fname)
    
    # Nome base do arquivo sem extensão
    base_name = os.path.splitext(fname)[0]

    # Dicionário para armazenar os tamanhos dos arquivos resultantes
    file_sizes = {}

    # Formatos para conversão
    formats = ["PNG", "TIFF", "BMP"]
    
    for fmt in formats:
        # Salvar a imagem em cada formato
        new_fname = f"{base_name}.{fmt.lower()}"
        im.save(new_fname, fmt)
        
        # Obter o tamanho do arquivo criado
        file_size = os.path.getsize(new_fname)
        file_sizes[fmt] = file_size

        print(f"Tamanho do arquivo {new_fname}: {file_size} bytes")

if __name__ == "__main__":
    main(sys.argv[1])
