% Parameters common to all cases:
invmiu = 90;  % average movie duration (minutes)
B = 2;        % Mbps (not used for visualization, but required)
M = 200;      % max simultaneous movies

% (a) lambda=2, N=1e3
figure(1); VideoStreamingSimulatorVis(2, invmiu, B, M, 1e3);
title('(a) \lambda=2, N=10^3');

% (b) lambda=2, N=1e4
figure(2); VideoStreamingSimulatorVis(2, invmiu, B, M, 1e4);
title('(b) \lambda=2, N=10^4');

% (c) lambda=3, N=1e3
figure(3); VideoStreamingSimulatorVis(3, invmiu, B, M, 1e3);
title('(c) \lambda=3, N=10^3');

% (d) lambda=3, N=1e4
figure(4); VideoStreamingSimulatorVis(3, invmiu, B, M, 1e4);
title('(d) \lambda=3, N=10^4');