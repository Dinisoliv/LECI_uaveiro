import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class e1_2_2 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Map<String, Double> vars = new HashMap<>();

        while (scanner.hasNextLine()) {

            String line = scanner.nextLine().trim();
            if (line.isEmpty()) continue;

            Scanner tokens = new Scanner(line);

            String operator = null;
            String currentVar = null;
            String lastToken = null;
            Double leftValue = null;
            boolean seenEquals = false;

            while (tokens.hasNext()) {
                String token = tokens.next();

                if (token.equals("=")) {
                    currentVar = lastToken;
                    seenEquals = true;
                    continue;
                }

                if (token.equals("+") || token.equals("-") ||
                    token.equals("*") || token.equals("/")) {
                    operator = token;
                    continue;
                }

                Double value = null;
                try {
                    value = Double.parseDouble(token);
                } catch (NumberFormatException e) {

                    // identifier
                    if (!seenEquals && currentVar == null && lastToken == null) {
                        // first identifier before '=' → LHS (allowed to be new)
                        lastToken = token;
                        continue;
                    }

                    if (!vars.containsKey(token)) {
                        tokens.close();
                        scanner.close();
                        throw new RuntimeException("Undefined variable: " + token);
                    }

                    value = vars.get(token);
                }

                if (leftValue == null) {
                    leftValue = value;
                } else {
                    switch (operator) {
                        case "+": leftValue += value; break;
                        case "-": leftValue -= value; break;
                        case "*": leftValue *= value; break;
                        case "/": leftValue /= value; break;
                        default:
                            throw new RuntimeException("Invalid operator");
                    }
                    operator = null;
                }

                lastToken = token;
            }

            // commit result
            if (currentVar != null) {
                vars.put(currentVar, leftValue);
            } else if (leftValue != null) {
                System.out.println(leftValue);
            }

            tokens.close();
        }

        scanner.close();
    }
}
