package APFinal;
// Notes:
// Não altere o código apresentado *** Do not change the code shown
// Deve apenas completar o código de exercise2, onde indicado *** You should only change the code where indicated in exercise2
// Deve comentar o código para garantir que vai executando parcialmente *** You may comment the code to test and execute partially

import java.io.FileNotFoundException;
import java.io.PrintStream;
import java.io.File;

public class TicketBookingApp {

	// DO NOT CHANGE THIS METHOD
	public static void main(String[] args) throws FileNotFoundException {
		PrintStream fl = new PrintStream(new File("POO_2324EPn.txt"));

		// exercise 1
		// you may comment these lines when working on exercise 2
		exercise1(System.out);	// executa e escreve na consola *** executes and writes to console 
		exercise1(fl); 			// executa e escreve no ficheiro *** executes and writes to file

		// exercise 2
		// you may comment these lines when working on exercise 1
		exercise2(System.out);	// executa e escreve na consola *** executes and writes to console 
		exercise2(fl);			// executa e escreve no ficheiro *** executes and writes to file

		fl.close();
	}

	// DO NOT CHANGE THIS METHOD
	// CREATE THE CLASS DEFINITIONS ACCORDING TO THE DESCRIPTION IN THE EXAM AND THE CODE BELOW
	private static void exercise1(PrintStream out) {
		out.println("\nAlínea 1) ----------------------------------\n");

        // Creating some places
        Place[] places = {
            new Place("Riverside Theatre", 100),
            new Place("City Lights Cinema", 150),
            new Place("Central Park Bandshell", 200),
            new Place("The Black Box", 70)
        };

        // Creating some events
        Event[] events = {
            new Concert("Thunderous", "Neon Pulse Tour", 90),
            new Concert("Esperanza Spalding", "A Tribute to Nina Simone", 75),
            new Theatre("The Importance of Being Earnest", "Oscar Wilde", "Grand Theatre Company", 150),
            new Theatre("The Ballad of Black Bart", "Maria Hernandez", "Riverbank Community Players", 90),
            new Cinema("The Maltese Falcon", "John Huston", 1941, new String[]{"Humphrey Bogart", "Mary Astor", "Peter Lorre"}, 100),
            new Cinema("The Invisible Thread", "David Choi", 2023, new String[]{"Elena Alvarez", "Daniel Park", "Thomas Wright"}, 90)         
        };

        // Creating some dates for events
        String[] dates = {"2024-06-14 18:30", "2024-06-10 20:15", "2024-06-22 19:30", "2024-06-19 21:00", "2024-06-20 18:45", "2024-06-11 22:00", "2024-06-23 19:30", "2024-06-28 18:30", "2024-06-12 20:45", "2024-06-17 19:00", "2024-06-25 21:15", "2024-06-29 18:00"};
        
        
        TicketBookingSystem tbs = new TicketBookingSystem();

        // Adding event occurrences
        // Note: events and places are selected sequentially, for simplicity
        for (int i=0; i<12; i++) {
            tbs.addEventOccurrence(events[i % events.length], places[i % places.length], dates[i]);
        }

        // Trying to add an event occurring at the same place and time
        // This should result in the warning message being writen to the console
        boolean result = tbs.addEventOccurrence(new Concert("The Revivalists", "Summer Soul Sessions", 90), places[0], dates[0]);
        if (!result) out.println("### There is already an event occurring at this place and time!");


        // Booking tickets
        // Note that the event idenfiers used (1000-1011) are expected to exist after running the for cycle above!
        int[] ticketReferences = new int[100];
        for (int i=0; i<ticketReferences.length; i++) {
            int eventId = 1000 + (i % 12); 
            ticketReferences[i] = tbs.bookTickets(eventId, 10);

            if (ticketReferences[i] < 0) out.println("** No more tickets available for event " + eventId);
        }
       

        // Listing event occurrences to the console / output file
        for (EventOccurrence e: tbs.getEventOccurrences())
            out.println(e);
		
	}

	// CHANGE THIS METHOD ONLY WHERE INDICATED
	private static void exercise2(PrintStream out) {
		out.println("\n\nAlínea 2) ----------------------------------\n");

        TicketBookingSystem tbs = new TicketBookingSystem();

        // Creating some places
        Place[] places = {
            new Place("Riverside Theatre", 200),
            new Place("City Lights Cinema", 250),
            new Place("Central Park Bandshell", 200),
            new Place("The Black Box", 170),
            new Place("The Studio", 250),
            new Place("Main Street Cinema", 220),
            new Place("The Park Stage", 200),
            new Place("The Blues Room", 150),
            new Place("The Loft", 75),
        };

        // Creating some events
        tbs.addEventOccurrence(new Concert("DJ Pulse",  "Neon Beats Night", 90), places[2], "2024-06-25 21:15");
        tbs.addEventOccurrence(new Concert("The Rumbling Stones",  "Classic Rock Revival", 120), places[3], "2024-06-17 19:00");
        tbs.addEventOccurrence(new Concert("Moonlight Sonata",  "Symphonic Serenade", 105), places[7], "2024-06-22 19:30");
        tbs.addEventOccurrence(new Concert("Mariachi Sol",  "Fiesta del Sol", 60), places[8], "2024-06-11 22:00");
        tbs.addEventOccurrence(new Concert("Indigo Groove",  "Smooth Sounds & City Lights", 90), places[4], "2024-06-17 19:00");
        tbs.addEventOccurrence(new Theatre("Ghostlight", "Augustus Moore", "Torchlight Repertory", 90), places[3], "2024-06-20 18:45");
        tbs.addEventOccurrence(new Theatre("Unbound", "Sarah Li", "New Stage Collective", 75), places[2], "2024-06-28 18:30");
        tbs.addEventOccurrence(new Cinema("Code Blue", "Ava Ramirez", 2024, new String[]{"Park So-dam", "Anthony Mackie", "Idris Elba"}, 108), places[5], "2024-06-28 18:30");
        tbs.addEventOccurrence(new Cinema("A Quiet Night In", "David Lynch", 1992, new String[]{"Isabella Rossellini", "Brad Dourif", "Julee Cruise"}, 120), places[6], "2024-06-25 21:15");
        tbs.addEventOccurrence(new Cinema("The Last Ride", "Hirokazu Kore-eda", 2023, new String[]{"Masaki Okada", "You Yoshiyuki", "Machiko Ono"}, 115), places[8], "2024-06-28 18:30");
        
		/*
		** Adicione aqui o código necessário para a leitura do ficheiro e registo das reservas de bilhetes.
		** Add here the code to read from file and register the ticket bookings.
		*/


		out.println("\nFinished reading file.\n");


        /*
		** Adicione aqui o código necessário para listar os primeiros 10 eventos com bilhetes disponíveis, ordenados por data.
		** Add here the code to display the first 10 events with available tickets, sorted by date.
		*/
        out.println("\n** First 10 available events, sorted by date:");


        /*
		** Adicione aqui o código necessário para listar o total de bilhetes vendidos, por tipo de bilhete.
		** Add here the code to display total number of tickets sold, by type of event.
		*/
        out.println("\n** Number of tickets sold by event type:");

    }

}
