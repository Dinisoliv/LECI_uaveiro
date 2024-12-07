import pytest
from fibonacci import fibonacci

def test_inferior_1():
    print("Testa o comportamento com n<1")
    assert fibonacci(-1) == []
    assert fibonacci(0) == [0]
    assert fibonacci(1) == [0, 1]
    print("Fase 1 OK")
    assert fibonacci(2) == [0, 1, 1]
    assert fibonacci(5) == [0, 1, 1, 2, 3, 5]
    for i in range(1,30):
        assert len(fibonacci(i)) == i+1
    print("Teste OK")

test_inferior_1()

#Para valores de n inferiores a 0 a função deverá devolver uma lista vazia.
#Para n igual a 0 a função deverá devolver [0].
#Para n igual a 1 a função deverá devolver [0, 1].
#Para n igual a 2 a função deverá devolver [0, 1, 1].
#Para n igual a 5 a função deverá devolver [0, 1, 1, 2, 3, 5].
#Para qualquer n a função deverá devolver uma lista com n + 1 elementos.