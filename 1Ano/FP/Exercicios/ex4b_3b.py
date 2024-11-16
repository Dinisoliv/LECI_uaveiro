def preco(x):   
    if ((x >= 6) and (x < 13)):
        y = 2.5
    elif ((x>=13) and (x < 65)):
        y = 5
    elif (x >= 65):
        y = 2.5
    else :
        y = 0
    return y
    
pp1 = preco(int(input("pessoa 1? ")))
pp2 = preco(int(input("pessoa 2? ")))
pp3 = preco(int(input("pessoa 3? ")))
pp4 = preco(int(input("pessoa 4? ")))

ppt = pp1 + pp2 + pp3 + pp4
print("o preco total é ", ppt)