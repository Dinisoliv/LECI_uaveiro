package aula02;
import java.util.Scanner;

public class ex6 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int input, hours, minutes, seconds;
        System.out.print("Tempo(s): ");
        input = sc.nextInt();
        hours = input / 3600;
        int remainingSeconds = input % 3600;
        minutes = remainingSeconds / 60;
        seconds = remainingSeconds % 60;
        System.out.println(String.format("o tempo em h:m:s: %02d:%02d:%02d%n", hours, minutes, seconds));
        sc.close();
    }
}
