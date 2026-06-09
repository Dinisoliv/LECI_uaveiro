function [PB, DB] = VideoStreamingSimulatorPBDB(lambda, invmiu, B, M, N)
% VideoStreamingSimulator(lambda, invmiu, B, M, N)
% lambda:  arrival rate of movie requests (requests/minute)
% invmiu:  average duration of movies (minutes)
% B:       throughput of each movie (Mbps)
% M:       capacity of the server (no. of simultaneous transmitted movies)
% N:       stopping criterion (simulation finishes at end of Nth movie)
% Output:
%   PB:    blocking probability (%)
%   DB:    average server throughput (Mbps)

    % Event types
    ARRIVAL   = 0;
    DEPARTURE = 1;

    % Initialization
    Clock       = 0;
    STATE       = 0;   % no. of movies currently in transmission
    TRANSMITTED = 0;   % no. of movies transmitted so far

    % Statistical counters
    N_ARRIVALS = 0;
    BLOCKED    = 0;
    LOAD       = 0;    % integral of bitrate [Mbps * min]

    % Event list: [event_type, event_time]
    EventList = [ARRIVAL, Clock + exprnd(1/lambda)];

    while TRANSMITTED < N
        EventList = sortrows(EventList, 2);

        event         = EventList(1, 1);
        PreviousClock = Clock;
        Clock         = EventList(1, 2);
        EventList(1,:)= [];

        % Update LOAD integral (rectangle area)
        LOAD = LOAD + B * STATE * (Clock - PreviousClock);

        switch event
            case ARRIVAL
                % Schedule next arrival
                EventList = [EventList; ARRIVAL, Clock + exprnd(1/lambda)];
                N_ARRIVALS = N_ARRIVALS + 1;

                if STATE < M
                    STATE = STATE + 1;
                    EventList = [EventList; DEPARTURE, Clock + exprnd(invmiu)];
                else
                    BLOCKED = BLOCKED + 1;  % server full → block
                end

            case DEPARTURE
                STATE       = STATE - 1;
                TRANSMITTED = TRANSMITTED + 1;
        end
    end

    PB = 100 * BLOCKED / N_ARRIVALS;  % in %
    DB = LOAD / Clock;                 % average Mbps
end