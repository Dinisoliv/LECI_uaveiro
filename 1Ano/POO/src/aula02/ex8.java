package aula02;
import java.util.Scanner;

public class ex8 {
    public static void main(String[] args) {
        double catetoA = -1, catetoB = -1, hipotenusaC;
        Scanner sc = new Scanner(System.in);
        while (catetoA < 0){
            System.out.print("Introduza o valor do cateto A: ");
            catetoA = sc.nextDouble();
        }
        while (catetoB < 0){
            System.out.print("Introduza o valor do cateto B: ");
            catetoB = sc.nextDouble();
        }
        hipotenusaC = Math.sqrt(Math.pow(catetoA, 2) + Math.pow(catetoB, 2));
        System.out.println("Valor da Hipotenusa C: " + hipotenusaC);
        sc.close();
        double angleInRadians = Math.atan(catetoB / catetoA);
        double angleInDegrees = Math.toDegrees(angleInRadians);
        System.out.println("Ângulo entre cateto A e hipotenusa em radianos: " + angleInRadians);
        System.out.println("Ângulo entre cateto A e hipotenusa em graus: " + angleInDegrees);
    }
}
