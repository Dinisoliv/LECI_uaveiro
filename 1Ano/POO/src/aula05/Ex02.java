package aula05;

import java.util.Scanner;

public class Ex02 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        Calendar calendar = null;
        int year = 0; 

        int choice; 
        do {
            System.out.println("Calendar operations:");
            System.out.println("1 - create new calendar");
            System.out.println("2 - print calendar month");
            System.out.println("3 - print calendar");
            System.err.println("4 - add a event");
            System.out.println("5 - remove a event");
            System.out.println("0 - exit");

            choice = sc.nextInt();

            switch (choice) {
                case 1:
                    System.out.println("Enter the year:");
                    year = sc.nextInt();
                    System.out.println("Enter the first weekday of the year (1-Sunday, 2-Monday, ..., 7-Saturday):");
                    int firstDayOfYear = sc.nextInt();
                    calendar = new Calendar(year, firstDayOfYear);
                    break;
                case 2:
                    if (calendar == null) {
                        System.out.println("Calendar not created yet");
                        break;
                    }
                    else{
                        System.out.println("Enter month: ");
                        int month = sc.nextInt();
                        System.out.println(calendar.printMonth(month));
                    }
                    break;
                case 3:
                    if (calendar == null) {
                        System.out.println("Calendar not created yet");
                        break;
                    }
                    else{
                        System.out.println(calendar);
                    }
                    break;
                case 4:
                    if (calendar == null) {
                        System.out.println("Calendar not created yet");
                        break;
                    }
                    else{
                        System.out.println("Add event");
                        System.out.print("Day: ");
                        int dayOfEvent = sc.nextInt();
                        System.out.println("Month"); 
                        int monthOfEvent = sc.nextInt();
                        DateYMD date = new DateYMD(dayOfEvent, monthOfEvent, year);
                        calendar.addEvent(date);
                    }
                    break;
                case 5:
                    if (calendar == null) {
                        System.out.println("Calendar not created yet");
                        break;
                    }
                    System.out.println("Remove event");
                    System.out.print("Day: ");
                    int dayOfEvent = sc.nextInt();
                    System.out.println("Month"); 
                    int monthOfEvent = sc.nextInt();
                    DateYMD date = new DateYMD(dayOfEvent, monthOfEvent, year);
                    calendar.removeEvent(date);
                    break;
                default:
                    if (choice != 0) {
                        System.out.println("Invalid choice. Please enter again.");
                    }
                    break;
            }
        } while (choice != 0);
        sc.close();        
    }
}
