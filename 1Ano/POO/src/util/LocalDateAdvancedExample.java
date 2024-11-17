package util;

import java.time.LocalDate;
import java.time.DayOfWeek;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.time.Period;

public class LocalDateAdvancedExample {
    public static void main(String[] args) {
        // Current date
        LocalDate currentDate = LocalDate.now();
        System.out.println("Current Date: " + currentDate);

        // Specific date
        LocalDate specificDate = LocalDate.of(2024, 7, 8);
        System.out.println("Specific Date: " + specificDate);

        // Parse date from string
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        LocalDate parsedDate = LocalDate.parse("08/07/2024", formatter);
        System.out.println("Parsed Date: " + parsedDate);

        // Custom formatted date
        String formattedDate = currentDate.format(formatter);
        System.out.println("Formatted Date: " + formattedDate);

        // Date with specific fields
        LocalDate dateWithYear = currentDate.withYear(2025);
        System.out.println("Date with Year 2025: " + dateWithYear);

        // Temporal adjusters
        LocalDate firstDayOfMonth = currentDate.with(TemporalAdjusters.firstDayOfMonth());
        LocalDate lastDayOfMonth = currentDate.with(TemporalAdjusters.lastDayOfMonth());
        LocalDate nextSunday = currentDate.with(TemporalAdjusters.next(DayOfWeek.SUNDAY));
        System.out.println("First Day of Month: " + firstDayOfMonth);
        System.out.println("Last Day of Month: " + lastDayOfMonth);
        System.out.println("Next Sunday: " + nextSunday);

        // Leap year check
        boolean isLeapYear = currentDate.isLeapYear();
        System.out.println("Is Leap Year: " + isLeapYear);

        // Length of month and year
        int lengthOfMonth = currentDate.lengthOfMonth();
        int lengthOfYear = currentDate.lengthOfYear();
        System.out.println("Length of Month: " + lengthOfMonth);
        System.out.println("Length of Year: " + lengthOfYear);

        // Period between dates
        LocalDate birthDate = LocalDate.of(1990, 7, 8);
        Period period = Period.between(birthDate, currentDate);
        System.out.println("Years: " + period.getYears());
        System.out.println("Months: " + period.getMonths());
        System.out.println("Days: " + period.getDays());
    }
}

