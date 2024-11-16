# Calculadora de IMC
# Recebe o peso e a altura, calcula o IMC e imprime o resultado juntamente com a categoria
def main():
    # receber peso e altura
    height = float(input("altura?"))
    weight = float(input("peso?"))
    # para testar, use os valores 80 e 1.80 para peso e altura, respectivamente 
    # em que o resultado deve ser 24.69 e Saudável

def IMC(height, weight):

    #calcular IMC
    IMC = height / altura**2

    #classificar IMC e imprimir resultado
    if IMC < 18.5:
        print("magro")
    elif IMC > 18.5 and IMC < 25:
        print("Saudável")
    elif IMC > 25 and IMC < 30:
        print("Forte")
    else:
        print("Obeso")
        
if __name__ == "__main__":
    main()
    IMC(height, weight)