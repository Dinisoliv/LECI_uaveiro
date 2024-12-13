RANK, CLUB, COUNTRY, SCORE, CHANGE, PSCORE, UP = 0, 1, 2, 3, 4, 5, 6
import sys

#1
def loadFile(fname):
    lst = []
    with open (fname, encoding='utf-8') as f:
        head = f.readline()
        if not head.startswith("ranking,club name"):
            raise Exception("wrong file format")
        for line in f:
            line = line.strip()
            parts = line.split(',')
            ch = int(parts[4])
            if parts[UP] == '-':
                ch = -ch
            tup = (int(parts[0])), (parts[1]), (parts[2]), (int(parts[3])), ch, (int(parts[5]))
            lst.append(tup)
    return lst
    
#1.5    
def printTuples(lst):
    for tup in lst:
        print(tup)

#2
#Ver formatação
def listByCountry(lst, file=sys.stdout):
    country = input("Country for information table: ")
    print(f"\n{'Club':40} {'Country':20} {'Rank':>8} {'Score':>8}", file=file)
    for tup in lst:
        if tup[COUNTRY].casefold() == country.casefold():
            print(f"{tup[CLUB]:40} {tup[COUNTRY]:40} {tup[RANK]:8} {tup[SCORE]:8}", file=file)

#2.5
def listByCountry2(lst):
    country = input("Country for information table: ")
    print(f"{'Club':40} {'Country':20} {'Rank':<8} {'Score':<8}")
    for tup in lst:
        if tup[COUNTRY].casefold() == country.casefold():
            print(f"{tup[CLUB]:<40} {tup[COUNTRY]:<20} {tup[RANK]:<8} {tup[SCORE]:<8}")

#3a
def saveByCountry(lst):
    country = input("Country for saving in the file: ")
    fname = input("Name of the file (.txt): ")
    with open (fname, 'w') as f:
        for tup in lst:
            if tup[COUNTRY].casefold() == country.casefold():
                f.write(f"{tup[CLUB]},{tup[COUNTRY]:},{tup[RANK]},{tup[SCORE]}\n")
#3b
def saveByCountry2(lst):
    country = input("Country for saving in the file: ")
    fname = input("Name of the file (.txt): ")
    with open(fname, 'w') as f:
        listByCountry(lst, country, file=f)

#4
def clubsByCountry(lst):
    dic = {}
    for tup in lst:
        country = tup[COUNTRY]
        club = tup[CLUB]
        if country not in dic:
            dic[country] = []
        dic[country].append(club)
    for key, values in dic.items():
        print(f"{key}: {', '.join(map(str, values))}")
    
    country_choice=input("\nChoose a country to see its clubs? ")
    values = dic[country_choice]
    print(f"{country_choice}: {', '.join(map(str, values))}")
#5a
def bestRise(lst):
    return

#5b   
def bestRise1(lst):
    return

#5c
def bestRise2(lst):
    print(max(lst, key=lambda x: int(x[4])))
    
#6
def clubInfo(lst):
    club = input("Clube?")
    for tup in lst:
        if tup[1] == club:
            print(f"Club: {tup[CLUB]}, Country: {tup[COUNTRY]}:, Rank: {tup[RANK]:}, Score: {tup[SCORE]:} Change: {tup[CHANGE]}, Previous Score: {tup[PSCORE]}")

#7
def averageRankingCountry(lst):
    dic = {}
    for tup in lst:
        country = tup[COUNTRY]
        rank = tup[RANK]
        if country not in dic:
            dic[country] = []
        dic[country].append(rank)
    avg = {country: sum(ranks) / len(ranks) for country, ranks in dic.items()}
    for key, value in avg.items():
        print(f'{key}: {value}')    

#8a
def rankingOrder(lst):
    dic = {}
    for tup in lst:
        country = tup[COUNTRY]
        rank = tup[RANK]
        if country not in dic:
            dic[country] = []
        dic[country].append(rank)
    avg = {country: sum(ranks) / len(ranks) for country, ranks in dic.items()}
    sorted_items = sorted(avg.items(), key=lambda x: x[1], reverse=True)
    for key, value in sorted_items:
        print(f'{key}: {value}')

#8b
#Use some faster sorting

#9
def Menu(lst):
    while True:
        print('__________________________________________________________')
        print("\nMenu:")
        print("0. Quit")
        print("1. Imprimir tuplos de todos os clubes")
        print("2. Informações sobre clubes do país")
        print("3. Escrever ficheiro com informações sobre clubes do país")
        print("4. Ver clubes de um país")
        print("5. Ver clube que mais subiu no ranking")
        print("6. Ver detalhes de um clube")
        print("7. Média do ranking de cada país")
        print("8. Obter países por ordem crescente do ranking")

        choice = input("Escolha uma opção do menu: ")
    
        if choice == '1':
            printTuples(lst)
        elif choice == '2':
            listByCountry2(lst)
        elif choice == '3':
            saveByCountry(lst)
        elif choice == '4':
            clubsByCountry(lst)
        elif choice == '5':
            bestRise2(lst)
        elif choice == '6':
            clubInfo(lst)
        elif choice == '7':
            averageRankingCountry(lst)
        elif choice == '8':
            rankingOrder(lst)
        elif choice == '0':
            print("Exiting the program. Goodbye!")
            break
        else:
            print("Invalid choice. Please enter a valid number.")


def main():
    fname = "Soccer_Football Clubs Ranking.csv"
    lst = loadFile(fname)
    Menu(lst)

if __name__ == "__main__":
    main()