%% Exercise 13 — Theoretical AM and PD via M/M/1/m

%% System parameters
lambda   = 1800;             % packets/second (arrival rate)
C        = 10e6;             % bits/second (link capacity)
B_avg    = 600.003;          % average packet size (Bytes) — from Ex. 7
F_values = [50, 20, 10, 5];  % queue capacities

%% Service rate
mu = C / (8 * B_avg);        % packets/second
rho = lambda / mu;            % traffic intensity

fprintf('Theoretical parameters:\n');
fprintf('  mu  = %.4f packets/s\n', mu);
fprintf('  rho = %.4f\n\n', rho);

fprintf('Exercise 13:\n');

for k = 1:length(F_values)
    F = F_values(k);
    m = F + 1;   % total system capacity (queue + server)

    %% Steady-state probabilities
    % P(n) = (1-rho)*rho^n / (1-rho^(m+1))  for rho != 1
    % Use log-space to avoid numerical overflow for large m
    n_vals = 0:m;

    if abs(rho - 1) > 1e-10
        % General case rho != 1
        norm_const = (1 - rho) / (1 - rho^(m+1));
        P = norm_const * rho.^n_vals;
    else
        % Special case rho = 1: P(n) = 1/(m+1)
        P = ones(1, m+1) / (m+1);
    end

    %% Packet drop probability
    PD_theory = P(end);   % P(m) = probability system is full

    %% Mean number of packets in system E[N]
    EN = sum(n_vals .* P);

    %% Effective arrival rate (arrivals that are not dropped)
    lambda_eff = lambda * (1 - PD_theory);

    %% Average delay via Little's Law: AM = E[N] / lambda_eff
    AM_theory = EN / lambda_eff;   % seconds

    fprintf('  F= %2d: AM = %.4f msec\n', F, AM_theory * 1000);
    fprintf('         PD = %.3f %%\n', PD_theory * 100);
end