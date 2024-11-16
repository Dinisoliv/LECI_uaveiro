# Testa se um número é narcisista (quando a soma dos seus dígitos elevados à potência do número de dígitos é igual ao próprio número)
# Exemplo: 371 é narcisista porque 3 ** 3 + 7 ** 3 + 1 ** 3 = 371
def narcissistic( value ):
    tot = 0
    for i in str(value):
        tot += int(i) ** len(str(value))
    return tot == value


def main():
    assert(narcissistic(7) == True)
    assert(narcissistic(371) == True)
    assert(narcissistic(122) == False)
    assert(narcissistic(4887) == False)
    assert(narcissistic(1634) == True)
    assert(narcissistic(8208) == True)
    assert(narcissistic(9474) == True)
    assert(narcissistic(54748) == True)
    print("All tests passed!")

if __name__ == "__main__":
    main()

