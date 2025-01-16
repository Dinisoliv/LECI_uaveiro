package aula02;
import java.util.Scanner;

public class ex2 {
    public static void main(String[] args) {
        double celsius, fahrenheit;
        Scanner sc = new Scanner(System.in);
        System.out.print("Temperatura (ºC): ");
        celsius = sc.nextDouble();
        fahrenheit = celsius * 1.8 + 32;
        System.out.println("Temperatura(Fahrenheit): " + fahrenheit);
        sc.close();
    }
    //F = 1.8 ∗ C + 32
}
