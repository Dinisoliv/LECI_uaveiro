package aula02;
import java.util.Scanner;

public class ex7 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Introduza a coordenada x1: ");
        double x1 = sc.nextDouble();
        System.out.print("Introduza a coordenada y1: ");
        double y1 = sc.nextDouble();
        System.out.print("Introduza a coordenada x2: ");
        double x2 = sc.nextDouble();
        System.out.print("Introduza a coordenada y2: ");
        double y2 = sc.nextDouble();
        double distance = Math.sqrt(Math.pow((x2-x1),2) + Math.pow((y2-y1), 2));
        System.out.println("Distancia entre os 2 pontos: " + distance);
        sc.close();
    }
}
