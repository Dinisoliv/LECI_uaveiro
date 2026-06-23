import java.util.Scanner;


class e1_1{
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Operation (number op number): ");

        double number1 = scanner.nextDouble();
        String op = scanner.next();
        double number2 = scanner.nextDouble();

        double result = 0.0;

        switch (op) {
            case "+":
                result = number1 + number2;
                break;
            case "-":
                result = number1 - number2;
                break;
            case "/":
                result = number1 / number2;
                break;
            case "*":
                result = number1 * number2;
                break;
            default:
                System.err.println("Invalid operator");
                scanner.close();
                return;
        }

        System.out.println(result);

        scanner.close();
    }
}