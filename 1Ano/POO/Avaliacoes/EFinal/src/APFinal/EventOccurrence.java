package APFinal;

import java.time.LocalDateTime;

public class EventOccurrence {
    private LocalDateTime dateHour;
    private Place place;
    private Event event;
    private int EventId;
    private int nextId;

    public EventOccurrence(LocalDateTime dateHour, Place place, Event event) {
        this.dateHour = dateHour;
        this.place = place;
        this.event = event;
        this.EventId = nextId++;
        event.getTicket().setNumberOfTicket(place.getCapacity());
    }

    
    public LocalDateTime getDateHour() {
        return dateHour;
    }


    public Place getPlace() {
        return place;
    }


    public Event getEvent() {
        return event;
    }

    public int getEventId() {
        return EventId;
    }


    public void setNextId(int nextId) {
        this.nextId = nextId;
    }


    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((dateHour == null) ? 0 : dateHour.hashCode());
        result = prime * result + ((place == null) ? 0 : place.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
            EventOccurrence other = (EventOccurrence) obj;
        if (place == null) {
                if (other.place != null)
                    return false;
            } else if (!place.equals(other.place))
                return false;
        if (dateHour == null) {
            if (other.dateHour != null)
                return false;
        } else if (!dateHour.equals(other.dateHour))
            return false;
        return true;
    }

    


}
