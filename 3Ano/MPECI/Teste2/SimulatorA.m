function PAR = SimulatorA(lambda, M, N)
%
% lambda: arrival rate of movie requests (requests/minute)
% M:      capacity of the server (no. of simultaneous transmitted movies)
% N:      stopping criterion (the simulation finishes at the end of the
%         transmition of the Nth movie)

    % Events:
    ARRIVAL= 0; 	    % request of a movie
    DEPARTURE= 1; 	    % end of a movie transmission

    % Initialization of variables:
    Clock= 0; 		    % Simulation clock
    STATE= 0; 		    % No. of movies in transmission
    TRANSMITTED= 0; 	% No. of transmitted movies
    LOAD= 0;

    % Initializing the List of Events:
    EventList= [ARRIVAL, Clock + exprnd(1/lambda)];

    while TRANSMITTED < N
        EventList= sortrows(EventList,2);
        event= EventList(1,1);
        PreviousClock= Clock;
        Clock= EventList(1,2);
        EventList(1,:)= [];
        LOAD= LOAD + STATE*(Clock-PreviousClock);
        switch event
            case ARRIVAL
                EventList= [EventList; ARRIVAL, Clock + exprnd(1/lambda)];
                if STATE < M
                    STATE= STATE + 1;
                    EventList= [EventList; DEPARTURE, Clock + 90 + 30*rand()];
                end
            case DEPARTURE
                STATE= STATE - 1;
                TRANSMITTED= TRANSMITTED + 1;
        end
    end
    PAR= LOAD/Clock;
end