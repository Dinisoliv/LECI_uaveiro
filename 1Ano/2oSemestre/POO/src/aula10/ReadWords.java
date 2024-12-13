package aula10;

import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Scanner;

public class ReadWords {
    public static void main(String[] args) throws IOException {
        Scanner input = new Scanner(new FileReader("words.txt"));
        ArrayList<String> wordsList = new ArrayList<>();

        // b) Guardar palavras com mais de 2 caracteres
        while (input.hasNext()) {
            String word = input.next();
            if (word.length() > 2) {
                wordsList.add(word);
            }
        }
        input.close(); // É uma boa prática fechar o Scanner quando terminar

        // c) Listar todas as palavras terminadas em 's'
        System.out.println("Palavras terminadas em 's':");
        for (String word : wordsList) {
            if (word.endsWith("s")) {
                System.out.println(word);
            }
        }

        // d) Remover palavras que contenham outros caracteres que não letras
        Iterator<String> iterator = wordsList.iterator();
        while (iterator.hasNext()) {
            String word = iterator.next();
            if (!word.matches("[a-zA-Z]+")) {
                iterator.remove();
            }
        }

        // Listar todas as palavras restantes na estrutura de dados
        System.out.println("\nPalavras restantes (após remoção de palavras com caracteres não alfabéticos):");
        for (String word : wordsList) {
            System.out.println(word);
        }
    }
}
