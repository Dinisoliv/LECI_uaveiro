package aula03;

import java.util.Scanner;

public class ex7 {
    public static void main(String[] args) {
        String phrase;
        Scanner sc = new Scanner(System.in);

        System.out.print("Introduza frase: ");
        phrase = sc.nextLine();
        System.out.println("Número de caracteres numéricos da String: " + countDigits(phrase));
        System.out.println("Número de espaços da String: " + countSpaces(phrase));
        System.out.println("Está tudo em minusculas: " + allLowerCase(phrase));
        System.out.println("String com os espaços extras removidos: " + removeSpaces(phrase));
        System.out.println("A String é um palindromo: " + isPalindrome(phrase));
        sc.close();
    }

    public static int countDigits(String s){
      int count = 0;
      for (int i = 0; i < s.length(); i++) {
        if (Character.isDigit(s.charAt(i))) {
          count++;
        }
      }
      return count; 
    }

    public static int countSpaces(String s){
      int count = 0;
      for (int i = 0; i < s.length(); i++) {
        if (Character.isWhitespace(s.charAt(i))) {
          count++;
        }
      }
      return count; 
    }

    public static boolean allLowerCase(String s){
      return s.equals(s.toLowerCase());
    }

    public static String removeSpaces(String s){
      return s.replaceAll("\s+", " ");
    }

    public static boolean isPalindrome(String s){
      int length = s.length();
      String sOposite = "";
      for (int i = length - 1; i >= 0; i--) {
        sOposite = sOposite.concat(String.valueOf(s.charAt(i)));
      }
      return s.equals(sOposite);
    }

    public static boolean isPalindrome2(String s){
      int left = 0;
      int right = s.length() - 1;
      
      while (left < right) {
        if (s.charAt(left) != s.charAt(right)){
          return false;
        }
        left++;
        right--;
      }
      return true;
    }
}


/*
Construa um programa que leia uma frase. Adicionalmente, construa métodos estáticos e use-
os na função main, para realizar cada uma das operações seguintes:
• conte o número de carateres numéricos (0..9) da String;
Ex: public static int countDigits(String s){…}
• conte quantos espaços contém;
• indique se só contém minúsculas;
• devolva uma String, onde todas as ocorrências de vários espaços seguidos são
substituídas por um único espaço;
• indique se a String é um palíndromo.
 */
