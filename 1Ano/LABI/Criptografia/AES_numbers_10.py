import os
from Cryptodome.Cipher import AES

def encrypt_number(number, key):
    cipher = AES.new(key, AES.MODE_ECB)
    data = cipher.encrypt(bytes("%16d" % (number), "utf8"))
    return data

def decrypt_number(data, key):
    cipher = AES.new(key, AES.MODE_ECB)
    value = int(str(cipher.decrypt(data), "utf8"))
    return value

def get_valid_integer_input(prompt):
    while True:
        try:
            number = int(input(prompt))
            return number
        except ValueError:
            print("Invalid input. Please enter an integer.")


if __name__ == "__main__":
    key = os.urandom(16)
    print("Enter integers to encrypt (0 to exit):")

    while True:
        number = get_valid_integer_input("Enter an integer: ")
        
        if number == 0:
            print("Exiting...")
            break

        encrypted_number = encrypt_number(number, key)
        decrypted_number = decrypt_number(encrypted_number, key)
        
        print("Encrypted:", encrypted_number)
        print("Decrypted:", decrypted_number)