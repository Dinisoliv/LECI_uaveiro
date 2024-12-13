#maior de 3 numeros usando 2 comparacoes
x1 = float(input("x1?"))
x2 = float(input("x2?"))
x3 = float(input("x3?"))
if x1 > x2:
    if x1 > x3:
        mx = x1
    else:
        mx = x3
else:
    if x2 > x3:
        mx = x2
    else:
        mx = x3
print(mx)
