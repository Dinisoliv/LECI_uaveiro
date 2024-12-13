import os.path
import sys
from Cryptodome.Hash import SHA256

if len (sys.argv) < 2 :
    print ("Usage: python3 %s filename" % (sys.argv[0]))
    sys.exit (1)

fname = sys.argv[1] # verify if it is a file
if not os.path.exists(fname) or os.path.isdir(fname) or not os.path.isfile(fname):
    print(fname + " is not a file", file=sys.stderr)
    sys.exit (2)
    
def calculate_sha256(filename):
    sha256 = SHA256.new()
    with open(filename, 'rb') as file:
        # Ler o arquivo em blocos de 512 octetos
        buffer = file.read(512)
        while len(buffer) > 0:
            sha256.update(buffer)
            buffer = file.read(512)
    return sha256.hexdigest()

try:
    sha256_result = calculate_sha256(fname)
    print("SHA-256:", sha256_result)
except Exception as e:
    print("Error calculating SHA-256:", str(e), file=sys.stderr)
    sys.exit(3)
  
exit(0)
