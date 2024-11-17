package aula05;

import java.util.Scanner;

public class Ex01 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int choice = -1;
        DateYMD date = null;
        int day = 0, month = 0, year = 0; 

        while (choice != 0) {
            System.out.println("\nDate operations:");
            System.out.println("1 - create new date");
            System.out.println("2 - show current date");
            System.out.println("3 - increment date");
            System.out.println("4 - decrement date");
            System.out.println("0 - exit");
            
            choice = sc.nextInt();
            
            //if (choice > 4 || choice < 0) {
                //System.out.println("Invalid Number");
                //continue;
            //}
            switch (choice) {
                case 1:
                    System.out.println("Day: ");
                    day = sc.nextInt();
                    System.out.println("Month: ");
                    month = sc.nextInt();
                    System.out.println("Year: ");
                    year = sc.nextInt();
                    date = new DateYMD(day, month, year);
                    //define exception or assert or while?
                    break;
                case 2:
                    if (date != null) {
                        System.out.println("Current date: " + date.toString());
                    }
                    else{
                        System.out.println("No date set yet");
                    }
                    break;
                case 3:
                    if (date == null) {
                        System.out.println("No date set yet");
                    }
                    else{
                      date.increment();
                      System.out.println("Date incremented");
                    }
                    break;
                case 4:
                    if (date == null) {
                        System.out.println("No date set yet");
                    }
                    else{
                        date.decrement();
                        System.out.println("Date decremented");
                    }
                    break;
                case 0:
                    System.out.println("Exiting Program");
                    break;
                default:
                    System.out.println("Invalid choice. Please try again.");
             }
        }
    sc.close();
    }
}
