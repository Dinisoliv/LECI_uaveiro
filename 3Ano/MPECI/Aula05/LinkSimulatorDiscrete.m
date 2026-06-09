function AM = LinkSimulatorDiscrete(lambda, x_sizes, f_cum, C, F, N)
% AM = LinkSimulatorDiscrete(lambda, x_sizes, f_cum, C, F, N)
% Input:
%   lambda:  packet arrival rate (packets/second)
%   x_sizes: vector of possible packet sizes (Bytes)
%   f_cum:   cumulative probability vector (length = length(x_sizes)+1)
%   C:       link capacity (Mbps)
%   F:       queue capacity (packets)
%   N:       stopping criterion
% Output:
%   AM:      average packet delay (in seconds)

    % Event types
    ARRIVAL   = 0;
    DEPARTURE = 1;

    % Initialization
    Clock       = 0;
    STATE       = 0;    % 0 = link free, 1 = link busy
    QUEUE_N     = 0;    % number of packets in queue
    DELAYS      = 0;    % sum of delays of transmitted packets
    TRANSMITTED = 0;    % number of transmitted packets
    QUEUE       = [];   % arrival instants of queued packets

    % Initialize event list with first ARRIVAL
    % Columns: [event_type, event_time, arrival_instant]
    tmp = Clock + exprnd(1/lambda);
    EventList = [ARRIVAL, tmp, tmp];

    while TRANSMITTED < N
        EventList  = sortrows(EventList, 2);

        Event      = EventList(1, 1);
        Clock      = EventList(1, 2);
        ArrInstant = EventList(1, 3);
        EventList(1, :) = [];

        switch Event
            case ARRIVAL
                % Schedule next arrival
                tmp = Clock + exprnd(1/lambda);
                EventList = [EventList; ARRIVAL, tmp, tmp];

                if STATE == 0
                    % Link free → transmit immediately
                    STATE  = 1;
                    % Generate packet size from discrete distribution
                    pkt_size = x_sizes(sum(rand() > f_cum));
                    tTime    = 8 * pkt_size / (C * 1e6);   % transmission time (s)
                    EventList = [EventList; DEPARTURE, Clock + tTime, ArrInstant];
                else
                    % Link busy → queue if space available
                    if QUEUE_N < F
                        QUEUE_N = QUEUE_N + 1;
                        QUEUE   = [QUEUE; ArrInstant];
                    end
                    % else: packet dropped silently
                end

            case DEPARTURE
                DELAYS      = DELAYS + (Clock - ArrInstant);
                TRANSMITTED = TRANSMITTED + 1;

                if QUEUE_N > 0
                    % Serve next queued packet (FIFO)
                    QInstant = QUEUE(1);
                    pkt_size = x_sizes(sum(rand() > f_cum));
                    tTime    = 8 * pkt_size / (C * 1e6);
                    EventList = [EventList; DEPARTURE, Clock + tTime, QInstant];
                    QUEUE_N  = QUEUE_N - 1;
                    QUEUE(1) = [];
                else
                    STATE = 0;
                end
        end
    end

    AM = DELAYS / TRANSMITTED;  % seconds
end