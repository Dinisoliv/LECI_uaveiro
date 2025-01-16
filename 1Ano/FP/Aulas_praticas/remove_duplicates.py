lista = []
def remove_duplicates(lista):
    lista2=[]
    for n in lista:
        if n in lista2:
            continue
        else:
            lista2.append(n)
    return lista2

while True:
    numero = input('Número: ')
    if numero!= 'STOP':
        lista.append(numero)
    if numero == 'STOP':
        print(remove_duplicates(lista),'\n',lista)
        break

    