package APFinal;
import java.util.Collection;

public interface ITicketBookingSystem {
    boolean addEventOccurrence(Event event, Place place, String schedule); // registers an event occurring at a place and time
                                                                            // returns false if another event occurs at same place and time
    int bookTickets(int eventId, int numTickets);   // returns the ticket reference; returns -1 if number of tickets is not available
    boolean cancelTickets(int ticketReference);     // returns false if ticket reference is not found
    Collection<EventOccurrence> getEventOccurrences();
}
