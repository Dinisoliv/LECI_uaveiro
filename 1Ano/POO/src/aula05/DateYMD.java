package aula05;

public class DateYMD extends Date implements Comparable<DateYMD>{
    private int day;
    private int month;
    private int year;

    public DateYMD(int day, int month, int year){
        if (valid(day, month, year)) {
            this.day = day;
            this.month = month;
            this.year = year;
        }
        else{
            throw new IllegalArgumentException("Invalid date");
        }
    }

    public void set(int day, int month, int year){
        if (valid(day, month, year)) {
            this.day = day;
            this.month = month;
            this.year = year;
        }
        else{
            throw new IllegalArgumentException("Invalid date");
        }
    }

    public int getDay(){
        return day;
    }

    public int getMonth(){
        return month;
    }

    public int getYear(){
        return year;
    }

    public boolean validMonth(int month){
        return (month > 0 && month < 12); 
    }

    public int monthDays(int month, int year){
        int[] daysOfMonth = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        if (leapYear(year) && month == 2) {
            return 29;
        }
        else{   
            return daysOfMonth[month];
        }
    }

    public boolean leapYear(int year){
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    }

    public boolean valid(int day, int month, int year){
        if (year < 1) {
            return false;
        }
        if (month < 1 || month > 12){
            return false;
        }
        if (monthDays(month, year) < day || day < 1){
            return false;
        }
        return true;
    }

    public void increment(){
        day++;
        if (day > monthDays(month, year)) {
            day = 1;
            month++;
            if (month > 12) {
                month = 1;
                year++;
            }
        }
    }

    public void decrement(){
        day--;
        if (day < 1) {
            month--;
            if (month < 1) {
                month = 12;
                year--;
            }
            day = monthDays(month, year);
        }
    }
    
    @Override public String toString(){
        return String.format("%04d-%02d-%02d", year, month, day);
    }

    @Override
    public boolean equals(Object obj){
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        DateYMD date = (DateYMD) obj;

        if (day != date.day || month != date.month || year != date.year) {
            return false;    
        }
        return true;
    }

    public int compareTo(DateYMD other) {
        // Compare years
        int yearComparison = Integer.compare(this.year, other.year);
        if (yearComparison != 0) {
            return yearComparison;
        }
        // Compare months
        int monthComparison = Integer.compare(this.month, other.month);
        if (monthComparison != 0) {
            return monthComparison;
        }
        // Compare days
        return Integer.compare(this.day, other.day);
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + day;
        result = prime * result + month;
        result = prime * result + year;
        return result;
    }
}
