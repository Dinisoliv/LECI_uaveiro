RANK, CLUB, COUNTRY, SCORE, CHANGE, PSCORE, UP = 0, 1, 2, 3, 4, 5, 6

    
def loadFile(fname):
    lst = []
    with open(fname, encoding="utf-8") as f:
        head = f.readline()
        if not head.startswith("ranking,club name"):
            raise Exception("wrong file format")
        for line in f:
            line = line.strip()
            parts = line.split(',')
            ch = int(parts[4])
            #if parts[UP] == '-':
            tup = (int(parts[0])), parts[1], parts[2], int(parts[3]), int(parts[4]), int(parts[5]), parts[6]
            lst.append(tup)
            
    return lst
    
def listByCountry(lst, country):
    print(f"{'CLUB': <40} {'COUNTRY': <20} {'RANK': >8} {'SCORE': >8}")
    for tup in lst:
        if tup[COUNTRY].casefold() == country.casefold():
            print(f"{tup[CLUB]: <40} {tup[COUNTRY]: <20} {tup[RANK]: >8} {tup[SCORE]: >8}")
              
    
def saveByCountry(lst, country, fname):
    with open(fname, 'w') as f:
        for tup in lst:
            if tup[COUNTRY].casefold() == country.casefold():
                f.write(f"{tup[CLUB]},{tup[COUNTRY]},{tup[RANK]},{tup[SCORE]}\n")

def clubByCountry(lst):
    dic = {}
    for tup in lst:
        country = tup[COUNTRY]
        if country not in dic:
            dic[country] = []
        dic[country].append([CLUB])
    return dic

def bestRise(lst):
    best = lst[0]
    for tup in lst:
        ch = tup[CHANGE]
        if ch > best[CHANGE]:
            best = tup
    return best
    
def bestRiseb(lst):
    ibest = 0
    for i in range(len(lst)):
        ch = lst[i][CHANGE]
        if ch > lst[ibest][CHANGE]:
            ibest = 1
    return lst[ibest]
    
def averageCountryRanking(lst):
    dic = {}
    for tup in lst:
        country = tup[COUNTRY]
        rank = tup[RANK]
        if country not in dic:  
            dic[country] = [rank, 1]
        else:
            sumcount = dic[country]
            sumcount[0] += rank
            sumcount[1] += 1
    avDic = {country: sumrank / sumcount[1] for country, (sumrank, _) in dic.items()}
    return avDic
    
def printLine(avDic):
    for country, average_ranking in avDic.items():
        print(f"{country}: {average_ranking:.2f}")
    
def main():
    country_0 = input('Country name: ')
    fname ="Soccer_Football Clubs Ranking.csv"
    lst = loadFile(fname)
    listByCountry(lst, country_0)
    saveByCountry(lst, 'Angola', 'listAngola.txt')
    clubS = clubByCountry(lst)
    print(bestRise(lst))
    average_ranking = averageCountryRanking(lst)
    printLine(average_ranking)
    
    
if __name__== "__main__":
    main()  