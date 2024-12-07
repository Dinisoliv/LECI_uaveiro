#maior de 4 numeros usando 3 comparacoes
x1 = float(input("x1?"))
x2 = float(input("x2?"))
x3 = float(input("x3?"))
x4 = float(input("x4?"))
mx = x1
if x2 > mx:
    mx = x2
if x3 > mx:
    mx = x3
if x4 > mx:
    mx = x4
print(mx)