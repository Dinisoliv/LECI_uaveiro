package util;

import java.time.LocalDate;
import java.time.DayOfWeek;
import java.time.temporal.ChronoUnit;

public class LocalDateExample {
    public static void main(String[] args) {
        // Current date
        LocalDate currentDate = LocalDate.now();
        System.out.println("Current Date: " + currentDate);

        // Specific date
        LocalDate specificDate = LocalDate.of(2024, 7, 8);
        System.out.println("Specific Date: " + specificDate);

        // Parse date from string
        LocalDate parsedDate = LocalDate.parse("2024-07-08");
        System.out.println("Parsed Date: " + parsedDate);

        // Get date information
        int year = currentDate.getYear();
        int month = currentDate.getMonthValue();
        int day = currentDate.getDayOfMonth();
        DayOfWeek dayOfWeek = currentDate.getDayOfWeek();
        System.out.println("Year: " + year);
        System.out.println("Month: " + month);
        System.out.println("Day: " + day);
        System.out.println("Day of Week: " + dayOfWeek);

        // Modify dates
        LocalDate tomorrow = currentDate.plusDays(1);
        LocalDate nextMonth = currentDate.plusMonths(1);
        LocalDate nextYear = currentDate.plusYears(1);
        LocalDate previousDay = currentDate.minusDays(1);
        LocalDate previousMonth = currentDate.minusMonths(1);
        LocalDate previousYear = currentDate.minusYears(1);
        System.out.println("Tomorrow: " + tomorrow);
        System.out.println("Next Month: " + nextMonth);
        System.out.println("Next Year: " + nextYear);
        System.out.println("Previous Day: " + previousDay);
        System.out.println("Previous Month: " + previousMonth);
        System.out.println("Previous Year: " + previousYear);

        // Compare dates
        LocalDate date1 = LocalDate.of(2024, 7, 8);
        LocalDate date2 = LocalDate.now();
        boolean isBefore = date1.isBefore(date2);
        boolean isAfter = date1.isAfter(date2);
        boolean isEqual = date1.isEqual(date2);
        System.out.println("Is date1 before date2? " + isBefore);
        System.out.println("Is date1 after date2? " + isAfter);
        System.out.println("Is date1 equal to date2? " + isEqual);

        // Date calculations
        LocalDate startDate = LocalDate.of(2024, 1, 1);
        LocalDate endDate = LocalDate.of(2024, 7, 8);
        long daysBetween = ChronoUnit.DAYS.between(startDate, endDate);
        System.out.println("Days between: " + daysBetween);
    }
}
