package APFinal;

public class Ticket {
    private Event event;
    private int numberOfTicket;
    private static int nextId = 1;
    private int id;

    public Ticket(Event event, int numberOfTicket) {
        this.event = event;
        this.numberOfTicket = numberOfTicket;
        this.id = nextId;
        nextId++;
    }

    public Event getEvent() {
        return event;
    }

    public int getNumberOfTicket() {
        return numberOfTicket;
    }

    public int getId() {
        return id;
    }

    public void setNumberOfTicket(int numberOfTicket) {
        this.numberOfTicket = numberOfTicket;
    }

    

    

    
}
