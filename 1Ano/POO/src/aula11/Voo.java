package aula11;

public class Voo {
    private String id;
    private String airLine;
    private String origin;
    private Time time;
    private Time delay;
    private Time newTime;

    public Voo(String id, String airLine, String origin, Time time, Time delay) {
        this.id = id;
        this.airLine = airLine;
        this.origin = origin;
        this.time = time;
        this.delay = delay;
        this.newTime = new Time(time.getMinutes() + delay.getMinutes(), time.getHours() + delay.getHours());
    }

    public Voo(String id, String airLine, String origin, Time time){
        this.id = id;
        this.airLine = airLine;
        this.origin = origin;
        this.time = time;
    }
    
    public void changeDelay(Time newDelay) {
        this.delay = newDelay;
        this.newTime = new Time(time.getMinutes() + newDelay.getMinutes(), time.getHours() + newDelay.getHours());
    }

    public String getId() {
        return id;
    }

    public String getAirLine() {
        return airLine;
    }

    public String getOrigin() {
        return origin;
    }

    public Time getTime() {
        return time;
    }

    public Time getDelay() {
        return delay;
    }

    public Time getNewTime() {
        return newTime;
    }

    public String toString() {
        return String.format("%-10s%-15s%-20s%-25s%-15s%-20s", time, id, airLine, origin, delay, newTime);
    }

    
}
