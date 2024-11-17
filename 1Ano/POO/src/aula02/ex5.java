package aula02;
import java.util.Scanner;

public class ex5 {
    public static void main(String[] args) {
        double d1 = -1, d2 = -1, v1 = -1, v2 = -1, vFinal;
        Scanner sc = new Scanner(System.in);

        while (d1 < 0){
            System.out.print("Distancia do 1º percurso: ");
            d1 = sc.nextDouble();
        }
        
        while (v1 < 0){
            System.out.print("Velocidade do 1º percurso: ");
            v1 = sc.nextDouble();
        }
        
        while (d2 < 0){
            System.out.print("Distancia do 2º percurso: ");
            d2 = sc.nextDouble();
        }
        
        while (v2 < 0){
            System.out.print("Velocidade do 2º percurso: ");
            v2 = sc.nextDouble();
        }
        
        vFinal = (d1 + d2) / (d1/v1 + d2/v2);
        System.out.println("Velocidade Média Final: " + vFinal);
        sc.close();
    }
}

