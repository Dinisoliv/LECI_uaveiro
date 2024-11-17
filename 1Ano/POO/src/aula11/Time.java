package aula11;

public class Time {
    private int minutes;
    private int hours;
    private String time;

    public Time(int minutes, int hours){
        if (minutes >= 0 && minutes <= 60 && hours >= 0 && hours <= 24) {
            this.time = hours + ":" + minutes;
        }
    }

    public int getMinutes() {
        return minutes;
    }

    public int getHours() {
        return hours;
    }

    public String getTime() {
        return time;
    }

    public String toString(){
        return time;
    }
}
