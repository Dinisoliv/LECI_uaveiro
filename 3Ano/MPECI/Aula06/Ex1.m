% =========================================================
%  Exercise 1 — M/M/1/K queue for an IP link
% =========================================================

clear; clc;

% ---------------------------------------------------------
%  SYSTEM PARAMETERS
% ---------------------------------------------------------
link_capacity  = 100e6;          % [bits/s]  link speed
throughput_in  = 80e6;           % [bits/s]  offered traffic
avg_pkt_bytes  = 800;            % [Bytes]   mean packet size
avg_pkt_bits   = avg_pkt_bytes * 8;          % 6400 bits

%  Packet-level rates  (arrivals and service are both
%  exponential because packet sizes are exponential)
lambda = throughput_in / avg_pkt_bits;   % arrival rate  [pkt/s]
mu     = link_capacity / avg_pkt_bits;   % service rate  [pkt/s]
rho    = lambda / mu;                    % traffic intensity (= 0.8)

fprintf('=== System parameters ===\n');
fprintf('  lambda = %g pkt/s\n',  lambda);
fprintf('  mu     = %g pkt/s\n',  mu);
fprintf('  rho    = %.4f\n\n',    rho);

% ---------------------------------------------------------
%  HELPER FUNCTION — M/M/1/K steady-state probabilities
%
%  p_n = p0 * rho^n,   n = 0, 1, ..., K
%  p0  = (1 - rho) / (1 - rho^(K+1))        [rho ~= 1]
% ---------------------------------------------------------
function p = mm1k_probs(rho, K)
    p0 = (1 - rho) / (1 - rho^(K + 1));
    p  = p0 * rho .^ (0:K);   % row vector length K+1
end

% ---------------------------------------------------------
%  PART (a) — fixed queue size Q = 8
% ---------------------------------------------------------
Q = 8;
K = 1 + Q;                    % total capacity: 1 server + Q waiting

p       = mm1k_probs(rho, K);
n_vec   = 0:K;

P_loss    = p(end);                        % p_K  (loss prob.)
N_avg     = sum(n_vec .* p);              % mean number in system
lambda_eff = lambda * (1 - P_loss);       % effective throughput
W_avg_ms  = (N_avg / lambda_eff) * 1e3;  % mean delay [ms]  (Little)

fprintf('=== Part (a):  Q = %d packets ===\n', Q);
fprintf('  Avg. packet delay  = %.3f msec\n', W_avg_ms);
fprintf('  Packet loss rate   = %.3f%%\n\n', P_loss * 100);

% ---------------------------------------------------------
%  PART (b) — find minimum Q so that P_loss <= 0.1%
% ---------------------------------------------------------
target = 0.001;    % 0.1 %

Q_min = 1;
while true
    K_test = 1 + Q_min;
    p_test = mm1k_probs(rho, K_test);
    if p_test(end) <= target
        break;
    end
    Q_min = Q_min + 1;
end

%  Final metrics for the found Q
K_min      = 1 + Q_min;
p_final    = mm1k_probs(rho, K_min);
P_loss_min = p_final(end);

fprintf('=== Part (b):  minimum Q for P_loss <= 0.1%% ===\n');
fprintf('  Minimum queue size = %d packets\n', Q_min);
fprintf('  Packet loss rate   = %.5f%%\n',     P_loss_min * 100);