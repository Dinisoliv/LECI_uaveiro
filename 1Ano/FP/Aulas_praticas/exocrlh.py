def inputFloatList():
    num_list = []
    while True:
        try:
            num = input("Digite um número (ou deixe em branco para terminar): ")
            if num == "":
                break
            num = float(num)
            num_list.append(num)
        except ValueError:
            print("Por favor, digite um número válido.")
    return num_list

def countLower(lst, v):
    count = 0
    for num in lst:
        if num < v:
            count += 1
    return count

def minmax(lst):
    if not lst:
        return None, None

    minimum = maximum = lst[0]

    for num in lst:
        if num < minimum:
            minimum = num
        elif num > maximum:
            maximum = num

    return minimum, maximum

num_list = inputFloatList()

if num_list:
    min_val, max_val = minmax(num_list)
    avg_val = (min_val + max_val) / 2

    count = countLower(num_list, avg_val)

    print(f"O mínimo é {min_val}, o máximo é {max_val}, e o valor médio é {avg_val}.")
    print(f"{count} números na lista são menores do que o valor médio.")
else:
    print("A lista está vazia.")

