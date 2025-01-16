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
        for i in range(1, n - 1):
            res.append(res[-1] + res[-2])
    return res

# Example: Generate the first 10 numbers in the Fibonacci sequence
#result = fibonacci(10)
#print(result)

def counter(n):
    for i in range(1, n):
        print(i)

#counter(5)