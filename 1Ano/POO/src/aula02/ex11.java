package aula02;
import java.util.Scanner;

public class ex11 {
    static void validateNumber(int lowerLimit, int upperLimit){
        Scanner sc = new Scanner(System.in);
        System.out.print("Introduza um numero dentro do intervalo:");
        int number = sc.nextInt();
        while (lowerLimit < number && number > upperLimit) {
            System.out.print("Introduza um numero dentro do intervalo:");
            number = sc.nextInt();
        }
        sc.close();
    }
}
