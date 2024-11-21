package aula03;

import java.util.Scanner;

public class ex1 {
    public static void main(String[] args) {
        int number, sum = 0;
        Scanner sc = new Scanner(System.in);
        do{
            System.out.print("Introduza um número (inteiro positivo): ");
            number = sc.nextInt();
        }
        while (number <= 0);
        for (int i = 1; i <= number; i++) {
            if (isPrimeNumber(i)) {
                System.out.println(i);
                sum += i;
            }
        }
        sc.close();
        System.out.println("A soma dos números primos até ao valor dado: " + sum);
    }

    public static boolean isPrimeNumber(int num) {
        if (num <= 1) {
            return false;
        }
    
        for (int i = 2; i <= Math.sqrt(num); i++) {
            if (num % i == 0) {
                return false;
            }
        }
    
        return true;
    }
}


/* 
Escreva um programa que leia do teclado um número inteiro positivo e devolva a soma de
todos os números primos até esse valor (inclusive). Repare que deve validar o valor de
entrada repetindo a leitura se o valor não for válido (positivo).
Deve implementar uma função que devolva se um número é um número primo. Um número
natural é um número primo quando tem exatamente dois divisores naturais distintos: o
número 1 e ele mesmo.
 */

 /*
    public boolean primeNumber(int num){
        boolean prime = false;
        double half = num / 2;
        int value = (int) half;
        while (half > 1 && prime == false) {
            if (num % half == 0) {
                prime = true;
            }
            half -= 1;
        }
        return prime;
    }
  */