def matchday_f(matchday):
    with open('Jornadas.csv', 'r') as f:
        count = 0
        games = []
        while True:
            for line in f:
                num_jornada, home, away = line.strip().split(',')
                if num_jornada == matchday:
                    game = f"{home} vs {away}"
                    games.append(game)
                    count += 1
                elif count !=0:
                    return games

def betSaving(matchday):
    games = matchday_f(matchday)
    count = 1
    bets = []
    for game in games:
        print(count, game)
        while True:
            bet = input('Aposta (1,X,2)? ')
            bet = bet.upper()
            if bet in ['1', 'X' , '2']:
                bets.append((game, bet))
                count += 1
                break
            else:
                print("Aposta inválida! Por favor, insira 1, X ou 2.")
        with open(f'bets{matchday}.csv', 'w') as csvfile:
            #csvfile.write("Home,Away,Bet\n")
            for game, bet in bets:
                home, away = game.split(' vs ')
                csvfile.write(f"{home},{away},{bet}\n")

    return bets

def getResult():
    with open('Jogos.csv', 'r') as f:
        results = {}
        for line in f:
            date, home, away, goals_home, goals_away = line.strip().split(',')
            results[(home, away)] = int(goals_home), int(goals_away)
    return results

def displayResults(matchday):
    results = getResult()
    bets = betSaving(matchday)
    print(f"Jornada {matchday}")
    print("{:<4} {:<15} {:<15} {:<5} {:<10} {:<10}".format("Num", "Home", "Away", "Goals_Home", "Goals_Away", "Verdict"))
    games = matchday_f(matchday)
    for count, game in enumerate(games, start=1):
        home, away = game.split(' vs ')
        result = results.get((home, away), ('', ''))

        if bets[count] == '1' and result[0] > result[1]:
            verdict = "CERTO"
        elif bets[count] == 'X' and result[0] == result[1]:
            verdict = "CERTO"
        elif bets[count] == '2' and result[0] < result[1]:
            verdict = "CERTO"
        else:
            verdict = "ERRADO"

        print("{:<4} {:<15} {:<15} {}-{:<10} {:<10}".format(count, home, away, result[0], result[1], verdict))

def main():
    matchday = input('Jornada? ')
    displayResults(matchday)

if __name__=="__main__":
    main()