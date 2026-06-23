import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class e1_2 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Map<String, Double> vars = new HashMap<>();

        while (scanner.hasNextLine()) {

            String line = scanner.nextLine().trim();
            if (line.isEmpty()) continue;

            Scanner tokens = new Scanner(line);

            String operator = null;
            String currentVar = null;
            Double leftValue = null;
            boolean validVariable = true;
            boolean assigning = false;

            while (tokens.hasNext()) {
                String token = tokens.next();

                if (token.equals("=")) {
                    currentVar = token;
                    assigning = true;
                    continue;
                }
                
                if (token.equals("+") || token.equals("-") ||
                    token.equals("*") || token.equals("/")) {
                    operator = token;
                    continue;
                }

                Double value = null;
                if (tokens.hasNextDouble()){
                    value = Double.parseDouble(token);
                } else {
                    if (vars.containsKey(token)) {
                        value = vars.get(token);
                        validVariable = true;
                    }
                    else{
                        validVariable = false;
                    }
                }

                if (leftValue == null) {
                    leftValue = value;
                } else if (operator != null){
                    double result;
                    switch (operator) {
                        case "+": result = leftValue + value; break;
                        case "-": result = leftValue - value; break;
                        case "*": result = leftValue * value; break;
                        case "/": result = leftValue / value; break;
                        default:
                            throw new RuntimeException("Invalid operatoration");
                    }
                    leftValue = result;
                    operator = null;
                }
            }

            // end of line → commit result
            if (leftValue != null) {
                if (currentVar != null) {
                    vars.put(currentVar, leftValue);
                    System.out.println("assigned");
                } else {
                    System.out.println(leftValue);
                }
            }

            tokens.close();
        }

        scanner.close();
    }
}
