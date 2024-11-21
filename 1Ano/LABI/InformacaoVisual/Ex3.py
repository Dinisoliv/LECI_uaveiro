from PIL import Image
import sys

def main(fname):
    im = Image.open(fname)
    width, height = im.size

    scales = [0.2, 8]
    methods = {
        "NEAREST": Image.NEAREST,
        "BILINEAR": Image.BILINEAR,
        "BICUBIC": Image.BICUBIC,
        "ANTIALIAS": Image.LANCZOS  # ANTIALIAS is an alias for LANCZOS in Pillow
    }

    for s in scales:
        for method_name, method in methods.items():
            dimension = (int(width * s), int(height * s))
            new_im = im.resize(dimension, method)
            new_im.save(f"{fname}-{method_name}-{s:.2f}.jpg")

if __name__ == "__main__":
    main(sys.argv[1])
