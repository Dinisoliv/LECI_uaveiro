import sys
from Cryptodome.Cipher import AES
from Cryptodome.Hash import SHA256
from Cryptodome import Random
import os

def unpad(data):
    # Remove PKCS #7 padding
    padding_length = data[-1]
    return data[:-padding_length]

def decrypt_file(file_name, key):
    try:
        # Check if the file size is aligned with the block size
        file_size = os.path.getsize(file_name)
        if file_size % AES.block_size != 0:
            print("Error: The file length is not aligned with the block size.")
            return
        
        # Read the ciphertext from the file
        with open(file_name, 'rb') as file:
            ciphertext = file.read()
        
        # Initialize AES cipher in ECB mode with the provided key
        cipher = AES.new(key, AES.MODE_ECB)
        
        # Decrypt the ciphertext
        plaintext = cipher.decrypt(ciphertext)
        
        # Remove padding
        plaintext = unpad(plaintext)
        
        # Write the decrypted plaintext to stdout (console)
        sys.stdout.buffer.write(plaintext)
    except FileNotFoundError:
        print("File not found.")

if __name__ == "__main__":
    # Check if the correct number of arguments is provided
    if len(sys.argv) != 3:
        print("Usage: python decifraComAES.py <file_name> <key>")
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
    
    decrypt_file(file_name, key)
