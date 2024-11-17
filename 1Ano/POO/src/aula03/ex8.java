package aula03;

import java.util.Scanner;

public class ex8 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String phrase = "";
        String acronym = "";
        
        System.out.println("Introduz uma frase:");
        phrase = sc.nextLine();
        String[] words = phrase.split(" ");
        for (int i = 0; i < words.length; i++) {
            if (words[i].length() > 3) {
                acronym = acronym + (words[i].charAt(0));
            }
        }
        System.out.println("Acrónimo: " + acronym.toUpperCase());
        sc.close();
    }
}
