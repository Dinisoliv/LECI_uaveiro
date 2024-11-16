import requests
import json
import math

def read_file_list(filename):
    atractions = list()

    with open(filename, "r") as f:
        for category in f:    
            atractions.append(category.strip())
    return atractions

def request_info():
    startingPoint = str(input("Introduza o ponto de partida (Exemplo: -87.770231,41.878968 ) : "))
    travelRadius = float(input("Introduza a distância máxima que pretende viajar: "))
    destination = str(input("Que tipos de atração pretende visitar? (Introduz os nomes separados por uma virgula)\nSe quiser ver a lista de possibilidades, pressione Enter sem escrever nada: "))

    while destination == "" or destination not in read_file_list("categories.txt"):
        print("===================================")
        for category in read_file_list("categories.txt"):
            if len(category.split(".")) == 1:
                print(category)
        print("===================================")
        destination = str(input("Que tipos de atração pretende visitar? (Introduza um elemento da lista) : "))

    limit = int(input("Quantos resultados quer ver (10 é o máximo) ? ")) 

    while limit < 0 or limit > 10:
        limit = int(input("Valor inválido, tente novamente: "))

    return startingPoint, travelRadius, destination, limit

def display_results(number_of_results, data, startingPoint):
    for n in range(number_of_results):
        print("============================================== \n")
        
        print(n + 1, " - Nome: ", end="")
        if 'name' in data['features'][n]['properties']:
            print(data['features'][n]['properties']['name'], " | ",  end="")
        else:
            print("sem dados  | ", end="")

        print("País: ", end="")
        if 'country' in data['features'][n]['properties']:
            print(data['features'][n]['properties']['country'], " | ", end="")
        else:
            print("sem dados  | ", end="")

        longitude = data['features'][n]['properties']['lon']
        latitude = data['features'][n]['properties']['lat']
        
        print("Coordenadas: ", end="")
        print(longitude, ", ", latitude)
        
        print("Distância do ponto de partida: ", end="")
        print(math.sqrt((longitude - float(startingPoint.split(",")[0]))**2 + (latitude - float(startingPoint.split(",")[1]))**2) * 111, "km aproximados")
        
        print("Cidade: ", end="")
        if 'city' in data['features'][n]['properties']:
            print(data['features'][n]['properties']['city'], " | ", end="")
        else:
            print("sem dados  | ", end="")
        
        print("Rua: ", end="")
        if 'street' in data['features'][n]['properties']:
            print(data['features'][n]['properties']['street'])
        else:
            print("sem dados")

        print("Categorias: ", end="")
        if 'categories' in data['features'][n]['properties']:
            print(data['features'][n]['properties']['categories'], "\n")
        else:
            print("sem dados \n")

def main():
    info = request_info()
    resp = requests.get(f"https://api.geoapify.com/v2/places?categories={info[2]}&filter=circle:{info[0]},{info[1]}&limit=10&apiKey=458e0729ef2b45348e9cc28629f1576b")
    data = json.loads(resp.text)

    if len(data['features']) < info[3]:
        number_of_results = len(data['features'])
    else:
        number_of_results = info[3]

    display_results(number_of_results, data, info[0])
    #print(data['features'][2]['properties'])

    print("==================================================")
    print(number_of_results, "resultados obtidos! \n")


if __name__ == "__main__":
    main()