#maior de 3 numeros usando 2 comparacoes
x1 = float(input("x1?"))
x2 = float(input("x2?"))
x3 = float(input("x3?"))
mx=x1
if x2 > x3:
    my = x2
else:
    my = x3
if x1 > my:
    mx = x1
else:
    mx=my
print(mx)
