package aula03;

import java.util.Scanner;
import java.util.Random;

public class ex3 {
    public static final Scanner sc = new Scanner(System.in);
    public static void main(String[] args) {
        String yesNO;
        while (true){
            highLow();
            System.out.println("Pretende continuar? Prima (S)im ");
            yesNO = sc.nextLine(); //not working properly!!!

            if (yesNO.equalsIgnoreCase("S") || yesNO.equalsIgnoreCase("Sim")) {
                break;
            }
        }
    }

    public static void highLow(){
        Random rand = new Random();
        //Scanner sc = new Scanner(System.in);
        int numberRandom = rand.nextInt(101) + 1;
        System.out.println(numberRandom);
        int counter = 1;
        while (true) {
            System.out.print("Insira um número: ");
            int numberChoice = sc.nextInt();
            if (numberChoice < 1 || numberChoice > 100) {
                System.out.println("Número entre 0 e 100");
                continue;
            }
            if (numberRandom > numberChoice) {
                System.out.println("Baixo");
            }
            else if (numberRandom < numberChoice) {
                System.out.println("Alto");
            }
            else{
                System.out.println("Acertou!!!");
                break;
            }
            counter += 1;
        }
        System.out.println("Número de tentativas: " + counter);
        //sc.close();
    }
}

/*
O jogo AltoBaixo consiste em tentar adivinhar um número (inteiro) entre 1 e 100. O
programa escolhe um número aleatoriamente. Depois, o utilizador insere uma tentativa e o
programa indica se é demasiado alta, ou demasiado baixa. Isto é repetido até o utilizador
acertar no número. O jogo deve indicar quantas tentativas foram feitas e de seguida
perguntar: “Pretende continuar? Prima (S)im”. O programa termina caso a resposta seja
diferente de “S” ou “Sim”.
Sugestão: para ler uma palavra utilize o método next: String resposta = sc.next();.
*/