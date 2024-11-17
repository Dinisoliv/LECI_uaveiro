package aula02;
import java.util.Scanner;

//Q = M * (finalTemperature - initialTemperature) * 4184.

public class ex3 {
    public static void main(String[] args) {
        double finalTemperature, initialTemperature, massa, energy;
        Scanner sc = new Scanner(System.in);
        System.out.print("massa de água?(kg): ");
        massa = sc.nextDouble();
        System.out.print("Temperatura inicial?(ºC): ");
        initialTemperature = sc.nextDouble();
        System.out.print("Temperatura final?(ºC): ");
        finalTemperature = sc.nextDouble();
        energy = massa * (finalTemperature - initialTemperature);
        System.out.println("Energia (J):" + energy);
        sc.close();
    }
}
