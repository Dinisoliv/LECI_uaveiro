RANK, CLUB, COUNTRY, SCORE, CHANGE, PSCORE, UP = 0, 1, 2, 3, 4, 5, 6

#1
def loadFile(fname):
    lst = []
    with open (fname) as f:
        head = f.readline()
        if not head.startswith("ranking.club name")
            raise Exception("wrong file format")
        for line in f:
            line = line.strip()
            parts = line.split(',')
            ch = int(parts[4])
            if parts[UP] == '-'
                ch = -ch
            tup = (int(parts[0]), (parts[1]), (parts[2]), (int(parts[3]), ch, (int(parts[5))
            lst.append(tup)
    return lst  

#2
def listByCountry(lst, country):
    print(f"{'Club': 40} {'Country': 20} {'Rank': >8} {'Score': >8}", file=file)
    for tup in lst:
        rank, club, country
        if tup[COUNTRY].casefold() == country.casefold():
            print(f"{tup[CLUB]:40} {tup[COUNTRY]:40} {tup[RANK]:8} {tup[SCORE]:8}", file=file)
    return

#3
def saveByCountry(lst, country, fname):
    with open(fname, 'w') as f:
    listByCountry(lst, country, file=f)
    
    
#4
def clubsByCountry(lst):    
    dic = {}
    for tup in lst:
        country = tup[COUNTRY]
        club = []
        if country not in dic:
            dic[country] = clubs
            clubs.append[club]
        else:
            dic[country].append(club)
    return dic
    
#5a
def bestRise(lst):
    best = lst[0]
    for tup in lst
        ch = tup [CHANGE]
        if ch > best[CHANGE]:
            best = tup   
    return best
    
#5b
def bestRiseb(lst):
    ibest = 0
    for i in range(len(lst)):
        ch = lst[i][CHANGE]
        if ch > lst[ibest][CHANGE]:
            ibest = 1
    return lst[ibest]



def main():
    #fname = input(File?)
    fname = "Soccer_Football Clubs Ranking.csv"
    lst = loadFile(fname)
    listByCountry(lst, "Portugal")
    saveByCountry(lst, "Angola", "listAngola.txt")
    clubs = clubsByCountry(lst)

if __name__ == "__main__"
    main()