def Menu():
    menu_list = ['Registar chamada', 'Ler ficheiro', 'Listar clientes', 'Fatura', 'Terminar']
    for i in range(1, len(menu_list) + 1):
        print(f"{i}) {menu_list[i-1]}") 
    option = input("Opção?\n")
    print(f"Escolheu {menu_list[int(option)-1]}")
    return int(option)

def validNumber(number):
    numberIsValid = False
    if number.startswith('+'):
        if (3 <= len(number[1:]) <= 12):
            if number[1:].isdigit():
                numberIsValid = True
    if (3 <= len(number) <= 9):
        if number.isdigit():
            numberIsValid = True
    return numberIsValid

def registerNewCall(tipo):
    phone = input(f"Telefone {tipo}? ")
    valid_number = validNumber(phone)
    while not valid_number:
        phone = input(f"Telefone {tipo}? ")
        valid_number = validNumber(phone)
    return phone

def callsFile():
    file1 = input('Ficheiro? ')
    set_origin_phone = set()
    with open(file1, 'r') as f:
        for line in f:
            line = line.split()
            set_origin_phone.add(line[0])
    
    return set_origin_phone

def listClients(set_origin_phone):
    sorted_numbers = sorted(set_origin_phone)
    result_string = ', '.join(sorted_numbers)
    print("Clientes:", result_string)

def costCalls(client, destiny, duration):
    first_digit = destiny[0]
    first2_digits = destiny[:2]
    first2_digit_origin = client[:2]
    if first_digit == '2':
        return int(duration) * 0.02 
    elif first_digit == '+':
        return int(duration) * 0.80
    elif first2_digits == first2_digit_origin:
        return int(duration) * 0.04
    else:
        return int(duration) * 0.10

def generateBill():
    fname = input('Ficheiro? ')
    client = input('Telemóvel do Cliente ? ')
    totalCost = 0
    print(f"Fatura do cliente {client}")
    print(f"{'Destino':<15} {'Duração':<8} {'Custo':<6}")
    with open(fname, 'r') as f:
        for line in f:
            data = line.split()
            origin = data[0]
            destiny = data[1]
            duration = data[2]
            if origin == client:
                cost = costCalls(client, destiny, duration)
                totalCost += cost
                print(f"{destiny:<15} {duration:<8} {cost:<6.2f}")
    print("-"*30)
    print(f"Total: {totalCost:.2f}") 

def main():
    while True:
        option = Menu()
        if option == 1:
            phone_origin = registerNewCall('origem')
            phone_destino = registerNewCall('destino')
            duration = int(input("Duração (s)? "))
        elif option == 2: 
            set_origin_phone = callsFile()
        elif option == 3:
            listClients(set_origin_phone)
        elif option == 4:
            generateBill()
        elif option == 5:
            quit()
        else:
            print("\n Select a Valid Option \n")

if __name__ == "__main__":
    main()