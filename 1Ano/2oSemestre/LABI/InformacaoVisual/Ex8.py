from PIL import Image
import sys

def reduce_color_resolution(im, bits_to_keep):
    """
    Reduz a resolução de cor de uma imagem mantendo apenas os bits mais significativos.
    
    Args:
    im (PIL.Image): Imagem a ser processada.
    bits_to_keep (int): Número de bits mais significativos a manter.
    """
    width, height = im.size
    bit_mask = (0xFF << (8 - bits_to_keep)) & 0xFF  # Máscara para manter os bits mais significativos

    for x in range(width):
        for y in range(height):
            p = im.getpixel((x, y))
            r = p[0] & bit_mask
            g = p[1] & bit_mask
            b = p[2] & bit_mask
            im.putpixel((x, y), (r, g, b))

def main(fname, bits_to_keep):
    """
    Abre uma imagem, reduz a resolução de cor e salva a imagem resultante.
    
    Args:
    fname (str): Nome do arquivo da imagem.
    bits_to_keep (int): Número de bits mais significativos a manter.
    """
    im = Image.open(fname)
    im = im.convert("RGB")  # Garantir que a imagem está no modo RGB
    reduce_color_resolution(im, bits_to_keep)
    output_fname = f"{fname.rsplit('.', 1)[0]}-{bits_to_keep}bits.jpg"
    im.save(output_fname)
    print(f"Imagem salva como {output_fname}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Uso: python script.py <caminho/para/imagem.jpg> <bits_a_manter>")
    else:
        fname = sys.argv[1]
        bits_to_keep = int(sys.argv[2])
        main(fname, bits_to_keep)
