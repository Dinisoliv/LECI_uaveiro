
#TurmaP9G04

import requests
from geopy.distance import geodesic
from timezonefinder import TimezoneFinder


#abrir o ficheiro onde estão as categorias
with open('categories.txt', 'r') as f:
    categorias = [linha.strip() for linha in f]

#pedir todos os dados necessários para a execução do programa
posicao = (input('Latitude e longitude (seprara-as por vírgulas, por exemplo 40.453, -8.843): ')).replace(',', ' ').split()
posicao[0] = float(posicao[0])
posicao[1] = float(posicao[1])
distancia = float((input("Distância em kms: ")))
distancia *= 1000
opcao = input('Queres ver quais categorias podes escolher? ')
if opcao == 'sim' or opcao == 'Sim' or opcao == 's' or opcao == 'S':
    print(categorias)
visitas = (input('Que tipos de locais queres visitar? (separa-as por vírgulas): ')).replace(' ','')

key = 'f4fb333d15234647a6b053caa57e14fa'

#função que obtém todas as atrações
def obter_atracoes(api_key, localizacao, distancia_max, categorias):
    response = requests.get(f'https://api.geoapify.com/v2/places?categories={categorias}&filter=circle:{localizacao[1]},{localizacao[0]},{distancia_max}&bias=proximity:{localizacao[1]},{localizacao[0]}&limit=20&apiKey={api_key}')
    dados_atracoes = response.json()
    return dados_atracoes.get('features', [])

#função que calcula a distância entre dois pontos geográficos
def calcular_distancia(inicio, atracao):
    return geodesic(inicio, atracao).kilometers

#função que obtém o fuso horário pelas coordenadas.
def get_timezone(posicao):
    tf = TimezoneFinder()
    return tf.certain_timezone_at(lat=posicao[0], lng=posicao[1])

#função que mostra todos os dados relativos a cada atração
def exibir_atracoes(atracoes, localizacao_partida):
    for atracao in atracoes:
        nome = atracao.get('properties', {}).get('name', 'N/A')
        pais = atracao.get('properties', {}).get('country', 'N/A')
        lat = atracao.get('geometry', {}).get('coordinates', [])[1]
        long = atracao.get('geometry', {}).get('coordinates', [])[0]
        localizacao_atracao = (lat, long)
        distancia = calcular_distancia(localizacao_partida, localizacao_atracao)
        morada = atracao.get('properties', {}).get('address_line2', 'N/A')
        timezone = get_timezone(posicao)
        aldeia = atracao.get('properties', {}).get('village', 'N/A')


        if nome == 'N/A':
            continue
        else:
            print('\nNome:', nome)
            print('País:', pais)
            print('Morada:', morada)
            print('Aldeia:', aldeia)
            print('Fuso Horário:', timezone)
            print('Localização (Lat, Lon):', localizacao_atracao)
            print('Distância à localização de partida:', f'{distancia:.2f} km')


#execução do programa
atracoes = obter_atracoes(key, posicao, distancia, visitas.lower())
exibir_atracoes(atracoes, posicao)
