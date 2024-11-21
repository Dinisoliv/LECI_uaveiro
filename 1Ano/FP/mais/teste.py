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
    origin_phone = []
    destin_phone = []
    duration = []
    
    with open(file1, 'r') as f:
        for line in f:
            line = line.split()
            origin_phone.append(line[0])
            destin_phone.append(line[1])
            duration.append(int(line[2]))
    
    set_origin_phone = set(origin_phone)
    return set_origin_phone, destin_phone, duration

def listClients(set_origin_phone):
    sorted_numbers = sorted(set_origin_phone)
    result_string = ', '.join(sorted_numbers)
    print("Clientes:", result_string)

def costCalls():
    pass

def main():
    while True:
        option = Menu()
        if option == 1:
            phone_origin = registerNewCall('origem')
            phone_destino = registerNewCall('destino')
            duration = input("Duração (s)? ")
        elif option == 2: 
            set_origin_phone, destin_phone, duration = callsFile()
        elif option == 3:
            set_origin_phone, _, _ = callsFile()
            listClients(set_origin_phone)
        elif option == 4:
            phone = input('Telemóvel? ')
        elif option == 5:
            quit()
        else:
            print("\n Select a Valid Option \n")

if __name__ == "__main__":
    main()
