% =========================================================
%  Exercise 2 — M/M/1/B queue for a data service server
%  Course: Métodos Probabilísticos para Engenharia de
%          Computadores e Informática 2025/2026
% =========================================================
%
%  Model: M/M/1/B
%    - Single server whose total capacity = n_ref / t_ref
%    - Finite buffer B (acceptance limit)
%    - No waiting queue: if B slots occupied, request is blocked
%
%  Key insight: "200 µs when attending 250 requests" reveals the
%  total machine throughput mu = 250 / 200e-6 = 1.25e6 req/s.
%  This is a fixed-capacity server, not processor sharing.
% =========================================================

clear; clc;

% ---------------------------------------------------------
%  SYSTEM PARAMETERS
% ---------------------------------------------------------
n_ref  = 250;          % simultaneous requests at reference point
t_ref  = 200e-6;       % mean service time at reference point [s]
lambda = 1.23e6;       % arrival rate [req/s]

%  Total server throughput (capacity)
mu  = n_ref / t_ref;   % = 1.25e6 req/s
rho = lambda / mu;     % traffic intensity (= 0.984)

fprintf('=== System parameters ===\n');
fprintf('  mu  (total server rate) = %.4e req/s\n', mu);
fprintf('  rho (traffic intensity) = %.4f\n\n', rho);

% ---------------------------------------------------------
%  HELPER FUNCTION — M/M/1/B steady-state probabilities
%
%  p_n = p0 * rho^n,   n = 0, 1, ..., B
%  p0  = (1 - rho) / (1 - rho^(B+1))
%
%  Same formula as M/M/1/K from exercise 1!
%  Here K = B (buffer = system capacity, no separate queue).
% ---------------------------------------------------------
function p = mm1b_probs(rho, B)
    p0 = (1 - rho) / (1 - rho^(B + 1));
    p  = p0 * rho .^ (0:B);
end

% ---------------------------------------------------------
%  PART (a) — lambda = 1.23e6, B = 250
% ---------------------------------------------------------
B = 250;

p          = mm1b_probs(rho, B);
n_vec      = 0:B;

P_block    = p(end);                         % blocking probability
N_avg      = sum(n_vec .* p);               % mean requests in system
lambda_eff = lambda * (1 - P_block);        % effective throughput
W_avg_us   = (N_avg / lambda_eff) * 1e6;   % mean service time [µs]

fprintf('=== Part (a): lambda = %.2e, B = %d ===\n', lambda, B);
fprintf('  Service blocking probability  = %.5f%%\n', P_block * 100);
fprintf('  Avg. service time per request = %.3f microseconds\n\n', W_avg_us);

% ---------------------------------------------------------
%  PART (b) — vary B = 200, 250, 300, 350, 400
% ---------------------------------------------------------
B_values = [200, 250, 300, 350, 400];
P_block_vec = zeros(size(B_values));
W_avg_vec   = zeros(size(B_values));

for i = 1:length(B_values)
    Bi      = B_values(i);
    pi      = mm1b_probs(rho, Bi);
    ni      = 0:Bi;
    P_bi    = pi(end);
    N_i     = sum(ni .* pi);
    leff_i  = lambda * (1 - P_bi);
    P_block_vec(i) = P_bi * 100;           % [%]
    W_avg_vec(i)   = (N_i / leff_i) * 1e6; % [µs]
end

fprintf('=== Part (b): results for varying B ===\n');
fprintf('%6s  %14s  %16s\n', 'B', 'P_block (%)', 'W_avg (µs)');
for i = 1:length(B_values)
    fprintf('%6d  %14.5f  %16.3f\n', B_values(i), P_block_vec(i), W_avg_vec(i));
end

%  Bar charts
figure;

subplot(1, 2, 1);
bar(B_values, P_block_vec, 'FaceColor', [0.22 0.47 0.73]);
xlabel('Acceptance limit B (no. of requests)');
ylabel('Blocking probability (%)');
title('Service blocking probability vs B');
grid on;

subplot(1, 2, 2);
bar(B_values, W_avg_vec, 'FaceColor', [0.22 0.47 0.73]);
xlabel('Acceptance limit B (no. of requests)');
ylabel('Avg. service time per request (µs)');
title('Average service time vs B');
grid on;

% ---------------------------------------------------------
%  CONCLUSIONS
%
%  As B increases:
%    - Blocking probability DECREASES: more buffer = fewer
%      rejected requests, so the system is more accessible.
%    - Avg. service time INCREASES: a larger buffer allows
%      more requests to accumulate, so each waits longer
%      before completing. There is a clear trade-off:
%      accepting more requests improves availability but
%      degrades individual response time.
% ---------------------------------------------------------