package aula11;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.TreeMap;
import java.util.Scanner;

public class Ex1 {
    public static void main(String[] args) {
        String inputFileName = "major.txt";
        String outputFileName = "output.txt";

        TreeMap<String, HashMap<String, Integer>> wordPairs = new TreeMap<>();

        try {
            File myObj = new File(inputFileName);
            Scanner myReader = new Scanner(myObj);

            while (myReader.hasNextLine()) {
                String data = myReader.nextLine();
                String[] lineWords = data.split("[\\t\\n.,:'‘’;?!-*{}=+&/()\\[\\]\"”“\\\\\\s]+"); //regex for text separation

                for (int i = 0; i < lineWords.length - 1; i++) { 
                    String word1 = lineWords[i].toLowerCase();
                    String word2 = lineWords[i + 1].toLowerCase();

                    if (word1.length() > 3 && word2.length() > 3) {
                        wordPairs.putIfAbsent(word1, new HashMap<>());  //add word that matches
                        HashMap<String, Integer> pairOfWord = wordPairs.get(word1);
                        pairOfWord.put(word2, pairOfWord.getOrDefault(word2, 0) + 1); //add num of repetitions
                    }
                }
            }
            myReader.close();
        } catch (FileNotFoundException e) {
            System.out.println("File not found");
            e.printStackTrace();
        }

        try {
            FileWriter myWriter = new FileWriter(outputFileName);
            for (String word : wordPairs.keySet()) { //write to the file
                myWriter.write(word + "={");
                HashMap<String, Integer> pairs = wordPairs.get(word);
                int count = 0;
                for (String pair : pairs.keySet()) {
                    myWriter.write(pair + "=" + pairs.get(pair));
                    count++;
                    if (count < pairs.size()) {
                        myWriter.write(", ");
                    }
                }
                myWriter.write("}\n");
            }
            myWriter.close();
            System.out.println("Successfully wrote to the file.");
        } catch (IOException e) {
            System.out.println("An error occurred.");
            e.printStackTrace();
        }
    }
}
