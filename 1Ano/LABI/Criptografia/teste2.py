import os.path
import sys
import hashlib

if len (sys.argv) < 2 :
    print ("Usage: python3 %s filename" % (sys.argv[0]))
    sys.exit (1)

fname = sys.argv[1] # verify if it is a file
if not os.path.exists(fname) or os.path.isdir(fname) or not os.path.isfile(fname):
    print(fname + " is not a file", file=sys.stderr)
    sys.exit (2)
    
def calculate_sha1(filename, block_size=512):
    sha1 = hashlib.sha1()
    with open(filename, 'rb') as file:
        buffer = file.read(block_size)
        while len(buffer) > 0:
            sha1.update(buffer)
            buffer = file.read(block_size)
    return sha1.hexdigest()

try:
    sha1_result = calculate_sha1(fname)
    print("SHA-1:", sha1_result)
except Exception as e:
    print("Error calculating SHA-1:", str(e), file=sys.stderr)
    sys.exit(3)
    
#REVIEW THIS
