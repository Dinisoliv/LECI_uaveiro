package aula03;

import java.util.Scanner;

public class ex2 {
    public static void main(String[] args) {
        double investment, interest;
        Scanner sc = new Scanner(System.in);
        do {
            System.out.println("Montante investido: ");
            investment = sc.nextDouble();
        } while (investment < 0 && investment % 1000 != 0);
        do {
            System.out.println("Taxa de Juro Mensal: ");
            interest = sc.nextDouble();
        } while (interest < 0 && interest > 5);
        sc.close();
        for (int i = 0; i < 12; i++) {
            investment = investment + investment * (interest / 100);
            System.out.println("Montante após o " + i + "º mês: " + investment);
        } 
    }
}


/*
Um fundo de investimento fornece uma taxa de juros mensal fixa, que acumula com o saldo
anterior do investimento (juros rendem juros). Escreva um programa em Java que peça ao
utilizador o montante investido (positivo e múltiplo de 1000) e a taxa de juro mensal (entre
0% e 5%). Verifique se os valores são válidos e apresente o valor mensal do fundo nos
próximos 12 meses, imprimindo o valor em cada mês.
 */
