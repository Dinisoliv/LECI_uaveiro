package aula02;
import java.util.Scanner;

public class ex10 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Introduza um numero: ");
        double initialNumber = sc.nextDouble();
        double i = initialNumber;
        double maxNumber = initialNumber;
        double minNumber = initialNumber;
        double total = initialNumber, media;
        int counter = 1;
        while (true) {
            System.out.print("Introduza um numero: ");
            i = sc.nextDouble();
            total += i;
            counter++;
            if (i == initialNumber) {
                break;
            }
            if (i > maxNumber) {
                maxNumber = i;
            }
            if (i < minNumber) {
                minNumber = i;
            }
        }
        sc.close();
        media = total / counter;
        System.out.println("\nValor Máximo: " + maxNumber);
        System.out.println("Valor Minimo: " + minNumber);
        System.out.println("Média: " + media);
        System.out.println("Total: " + total);
    }
}
