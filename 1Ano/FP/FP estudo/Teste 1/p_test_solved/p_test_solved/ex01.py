# Calculadora de IMC
# Recebe o peso e a altura, calcula o IMC e imprime o resultado juntamente com a categoria
def main():
    # receber peso e altura
    peso = float(input("Digite o peso (em kilogramas): ")) 
    altura = float(input("Digite a altura (em metros): "))
    # para testar, use os valores 80 e 1.80 para peso e altura, respectivamente 
    # em que o resultado deve ser 24.69 e Saudável

def IMC(peso, altura):

    #calcular IMC
    imc = peso / (altura * altura)

    #classificar IMC e imprimir resultado
    if imc < 18.5:
        print(("IMC: {:.2f} - Abaixo do peso").format(imc))
    elif imc >= 18.5 and imc < 25:
        print(("IMC: {:.2f} - Saudável").format(imc))
    elif imc >= 25 and imc < 30:
        print(("IMC: {:.2f} - Forte").format(imc))
    elif imc >=30:
        print(("IMC: {:.2f} - Obeso").format(imc))

if __name__ == "__main__":
    main()