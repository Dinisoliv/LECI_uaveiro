# O big boy: conta o número de maneira de subir uma escada de n degraus, onde cada passo pode ser de 1 ou 2 degraus
# Exemplo: 3 degraus -> 3 maneiras de subir: 1, 1, 1; 1, 2; 2, 1

def climb_stairs(n):
    #TODO
    pass


def main():
    assert(climb_stairs(1) == 1) # 1
    assert(climb_stairs(2) == 2) # 2
    assert(climb_stairs(3) == 3) # 3
    assert(climb_stairs(4) == 5) # 5
    assert(climb_stairs(5) == 8) # 8
    assert(climb_stairs(6) == 13) # 13
    assert(climb_stairs(7) == 21) # 21
    assert(climb_stairs(8) == 34) # 34
    assert(climb_stairs(9) == 55) # 55
    assert(climb_stairs(10) == 89) # 89
    assert(climb_stairs(11) == 144) # 144
    assert(climb_stairs(12) == 233) # 233
    assert(climb_stairs(13) == 377) # 377
    assert(climb_stairs(14) == 610) # 610
    assert(climb_stairs(15) == 987) # 987
    assert(climb_stairs(16) == 1597) # 1597
    assert(climb_stairs(17) == 2584) # 2584
    assert(climb_stairs(18) == 4181) # 4181
    assert(climb_stairs(19) == 6765) # 6765
    assert(climb_stairs(20) == 10946) # 10946
    assert(climb_stairs(21) == 17711) # 17711
    assert(climb_stairs(22) == 28657) # 28657
    assert(climb_stairs(23) == 46368) # 46368
    assert(climb_stairs(24) == 75025) # 75025
    assert(climb_stairs(25) == 121393) # 121393
    assert(climb_stairs(26) == 196418) # 196418
    assert(climb_stairs(27) == 317811) # 317811
    assert(climb_stairs(28) == 514229) # 514229
    print("All tests passed!")


if __name__ == "__main__":
    main()