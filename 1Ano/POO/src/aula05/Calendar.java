package aula05;

public class Calendar {
    private int[][] events;
    private int year;
    private int firstDayOfYear;
    
    public Calendar(int year, int firstDayOfYear){
        this.year = year;
        this.firstDayOfYear = firstDayOfYear;
        this.events = new int[12][];
        for (int i = 0; i < 12; i++) {
            this.events[i] = new int [monthDays(i+1, year)];
        }
    }

    public int getYear(){
        return year;
    }

    public int getfirstDayOfYear(){
        return firstDayOfYear;
    }

    public int firstWeekdayOfMonth(int month){
        int daysPassed = 0;
        for (int i = 1; i < month; i++) {
            daysPassed += monthDays(i, year);
        }
        return (daysPassed + firstDayOfYear) % 7;
    }

    public void addEvent(DateYMD date){
        int month = date.getMonth();
        int day = date.getDay();
        events[month-1][day-1]++;        
    }

    public void removeEvent(DateYMD date){
        int month = date.getMonth();
        int day = date.getDay();
        if (events[month-1][day-1] > 0) {
            events[month-1][day-1]--; 
        }
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

    public static String getMonthName(int month){
        String[] monthName = {"", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
        return monthName[month];
    }

    public String printMonth(int month){
        StringBuilder calendar = new StringBuilder();
        calendar.append(getMonthName(month) + " " + year);
        calendar.append("\nSu  Mo  Tu  We  Th  Fr  Sa\n");

        int firstDayOfWeek = firstWeekdayOfMonth(month);
        for (int i = 0; i < firstDayOfWeek; i++) {
            calendar.append("    ");
        }

        int numDays = monthDays(month, year);
        for (int i = 1; i <= numDays; i++) {
            if (events[month-1][i-1] > 0) {
                if (i < 10) {
                    calendar.append(String.format("*%d  ", i));
                }
                else{
                    calendar.append(String.format("*%d ", i));
                }
            }
            else{
                calendar.append(String.format("%2d  ", i));
            }
            if ((firstDayOfWeek + i) % 7 == 0) {
                calendar.append("\n");
            }
        }
        return calendar.toString(); 
    }
    public String toString(){
        StringBuilder yearCalendar = new StringBuilder();
        for (int i = 1; i <= 12; i++) {
            yearCalendar.append(printMonth(i));
            yearCalendar.append("\n");
        }
        return yearCalendar.toString();
    }
}
