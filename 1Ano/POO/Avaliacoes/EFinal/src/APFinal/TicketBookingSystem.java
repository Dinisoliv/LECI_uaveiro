package APFinal;

import java.util.List;
import java.time.LocalDateTime;
import java.util.ArrayList;

public class TicketBookingSystem implements ITicketBookingSystem {
    private List<EventOccurrence> eventOccurrences;

    public TicketBookingSystem() {
        this.eventOccurrences = new ArrayList<>();
    }

    @Override
    public boolean addEventOccurrence(Event event, Place place, String schedule) {
        String[] partsShecule = schedule.split(" ");
        String[] partsDate = partsShecule[0].split("-");
        String[] partsHour = partsShecule[1].split(":");


        try {
            int year = Integer.parseInt(partsDate[0]);
            int month = Integer.parseInt(partsDate[1]);
            int day = Integer.parseInt(partsDate[2]);

            int hour = Integer.parseInt(partsHour[0]);
            int minutes = Integer.parseInt(partsHour[1]);

            LocalDateTime date = LocalDateTime.of(year, month, day, hour, minutes);

            EventOccurrence eventOccurrence = new EventOccurrence(date, place, event);

            if (eventOccurrences.contains(eventOccurrence)) {
                return false;
            }
            eventOccurrences.add(eventOccurrence);
            return true;

        } catch (NumberFormatException e) {
            System.out.println("Invalid date");
            return false;
        }
    }

    @Override
    public int bookTickets(int eventId, int numTickets) {
        for (EventOccurrence eventOccurrence : eventOccurrences) {
            if (eventOccurrence.getEventId() == eventId) {
                int availableTickets = eventOccurrence.getEvent().getTicket().getNumberOfTicket();
                int newNumTickets = availableTickets - numTickets;
                eventOccurrence.getEvent().getTicket().setNumberOfTicket(newNumTickets);
                return eventOccurrence.getEvent().getTicket().getId();
            }
        }
        return -1;
    }

    @Override
    public List<EventOccurrence> getEventOccurrences() {
        return eventOccurrences;
    }
    
    @Override
    public boolean cancelTickets(int ticketReference) {
        for (EventOccurrence eventOccurrence : eventOccurrences) {
            if (eventOccurrence.getEvent().getTicket().getId() == ticketReference) {
                int availableTickets = eventOccurrence.getEvent().getTicket().getNumberOfTicket();
                int newNumTickets = availableTickets + 1;
                eventOccurrence.getEvent().getTicket().setNumberOfTicket(newNumTickets);
                return true;
            }
        }
        return false;
    }

}
