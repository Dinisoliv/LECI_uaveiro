import java.util.*;

public class ExpressionTree {
    private Node root;

    // Classe Node estática para evitar erros de instância
    private static class Node {
        String value;
        Node left, right;

        Node(String value) {
            this.value = value;
        }

        boolean isOperator() {
            return value.equals("+") || value.equals("-") || value.equals("*") || value.equals("/");
        }
    }

    public ExpressionTree(Scanner in) {
        try {
            this.root = createPrefix(in);
            // Removido o check de 'hasNext' aqui se quiser ler apenas uma expressão por linha
        } catch (NoSuchElementException e) {
            throw new RuntimeException("Erro: Expressão incompleta.");
        }
    }

    private Node createPrefix(Scanner in) {
        if (!in.hasNext()) throw new NoSuchElementException();

        if (in.hasNextDouble()) {
            return new Node(in.next());
        } else {
            String op = in.next();
            if (!isOperator(op)) throw new RuntimeException("Operador inválido: " + op);

            Node node = new Node(op);
            node.left = createPrefix(in);  
            node.right = createPrefix(in); 
            return node;
        }
    }

    private boolean isOperator(String s) {
        return "+-*/".contains(s) && s.length() == 1;
    }

    public void printInfix() {
        printInfix(root);
        System.out.println();
    }

    private void printInfix(Node n) {
        if (n == null) return;
        if (n.isOperator()) System.out.print("("); // Corrigido de println para print

        printInfix(n.left);
        System.out.print(" " + n.value + " ");
        printInfix(n.right);
        
        if (n.isOperator()) System.out.print(")");
    }

    public double eval() {
        return eval(root);
    }

    private double eval(Node n) {
        if (!n.isOperator()) return Double.parseDouble(n.value);

        double leftVal = eval(n.left);
        double rightVal = eval(n.right);

        switch (n.value) {
            case "+": return leftVal + rightVal;
            case "-": return leftVal - rightVal;
            case "*": return leftVal * rightVal;
            case "/": 
                if (rightVal == 0) throw new ArithmeticException("Divisão por zero!");
                return leftVal / rightVal;
            default: return 0;
        }
    }

    // O método main DEVE estar dentro da classe pública
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("Introduza a expressão prefixa (ex: + 2 * 3 4):");

        try {
            ExpressionTree tree = new ExpressionTree(sc);
            System.out.print("Infixa: ");
            tree.printInfix();
            System.out.println("Resultado: " + tree.eval());
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }
}