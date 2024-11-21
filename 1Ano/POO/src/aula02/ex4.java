package aula02;
import java.util.Scanner;

public class ex4 {
    public static void main(String[] args) {
        double montante, taxaJuro, valorFinal;
        int meses = 3;
        Scanner sc = new Scanner(System.in);
        System.out.print("Montante Investido: ");
        montante = sc.nextDouble();
        System.out.print("Taxa de juro: ");
        taxaJuro = sc.nextDouble() / 100.0;
        valorFinal = montante * Math.pow(taxaJuro + 1, meses);
        System.out.println("Valor total depois de 3 meses: " + valorFinal);
        sc.close();
    }
}
