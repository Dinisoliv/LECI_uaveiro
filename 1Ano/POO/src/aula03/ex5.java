package aula03;

import java.util.Scanner;

public class ex5 {
    public static final Scanner sc = new Scanner(System.in);
    public static void main(String[] args) {
        String date;
        String [] dateParts;
        int month, year;
        int dayOfWeek;

        date = readDate();
        dateParts = date.split("/");
        month = Integer.parseInt(dateParts[0]);
        year = Integer.parseInt(dateParts[1]);
        dayOfWeek = readDayOfWeek();

        printCalendar(month, year, dayOfWeek);

    }

    static String readDate(){
        String date;

        do {
            System.out.print("Digite uma data (mm/yyyy): ");
            date = sc.nextLine();
        } while (!validateDate(date));

        return date;
    } 

    static boolean validateDate(String date){
        return date.matches("^(0[1-9]|1[0-2])/(\\d{4})$");      
    }

    static int readDayOfWeek(){
        int dayOfWeek;
        
        do {
            System.out.print("Digite o 1º dia da semana: ");
            dayOfWeek = sc.nextInt();
        } while (dayOfWeek < 1 || dayOfWeek > 7);
        
        return dayOfWeek;
    }

    static void printCalendar(int month, int year, int dayOfWeek){
        System.out.println(getMonthName(month) + " " + year);
        System.out.println("Su Mo Tu We Th Fr Sa");
        
        int[] positionDays = new int[6+31];
        int daysOfMonth = lastMonthDay(month, year);

        if (dayOfWeek == 7) {
            for (int i = 1; i <= daysOfMonth; i++) {
                positionDays[i - 1] = i;
            }
        } else {
            for (int i = 0; i < daysOfMonth; i++) {
                positionDays[i + dayOfWeek] = i + 1;
            }
        }
        for (int i = 0; i < positionDays.length; i++) {
            if (i > 28 && positionDays[i] == 0) {
                System.out.println();
                break;
            }
            if (positionDays[i] == 0) {
                System.out.print("   ");
            }
            else{
            System.out.printf("%2d ", positionDays[i]);
            }
            if ((i + 1) % 7 == 0) {
                System.out.println();
            }
        }
    }

    static int lastMonthDay(int month, int year){
        
        int[] daysOfMonths = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        
        if (month == 2 && leapYear(year)) {
            return 29;
        } else {
            return daysOfMonths[month];
        }
    }

    static boolean leapYear(int year){
        return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;
    }

    static String getMonthName(int month){
        String[] monthName = {"", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
        return monthName[month];
    }
}