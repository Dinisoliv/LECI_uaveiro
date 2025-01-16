package aula02;
import java.util.Scanner;

public class ex9 {
    public static void main(String[] args) {
        int number = -1;
        Scanner sc = new Scanner(System.in);
        while (number < 0) {
            System.out.print("Introduza um numero natural: ");
            number = sc.nextInt();
        sc.close();
        }
        while (number > 0) {
            System.out.print(number + ",");
            if (number % 10 == 0) {
                System.out.println(" ");
            }
            number--;
        }
        System.out.println(" ");
    }
}
