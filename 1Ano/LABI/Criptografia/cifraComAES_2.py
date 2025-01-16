import sys
from Cryptodome.Cipher import AES
from Cryptodome.Hash import SHA256
from Cryptodome.Util.Padding import pad

def process_key(key):
    if (len(key) < 16):
        key = SHA256.new(key.encode()).digest()
    else:
        key = key[:16]
    return key

def encrypt_with_AES(file_name, key):
    with open(file_name, 'rb') as file:
        content = file.read()
    
    key = process_key(key)
    cipher = AES.new(key, AES.MODE_CBC)

    content_padded = pad(content, AES.block_size)

    ciphertext = cipher.encrypt(content_padded)

    sys.stdout.buffer.write(cipher.iv)
    sys.stdout.buffer.write(ciphertext)

    with open(output_file, 'wb') as outfile:
        outfile.write(cipher.iv)
        outfile.write(ciphertext)

def main():
    if len(sys.argv) != 3:
        print("Usage: python3 cifraComAES.py <file> <key> <output file>")
        sys.exit(1)
    
    file_name = sys.argv[1]
    key = sys.argv[2].encode()
    output_file = sys.argv[3]

    encrypt_with_AES(file_name, key, output_file)

main()