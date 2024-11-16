# Simula o jogo de cows e bulls: cows são os caracteres que estão na posição correta, bulls são os caracteres que estão na posição errada
# Exemplo: secret = "1234" e guess = "1432" -> (2, 2) porque 1 e 2 estão na posição correta e 3 e 4 estão na posição errada

def score(guess, secret):
    assert len(guess) == len(secret)

    cows = 0
    bulls = 0
    bulls_a = []

    for i in range(len(secret)):
        if guess[i] == secret[i]:
            cows +=1
        else:
            if guess[i] in secret and guess[i] not in bulls_a:
                bulls+=1
                bulls_a.append(guess[i])
    return (cows,bulls)

def main():
    assert(score("1234", "1234") == (4, 0)) # (4, 0)
    assert(score("1234", "4321") == (0, 4)) # (0, 4)
    assert(score("1234", "1432") == (2, 2)) # (2, 2)
    assert(score("ALADA", "MARIA") == (1, 1)) # (2, 2)
    assert(score("1234", "5678") == (0, 0)) # (0, 0)
    assert(score("1234", "1111") == (1, 0)) # (1, 0)
    assert(score("1234", "1122") == (1, 1)) # (1, 1)
    print("All tests passed!")

if __name__ == "__main__":
    main()
