import sys
sys.argv

cc = {}

f = open(r"C:\Users\dinis\\Desktop\FP\Guiões aulas\aula07\examples\pg3333.txt","r", encoding = "utf-8")

for line in f:
    for w in line.split():
        w = w.lower()
        for c in w:
            if c.isalpha():
                if c in cc:
                    cc[c] += 1
                else:
                    cc[c] = 1
f.close()

for letter, repetitions in sorted(cc.items()):
    print(f"{letter}: {repetitions}")
