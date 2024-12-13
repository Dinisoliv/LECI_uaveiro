p1 = int(input("pessoa 1? "))
p2 = int(input("pessoa 2? "))
p3 = int(input("pessoa 3? "))
p4 = int(input("pessoa 4? "))
pp1 = 0
pp2 = 0
pp3 = 0
pp4 = 0
if (p1 >= 6):
	pp1 = 2.5
elif p1>=13:
    pp1 = 5
elif p1 >= 65:
    pp1 = 2.5
    
if (p2 >= 6):
	pp2 = 2.5
elif p2>=13:
    pp2 = 5
elif p2 >= 65:
    pp2 = 2.5
    
if (p3 >= 6):
	pp3 = 2.5
elif p3>=13:
    pp3 = 5
elif p3 >= 65:
    pp3 = 2.5
    
if (p4 >= 6):
	pp4 = 2.5
elif p4>=13:
    pp4 = 5
elif p4 >= 65:
    pp4 = 2.5

ppt = pp1 + pp2 + pp3 + pp4
print("o preco total é ", ppt)