function VideoStreamingSimulatorVis(lambda, invmiu, B, M, N)
% Visualization of the number of simultaneous movies over time
% Events:
ARRIVAL = 0;
DEPARTURE = 1;

% Initialization:
Clock = 0;
STATE = 0;
TRANSMITTED = 0;
EventList = [ARRIVAL, Clock + exprnd(1/lambda)];

% Arrays to store time and state for     plotting:
timeLog = [0];
stateLog = [0];

while TRANSMITTED < N
    EventList = sortrows(EventList, 2);
    event = EventList(1,1);
    Clock = EventList(1,2);
    EventList(1,:) = [];
    
    switch event
        case ARRIVAL
            EventList = [EventList; ARRIVAL, Clock + exprnd(1/lambda)];
            if STATE < M
                STATE = STATE + 1;
                EventList = [EventList; DEPARTURE, Clock + exprnd(invmiu)];
            end
        case DEPARTURE
            STATE = STATE - 1;
            TRANSMITTED = TRANSMITTED + 1;
    end
    
    % Log the current state after processing the event:
    timeLog = [timeLog, Clock];
    stateLog = [stateLog, STATE];
end

% Plot:
stairs(timeLog, stateLog);
xlabel('Time (minutes)');
ylabel('No. of simultaneous movies');
grid on;
end