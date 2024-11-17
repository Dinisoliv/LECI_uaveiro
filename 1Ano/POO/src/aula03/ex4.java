package aula03;

import java.util.Scanner;

public class ex4 {
    public static void main(String[] args) {
        int students, grade;
        double pratic, teoric;

        Scanner sc = new Scanner(System.in);
        System.out.print("Número de alunos na turma: ");
        students = sc.nextInt();

        int[] gradesList = new int[students];
        double[][] componentsList = new double[students][2];

        System.out.println("Insira as notas dos alunos");

        for (int i = 0; i < students; i++) {
            System.out.print("Nota Componente Teórica: ");
            teoric = sc.nextDouble();
            componentsList[i][0] = teoric;
            if (teoric < 0 || teoric > 20) {
                System.out.println("Nota entre 0 e 20!");
                continue;
            }

            System.out.print("Nota Componente Prática: ");
            pratic = sc.nextDouble();
            componentsList[i][1] = pratic;
            if (pratic < 0 || pratic > 20) {
                System.out.println("Nota entre 0 e 20!");
                continue;
            }

            if ((teoric < 7.0) || (pratic < 7.0)) {
                grade = 66;
            }
            else{
                grade = (int) (teoric * 0.4 + pratic * 0.6);
            }

            gradesList[i] = grade;
        }
        sc.close();
        
        //Print results
        //check again
        System.out.printf("%-10s%-10s%-10s%n", "NotasT", "NotasP", "Pauta");
        for (int i = 0; i < students; i++) {
            String formatedRow = String.format("%6.1f%10.1f%9d", 
            componentsList[i][0], componentsList[i][1], gradesList[i]);
            System.out.println(formatedRow);
        }
    }
}













//("%-15s%-10d%-15.2f", names[i], ages[i], salaries[i]);

/*
public class LeftAlignedTable {
    public static void main(String[] args) {
        // Example data
        String[] names = {"John", "Alice", "Bob"};
        int[] ages = {25, 30, 28};
        double[] salaries = {50000.75, 75000.50, 60000.25};

        // Print table header
        System.out.printf("%-15s%-10s%-15s%n", "Name", "Age", "Salary");

        // Print table rows
        for (int i = 0; i < names.length; i++) {
            String formattedRow = String.format("%-15s%-10d%-15.2f", names[i], ages[i], salaries[i]);
            System.out.println(formattedRow);
        }
    }
}
 */



/*
package aula03;

import java.util.Scanner;

public class ex4 {
    public static void main(String[] args) {
        int students, grade;
        double pratic, teoric;

        Scanner sc = new Scanner(System.in);
        System.out.print("Número de alunos na turma: ");
        students = sc.nextInt();

        int[] gradesList = new int[students];
        double[][] componentsList = new double[students][2];

        System.out.println("Insira as notas dos alunos");

        for (int i = 0; i < students; i++) {
            System.out.print("Nota Componente Teórica: ");
            teoric = sc.nextDouble();
            componentsList[i][0] = teoric;

            System.out.print("Nota Componente Prática: ");
            pratic = sc.nextDouble();
            componentsList[i][1] = pratic;

            if ((teoric < 7.0) || (pratic < 7.0)) {
                grade = 66;
            }
            else{
                grade = (int) (teoric * 0.4 + pratic * 0.6);
            }

            gradesList[i] = grade;
        }
        sc.close();
        
        //Print results
        //check again
        System.out.printf("%-10s%-10s%-10s%n", "NotasT", "NotasP", "Pauta");
        for (int i = 0; i < students; i++) {
            String formatedRow = String.format("%.1f%-6s%.1f%-6s%d", 
            componentsList[i][0], "",componentsList[i][1], "",gradesList[i]);
            System.out.println(formatedRow);
        }
    }
}

//("%-15s%-10d%-15.2f", names[i], ages[i], salaries[i]);

/*
public class LeftAlignedTable {
    public static void main(String[] args) {
        // Example data
        String[] names = {"John", "Alice", "Bob"};
        int[] ages = {25, 30, 28};
        double[] salaries = {50000.75, 75000.50, 60000.25};

        // Print table header
        System.out.printf("%-15s%-10s%-15s%n", "Name", "Age", "Salary");

        // Print table rows
        for (int i = 0; i < names.length; i++) {
            String formattedRow = String.format("%-15s%-10d%-15.2f", names[i], ages[i], salaries[i]);
            System.out.println(formattedRow);
        }
    }
}
 */
