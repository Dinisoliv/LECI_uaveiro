import java.io.File;
import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.Scanner;

public class e1_4 {
    public static void main(String[] args) {
        HashMap <String, String> numbersMap = new HashMap<>();

        try (Scanner fileScanner = new Scanner(new File("numbers.txt"));){
            while (fileScanner.hasNext()) {
                    String value = fileScanner.next();
                    fileScanner.next(); // skip the hyphen "-"
                    String name = fileScanner.next().toLowerCase();
                    numbersMap.put(name, value);
            }
            
        } catch (FileNotFoundException e) {
            System.err.println("Error: numbers.txt not found.");
            return;
        }        
        
        Scanner inputScanner = new Scanner(System.in);

        while (inputScanner.hasNext()) {
            String word = inputScanner.next().toLowerCase().replaceAll("[^a-z]", "");

            if (numbersMap.containsKey(word)) {
                System.out.print(numbersMap.get(word));
            }else{
                System.out.print(word);
            }

            System.out.print(" ");
        }
        System.out.println();
        inputScanner.close();
    }
}
