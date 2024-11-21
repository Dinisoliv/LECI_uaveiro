package aula12;

import java.io.File;
import java.io.IOException;
import java.util.Set;
import java.util.HashSet;
import java.util.Scanner;


public class WordsCounter {
    public static void main(String[] args) {
        Set <String> wordsSet = new HashSet<>();
        String fileName = "text.txt";
        int wordCount = 0;
        
        try (Scanner input = new Scanner(new File(fileName))) {
            while (input.hasNextLine()) {
                String[] words = input.nextLine().split("[\\s\\t\\n\\r\\f,.:;?!\\[\\]'\"()]+");
                for (String word : words) {
                    if (!word.isEmpty()) {
                        wordCount++;
                        wordsSet.add(word.toLowerCase());
                    }
                }
            }
            System.out.println("Número Total de Palavras:" + wordCount);
            System.out.println("Número de Diferentes Palavras:" + wordsSet.size());
        } catch (IOException e) {
            System.out.println("An error occurred.");
            e.printStackTrace();
        }
    }
}
