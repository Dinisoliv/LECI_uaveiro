import os, requests, time, unicodedata

# Váriaveis constantes globais usadas neste projecto.
API_KEY = 'd548c5ed24604be6a9dd0d989631f783'
API_BASE_URL = 'https://api.geoapify.com'

def clear_screen():
    # Limpa a informação no ecrã, 'clear' para linux e mac (posix), 'cls' para windows (nt).
    os.system('clear' if os.name != 'nt' else 'cls')


def normalize(value):
    # Normaliza os caracteres para as 'strings' serem comparadas entre si, ignora caso o valor seja do tipo int or float.
    if isinstance(value, (int, float)):
        return value
    return ''.join(char for char in unicodedata.normalize('NFD', str(value)) if unicodedata.category(char) != 'Mn')


def set_wait():
    # Aguarda até o utilizador clicar na tecla [Enter].
    input("\nPressione a tecla [Enter] para continuar.")


def get_location(latitude, longitude):
    # Retorna a localização com as coordenadas.
    return '{},{}'.format(latitude, longitude)


def print_line(char, number):
    # Imprime uma linha com o número do caractere repetido.
    print(char * number)

def print_info(info, separator, position = '<'):
    # Imprime a informação formatada na posição indicada.
    result = '| {:' + position + str(separator - 4) + '} |'
    print(result.format(info))


def print_header(separator):
    # Imprime a mensagem do cabeçalho deste programa.
    clear_screen()
    print_line('=', separator)
    print_info('FP - Proj2', separator, '^')
    print_line('=', separator)


def print_exit_msg(separator):
    # Imprime a mensagem de saída.
    clear_screen()
    print_header(separator)
    print_info('', separator, '^')
    print_info('Obrigado por usar este programa! Espero que tenha gostado!', separator, '^')
    print_info('', separator, '^')
    print_line('=', separator)


def load_categories_file(separator):
    # Importa as categorias após a leitura do ficheiro 'categories.txt', retorna um conjunto.
    categories = set()
    try:
        while (len(categories) == 0):
            if os.path.isfile('categories.txt'):
                with open('categories.txt', 'r') as file:
                    categories = set(line.rstrip() for line in file)
                #print('Foram importadas {} categorias.'.format(len(categories)), end='\n\n')
            else:
                print_header(separator)
                print('\n* Não foi encontrado o ficheiro "categories.txt", verifique se o ficheiro existe na pasta.', end='\n\n')
                input('Pressione a tecla [Enter] para voltar a tentar ler o ficheiro.')
    except:
        categories = set()
        print('\n* Não foi possível importar as categorias, ocorreu um erro de leitura.', end='\n\n')
    return categories


def load_categories(fcategories, separator):
    # Retorna a(s) categoria(s) após serem validadas.
    print_header(separator)
    categories = set()
    while (len(categories) == 0):
        result = input('\nIntroduza a(s) categoria(s), separadas por uma vírgula, por exemplo [accommodation,tourism]:\n\n')
        values = result.lower().split(',')
        for value in values:
            value = value.strip()
            if not value in fcategories:
                categories = set()
                print_header(separator)
                print('\n* {} não é uma categoria válida, tente novamente.'.format(value), end='\n\n')
                break
            categories.add(value)
    return categories


def get_coordinates(result):
    # Retorna um dicionário com as coordenadas após serem validadas.
    try:
        values = result.split(',')
        latitude = float(values[0])
        longitude = float(values[1])
        if (len(values) == 2 and latitude >= -90 and latitude <= 90 and longitude >= -180 and longitude <= 180):
            return {'lat' : latitude, 'lon' : longitude}
        return {}
    except:
        # Formato inválido.
        return {}


def load_coordinates(details, separator):
    # Retorna um dicionário com as coordenadas.
    print_details(details, separator)
    coordinates = {}
    while (len(coordinates) != 2):
        result = input('\nIntroduza a latitude e a logitude, separadas por uma vírgula, por exemplo [40.5,-8.5]:\n\n')
        coordinates = get_coordinates(result)
        if len(coordinates) != 2:
            print_details(details, separator)
            print('\n* {} não é um formato válido para as coordenadas, tente novamente.'.format(result), end='\n\n')
    return coordinates


def load_number(info, minimum, maximum, details, separator):
    # Retorna um número entre 'minimum' e 'maximum'.
    print_details(details, separator)
    number = minimum - 1
    while (number < minimum or number > maximum):
        result = input(f'\nIntroduza o valor do {info} entre {minimum} e {maximum}:\n\n')
        try : 
            number = int(result)
        except:
            number = minimum - 1
        if number < minimum or number > maximum:
            print_details(details, separator)
            print('\n* {} não é um número válido, tente novamente.'.format(result), end='\n\n')
    return number


def menu_columns(details, columns, separator, msg):
    # Apresenta o menu para a escolha da coluna para a ordenação dos dados .
    print_details(details, separator)
    print_info('Ordenar Dados Por', separator, '^')
    print_line('-', separator)
    for index, value in columns.items():
        print_info(' [ {} ] - {}'.format(index, value[1]), separator)
    print_line('=', separator)
    if len(msg) > 0:
        print('\n* {}'.format(msg), end='\n\n')
    option = input("\nOpção? ")
    return option


def load_column(details, columns, separator):
    # Retorna a informação da coluna para ordenar os dados.
    msg = ''
    column = ''
    while column == '':
        # Escolha da opção de ordenação da lista.
        option = menu_columns(details, columns, separator, msg)
        # Limpa a mensagem de erro.
        msg = ''
        column = columns.get(option, '')
        if column == '':
            # A opção é inválida.
            msg = "Opção inválida! Tente novamente."
    return column


def menu_orders(details, orders, separator, msg):
    # Apresenta o menu para a escolha da coluna para a ordenação dos dados .
    print_details(details, separator)
    print_info('Ordenar Por Ordem', separator, '^')
    print_line('-', separator)
    for index, value in orders.items():
        print_info(' [ {} ] - {}'.format(index, value[1]), separator)
    print_line('=', separator)
    if len(msg) > 0:
        print('\n* {}'.format(msg), end='\n\n')
    option = input("\nOpção? ")
    return option


def load_order(details, separator):
    # Retorna a informação da ordem de ordenação dos dados.
    orders = {'1' : (False, 'Crescente'), '2' : (True, 'Decrescente')}
    msg = ''
    column = ''
    while column == '':
        # Escolha da opção de ordenação da lista.
        option = menu_orders(details, orders, separator, msg)
        # Limpa a mensagem de erro.
        msg = ''
        column = orders.get(option, '')
        if column == '':
            # A opção é inválida.
            msg = "Opção inválida! Tente novamente."
    return column


def load_option(separator):
    # Retorna a informação da ordem de ordenação dos dados.
    options = {'s' : True, 'n' : False}
    msg = ''
    option = ''
    while option == '':
        # Escolha da opção de ordenação da lista.
        print_header(separator)
        if len(msg) > 0:
            print('\n* {}'.format(msg), end='\n\n')
        result = input("\nDeseja voltar a fazer uma nova pesquisa [s/n]? ").lower().strip()
        # Limpa a mensagem de erro.
        msg = ''
        option = options.get(result, '')
        if option == '':
            # A opção é inválida.
            msg = "Opção inválida! Tente novamente."
    return option


def get_places(details):
    # Localização com as coordenadas do ponto de origem, ordem inversa neste caso.
    proximity = get_location(details['coordinates']['lon'], details['coordinates']['lat'])
    
    params = {'categories' : ','.join(details['categories']), 'filter' : f'circle:{proximity},{details["radius"]}',
              'limit' : details['limit'], 'apiKey' : API_KEY}
    # Os 'params' são codificados como 'params=argument' para passar na URL.
    response = requests.get(f'{API_BASE_URL}/v2/places', params = params)

    # Descomentar para verificar a URL que foi constuída.
    #print(response.request.url)  

    if response.status_code == 200:
        # Converter JSON em um objeto, neste caso deverá retornar um dicionário.
       return response.json()
    return None


def change_table(place, table):
    # Modifica os comprimentos de cada coluna da tabela.
    if len(place['name']) > table[0]:
        table[0] = len(place['name'])
    if len(place['country']) > table[1]:
        table[1] = len(place['country'])
    if len(place['city']) > table[2]:
        table[2] = len(place['city'])
    if len(place['street']) > table[3]:
        table[3] = len(place['street'])
    if len(place['postcode']) > table[4]:
        table[4] = len(place['postcode'])
    if len(str(place['lat'])) > table[5]:
        table[5] = len(str(place['lat']))
    if len(str(place['lon'])) > table[6]:
        table[6] = len(str(place['lon']))
    if len(str(place['distance'])) > table[7]:
        table[7] = len(str(place['distance']))


def get_distance_h(lat1, lon1, lat2, lon2):
    # Retorna a distância entre as coordenadas (Haversine) sabendo que o planeta Terra tem um raio aproximadamente de 6371km.
    try:
        from math import cos, asin, sqrt, pi
        radius = 6371
        p = pi / 180
        a = 0.5 - cos((lat2 - lat1) * p) / 2 + cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2
        distance = 2 * radius * asin(sqrt(a))
        # Retorna o valor arredondado em metros.
        return round(distance * 1000)
    except:
        # Retorna 0 caso ocorra um erro no cálculo, pouco improvável acontecer.
        return 0


def get_distance(lat1, lon1, lat2, lon2):
    # Retorna a distância entre as coordenadas sabendo que o planeta Terra tem um raio aproximadamente de 6371km.
    try:
        from math import radians, sin, cos, acos
        lat1 = radians(float(lat1))
        lon1 = radians(float(lon1))
        lat2 = radians(float(lat2))
        lon2 = radians(float(lon2))
        distance = 6371 * acos(sin(lat1) * sin(lat2) + cos(lat1) * cos(lat2) * cos(lon1 - lon2))
        # Retorna o valor arredondado em metros.
        return round(distance * 1000)
    except:
        # Retorna 0 caso ocorra um erro no cálculo, pouco improvável acontecer.
        return 0


def set_distances(distances, value):
    # Retorna os valores das distâncias, mínima, máxima e total.
    if len(distances) == 0:
        distances.append(value)
        distances.append(value)
        distances.append(value)
    else :
        if value > distances[1]:
            distances[1] = value
        if value < distances[0]:
           distances[0] = value
        distances[2] += value


def load_places(details, table, distances):
    # Retorna uma lista com a informação das atrações se tiverem um nome associado.
    data = get_places(details)
    places = []
    if data != None and data['type'] == 'FeatureCollection':
        for feature in data['features']:
            name = feature['properties'].get('name', '')
            if len(name) > 0:
                place = {}
                place['name'] = name
                place['country'] = feature['properties'].get("country", '')
                place['city'] = feature['properties'].get("city", '')
                place['street'] = feature['properties'].get("street", '')
                place['postcode'] = feature['properties'].get("postcode", '')
                place['lat'] = feature['properties'].get("lat", '')
                place['lon'] = feature['properties'].get("lon", '')
                distance = get_distance(details['coordinates']['lat'], details['coordinates']['lon'], place['lat'], place['lon'])
                set_distances(distances, distance)
                place['distance'] = distance
                change_table(place, table)
                places.append(place) 
    return places


def set_place_line(table):
    # Retorna a linha formatada com os comprimentos de cada coluna.
    name = '{:' + str(table[0]) + '}'
    country = '{:^' + str(table[1]) + '}'
    city = '{:^' + str(table[2]) + '}'
    street = '{:<' + str(table[3]) + '}'
    postcode = '{:^' + str(table[4]) + '}'
    lat = '{:<' + str(table[5]) + '}'
    lon = '{:<' + str(table[6]) + '}'
    distance = '{:>' + str(table[7]) + '}'
    return f'| {name} | {country} | {city} | {street} | {postcode} | {lat} | {lon} | {distance} |'


def print_details(details, separator):
    # Imprime a informação dos detalhes.
    print_header(separator)
    print_info('Detalhes', separator, '^')
    print_line('-', separator)
    if len(details['categories']) > 0:
        print_info('Categoria(s) selecionada(s): {}'.format(', '.join(details['categories'])), separator)
    if len(details['coordinates']) > 0:
        print_info('Ponto de partida (latitude,longitude): {}'.format(get_location(details['coordinates']['lat'], details['coordinates']['lon'])), separator)
    if details['radius'] > 0:
        print_info('Raio da pesquisa por atrações: {}'.format(details['radius']), separator)
    if details['limit'] > 0:
        print_info('Número limite de atrações: {}'.format(details['limit']), separator)
    if len(details['column']) == 2:
        print_info('Dados ordenados por: {}'.format(details['column'][1]), separator)
    if len(details['order']) == 2:
        print_info('Ordem: {}'.format(details['order'][1]), separator)
    print_line('=', separator)


def print_places(details, places, table, columns, distances, separator):
    # Imprime a informação detalhada do resultado da pesquisa.
    clear_screen()
    total = len(places)
    if total > 0:
        separator = 1 + len(table) * 3 + sum(table)
        print_details(details, separator)
        line = set_place_line(table)
        # Imprime os títulos de cada coluna.
        print(line.format(columns['1'][1], columns['2'][1], columns['3'][1], columns['4'][1],
                          columns['5'][1], columns['6'][1], columns['7'][1], columns['8'][1]))
        print_line('-', separator)
        column = details['column'][0]
        order = details['order'][0]
        for place in sorted(places, key = lambda place: normalize(place[column]), reverse = order):
            print(line.format(place['name'], place['country'], place['city'], place['street'],
                              place['postcode'], place['lat'], place['lon'], place['distance']))
        print_line('=', separator)
        print_info('Distância mínima: {:9}'.format(distances[0]), separator, '>')
        print_info('Distância máxima: {:9}'.format(distances[1]), separator, '>')
        print_info('Distância média: {:9}'.format(round(distances[2]/total)), separator, '>')
        print_line('-', separator)
        print_info('Número total de atrações: {}'.format(total), separator)
        print_line('=', separator)
    else:
        separator = 120
        print_details(details, separator)
        print_info('Não foram encontradas atrações com os detalhes escolhidos.', separator, '^')
        print_line('=', separator)


def save_places(places, separator):
    # Grava a informação das atrações no ficheiro 'csv' em utf-8.
    print_line('=', separator)
    info = 'Não existem atrações para gravar no ficheiro.'
    try:
        if len(places) > 0:
            ts = time.time()
            fname = f'places_{ts}.csv'
            with open(fname, 'w', encoding = 'utf-8') as f:
                # Lista ordenada pelas distâncias, ordem crescente.
                for place in sorted(places, key = lambda p: p['distance']):
                    f.write('{};{};{};{};{};{};{};{}\n'.format(place['name'], place['country'], place['city'], place['street'],
                                                            place['postcode'], place['lat'], place['lon'], place['distance']))
            info = 'Ficheiro "{}" gravado com sucesso!'.format(fname)
    except:
        info = 'Não foi possível gravar o ficheiro, ocorreu um erro de escrita.'
    print_header(separator)
    print_info('', separator)
    print_info(info, separator, '^')
    print_info('', separator)
    print_line('=', separator)


def load_details(details, fcategories, columns, separator):
    # Detalhe das categorias.
    details['categories'] = load_categories(fcategories, separator)
    # Detalhe das coordenadas do ponto de origem.
    details['coordinates'] = load_coordinates(details, separator)
    # Detalhe do raio de pesquisa.
    details['radius'] = load_number('raio (em metros)', 1, 50000, details, separator)
    # Detalhe do limite de atrações.
    details['limit'] = load_number('limite (de atrações)', 1, 500, details, separator)
    # Detalhe da coluna escolhida oara a ordenação dos dados.
    details['column'] = load_column(details, columns, separator)
    # Detalhe da ordem em que sentido os dados devem ser listados.
    details['order'] = load_order(details, separator)


def search_places(details, columns, separator):
    distances = []
    # Lista com a informação do comprimento de cada coluna da tabela.
    table = [len(value[1]) for value in columns.values()]
    places = load_places(details, table, distances)
    print_places(details, places, table, columns, distances, separator)
    set_wait()
    # Guarda a informação das atrações se existirem na lista.
    if len(places) > 0:
        save_places(places, separator)
        set_wait()


def load_search(fcategories, columns, separator):
    # Dicionário com a informação dos detalhes para fazer a pesquisa.
    details = {'categories' : set(), 'coordinates' : {}, 'radius' : 0, 'limit' : 0, 'column' : (), 'order' : ()}
    # Leitura dos detalhes.
    load_details(details, fcategories, columns, separator)
    # Imprime os resultados da pesquisa.
    search_places(details, columns, separator)
    
    
def main():
    # Comprimento da linha do separador.
    separator = 120
    # Importa as categorias do ficheiro num conjunto.
    fcategories = load_categories_file(separator)
    # Dicionário com a informação das colunas, contém o código, nome e descrição de cada coluna.
    columns = {'1' : ('name', 'Nome'), '2' : ('country', 'País'), '3' : ('city', 'Cidade'), '4' : ('street', 'Rua'),
             '5' : ('postcode', 'C.Postal'), '6' : ('lat', 'Latitude'), '7' : ('lon', 'Longitude'), '8' : ('distance', 'Distância')}
    # Inicia a pesquisa das atrações.
    search = True
    while search:
        load_search(fcategories, columns, separator)
        # Faz uma nova pesquisa se a resposta for 's'.
        search = load_option(separator)
    # Imprime a mensagem de saída.
    print_exit_msg(separator)


if __name__ == '__main__':
    main()