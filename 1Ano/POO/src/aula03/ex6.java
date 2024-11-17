package aula03;

import java.util.Scanner;

public class ex6 {
    public static final Scanner sc = new Scanner(System.in);
    public static void main(String[] args) {
        String input;

        //Scanner sc = new Scanner(System.in);
        System.out.print("Introduza uma String: ");
        input = sc.nextLine();
        //sc.close();

        String inputLower = StringToLower(input);
        System.out.println("String em minusculas: " + inputLower);

        char lastChar = LastCharacter(input);
        System.out.println("Ultimo caracter: " + lastChar);

        //Use String format?
        System.out.println("Primeiros 3 caracteres: " + PositionChar(input, 0) + 
        ", " + PositionChar(input, 1) + ", " + PositionChar(input, 2));

        String inputUpper = StringToUpper(input);
        System.out.println("String em minusculas: " + inputUpper);

        concatString(input);

        System.out.println("Saber o index de: ");
        String indexString = sc.nextLine();
        int indexInfo = returnIndex(input, indexString);
        if (indexInfo == -1) {
            System.out.println("Isso não existe na string imcial");
        }
        else{
            System.out.println("A 1a ocorrência encontra-se na posição: " + (indexInfo+1));
        }
    }

    public static String StringToLower(String input){
        String inputLower = input.toLowerCase();
        return inputLower;
    }

    public static char LastCharacter(String input){
        char lastChar = input.charAt(input.length() - 1);
        return lastChar;
    }

    public static char PositionChar(String input, int position){
        char positionChar = input.charAt(position);
        return positionChar;
    }

    public static String StringToUpper(String input){
        String inputUpper = input.toUpperCase();
        return inputUpper;
    }

    public static void concatString(String input){
        //Scanner sc = new Scanner(System.in);
        System.out.print("String para adicionar à String anterior: ");
        String string2 = sc.nextLine();
        //sc.close();
        System.out.println("Concated String: " + input.concat(string2));
    }

    public static int returnIndex(String input, String indexInfo){
        return input.indexOf(indexInfo);
    }

}

//more methods?

//compareToIgnoreCase()
//toCharArray()
//contains()

/*
Construa um programa que leia uma String (uma palavra, frase ou parágrafo) e que apresente,
usando exclusivamente métodos da classe String:
• uma nova frase, convertida para minúsculas;
• o último carater da frase;
• os 3 primeiros carateres.
• Utilize ainda outros métodos da classe String (no mínimo, mais três) e verifique o seu
resultado no programa.
 */