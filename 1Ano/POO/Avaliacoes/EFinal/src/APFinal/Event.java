package APFinal;

public class Event {
    private String name;
    private int duration; // in minutes
    private Ticket ticket;
    //private typeEvent type;

    public Event(String name, int duration) {
        this.name = name;
        this.duration = duration;
        ticket = new Ticket(this, 0);
    }

    public String getName() {
        return name;
    }
    public int getDuration() {
        return duration;
    }

    public Ticket getTicket() {
        return ticket;
    } 



    @Override
    public String toString() {
        return "name=" + name + ", duration=" + duration ;
    }
}
