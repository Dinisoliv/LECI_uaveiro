def fibonacci(n):
    res = []
    if n < 0:
        return res
    elif n == 0:
        res = [0]
    elif n == 1:
        res = [0, 1]
    else:
        res = [0, 1]
        for i in range(1, n):
            res.append(res[-1] + res[-2])
    return res
     
    
#Para valores de n inferiores a 0 a função deverá devolver uma lista vazia.
#Para n igual a 0 a função deverá devolver [0].
#Para n igual a 1 a função deverá devolver [0, 1].
#Para n igual a 2 a função deverá devolver [0, 1, 1].
#Para n igual a 5 a função deverá devolver [0, 1, 1, 2, 3, 5].
#Para qualquer n a função deverá devolver uma lista com n + 1 elementos.