%% Exercise 7 — Discrete packet size distribution

%% Build distribution (same as Step 1)
x_sizes = 64:1500;
n_other  = length(x_sizes) - 3;
p_other  = (1 - 0.29606 - 0.16417 - 0.19601) / n_other;

f_sizes = ones(1, length(x_sizes)) * p_other;
f_sizes(x_sizes == 64)   = 0.29606;
f_sizes(x_sizes == 110)  = 0.16417;
f_sizes(x_sizes == 1500) = 0.19601;

avg_size = sum(x_sizes .* f_sizes);
fprintf('Exercise 7:\n');
fprintf('  Avg. Packet Size = %.4f Bytes\n', avg_size);

f_cum = [0, cumsum(f_sizes)];   % precomputed once, passed to simulator

%% Simulation parameters
lambda = 1000;   % packets/second
C      = 10;     % Mbps
F      = 1000;   % queue capacity
N      = 1e4;    % stopping criterion
Nsim   = 100;
alfa   = 0.1;    % 90% CI

AM_vec = zeros(1, Nsim);

for it = 1:Nsim
    AM_vec(it) = LinkSimulatorDiscrete(lambda, x_sizes, f_cum, C, F, N);
end

AM_ms      = AM_vec * 1000;   % convert s → ms
media      = mean(AM_ms);
[~, ~, ci] = ttest(AM_ms, media, 'alpha', alfa);

fprintf('  AM = %.4f [%.4f - %.4f] msec\n', media, ci(1), ci(2));