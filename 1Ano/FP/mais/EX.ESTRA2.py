def menu():
    print('''1) Registar chamada'
2) Ler ficheiro
3) Listar clientes
4) Fatura
5) Terminar''')
    n = input('Opção? ')
    return n

def validNumber(n):
    if n.startswith('+'):
        n = n[1:]  
        if n.isdigit() and len(n) >= 3:
            return True
    else:
        return False
       
def validNumber2(n):
    if n.startswith('9') and len(n) == 9:
        return True
    else:
        return False
    
def newCall():
    while True:
        origin_phone = input("Telefone origem? ")
        if validNumber2(origin_phone):
            break
        else:
            continue
    while True:
        destiny_phone = input("Telefone destino? ")
        if validNumber(destiny_phone):
            break
        else:
            continue
    while True:
        duration = input('Duration (s)? ')
        if duration.isdigit():
            break

def readFile(fname):
    try:
        with open(fname, 'r') as file:
            for line in file:
                data = line.split()
                origin = data[0]
                destiny = data[1]
                duration = data[2]
                print(f"Número de origem: {origin}, Número de destino: {destiny}, Duração: {duration}")
    except FileNotFoundError:
        print('File not Found')

def calcularCusto(destiny, duration):
    tarifas = {
        'rede_fixa': 0.02,
        'internacional': 0.80,
        'mesma_rede': 0.04,
        'outros_destinos': 0.10
    }
    first_digit = destiny[0]
    first2_digits = destiny[:2]
    if first_digit == '2':
        return int(duration) * tarifas['rede_fixa']  
    elif first_digit == '+':
        return int(duration) * tarifas['internacional'] 
    elif first2_digits == '96':
        return int(duration) * tarifas['mesma_rede']
    else:
        return int(duration) * tarifas['outros_destinos']
                 
def gerarFatura(fname):
    client = input('Cliente? ')
    total_cost = 0
    destino = 'Destino'
    duracao = 'Duração'
    custo = 'Custo'
    with open(fname, 'r') as file:
        print(f"Fatura do cliente {client}")
        print(f"{destino:<15} {duracao:<8} {custo:<6}")
        print("-"*30)
        for line in file:
            data = line.split()
            origin = data[0]
            destiny = data[1]
            duration = data[2]
            if origin == client:
                cost = calcularCusto(destiny, duration)
                total_cost += cost
                print(f"{destiny:<15} {duration:<8} {cost:<6.2f}")
    print("-"*30)
    print(f"Total: {total_cost:.2f}")

def clientList(fname):
    lst = []
    str = ""
    with open(fname, 'r') as file:
        for line in file:
            data = line.split()
            origin = data[0]
            if origin not in lst:
                lst.append(origin)
        for i in lst:
            str = str + " " + i
        print(str)
        
def main():
    option = str(menu())
    if option == "1":
        newCall()
    elif option == "2":
        fname = input('Ficheiro? ')
        readFile(fname)
    elif option == "3":
        fname = input('Ficheiro? ')
        clientList(fname)
    elif option == "4":
        fname = input('Ficheiro? ')
        gerarFatura(fname) 

if __name__ == "__main__":
    main()
