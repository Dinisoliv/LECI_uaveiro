import sys
from Cryptodome.Cipher import AES
from Cryptodome.Hash import SHA256
import os

def pad(data):
    # PKCS #7 padding
    padding_length = AES.block_size - (len(data) % AES.block_size)
    padding = bytes([padding_length]) * padding_length
    return data + padding

def encrypt_file(file_name, key):
    try:
        # Open the file for reading in binary mode
        with open(file_name, 'rb') as file:
            plaintext = file.read()
        
        # Pad the plaintext to make its length a multiple of AES block size
        plaintext = pad(plaintext)
        
        # Initialize AES cipher in ECB mode with the provided key
        cipher = AES.new(key, AES.MODE_ECB)
        
        # Encrypt the padded plaintext
        ciphertext = cipher.encrypt(plaintext)
        
        # Write the ciphertext to stdout (console)
        sys.stdout.buffer.write(ciphertext)

        # Write the ciphertext to a predefined file called "criptograma"
        with open("criptograma", 'wb') as output_file:
            output_file.write(ciphertext)
        
        print("\nEncryption successful. Encrypted message written to 'criptograma'.")
        
    except FileNotFoundError:
        print("File not found.")

if __name__ == "__main__":
    # Check if the correct number of arguments is provided
    if len(sys.argv) != 3:
        print("Usage: python cifraComAES.py <file_name> <key>")
        sys.exit(1)
    
    file_name = sys.argv[1]
    key = sys.argv[2].encode('utf-8')
    
    # Ensure key length is acceptable (16, 24, or 32 bytes)
    if len(key) < 16:
        # Hash the key using SHA-256 and use the first 16 bytes as the key
        key = SHA256.new(key).digest()[:16]
    elif len(key) > 32:
        key = key[:32]
    elif len(key) > 16 and len(key) < 24:
        key = key.ljust(24, b'0')
    elif len(key) > 24 and len(key) < 32:
        key = key.ljust(32, b'0')
    
    encrypt_file(file_name, key)
