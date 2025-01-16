package aula12;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.Scanner;
import java.util.TreeMap;

public class AlphaWordCounter {
    public static void main(String[] args) {
        Map <Character, TreeMap<String, Integer>> wordOrder = new TreeMap<>();
        String fileName = "text.txt";

        try (Scanner input = new Scanner(new File(fileName))) {
            while (input.hasNextLine()) {
                String[] words = input.nextLine().toLowerCase().split("[\\s\\t\\n\\r\\f,.:;?!\\[\\]'\"()]+");
                for (String word : words) {
                    if (!word.isEmpty() && !wordOrder.containsKey(word.charAt(0))) {
                        TreeMap <String, Integer> wordCount = new TreeMap<>(); 
                        wordCount.put(word, 1);
                        Character ch = word.charAt(0);
                        wordOrder.put(ch, wordCount);
                    }
                    else if (!word.isEmpty() && wordOrder.containsKey(word.charAt(0))) {
                        TreeMap<String, Integer> wordCountMap = wordOrder.get(word.charAt(0));
                        if (!wordCountMap.containsKey(word)) {
                            wordCountMap.put(word, 1);
                        }
                        else{
                            wordCountMap.put(word, wordCountMap.get(word) + 1);
                        }
                    }
                }
            }
            System.out.println(wordOrder); //print which char in one line
        } catch (IOException e) {
            System.out.println("File not found");
            e.printStackTrace();
        }
    }
}
