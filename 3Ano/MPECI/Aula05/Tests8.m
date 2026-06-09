%% Exercise 8 — AM for different arrival rates

%% Build discrete packet size distribution (same as Ex. 7)
x_sizes = 64:1500;
n_other = length(x_sizes) - 3;
p_other = (1 - 0.29606 - 0.16417 - 0.19601) / n_other;

f_sizes = ones(1, length(x_sizes)) * p_other;
f_sizes(x_sizes == 64)   = 0.29606;
f_sizes(x_sizes == 110)  = 0.16417;
f_sizes(x_sizes == 1500) = 0.19601;

f_cum = [0, cumsum(f_sizes)];   % precomputed once

%% Simulation parameters
lambdas = [1000, 1250, 1500, 1750, 2000];  % arrival rates to test
C    = 10;      % Mbps
F    = 1000;    % queue capacity
N    = 1e4;     % stopping criterion
Nsim = 100;     % simulation runs per lambda
alfa = 0.1;     % 90% CI

fprintf('Exercise 8:\n');

for k = 1:length(lambdas)
    lambda = lambdas(k);
    AM_vec = zeros(1, Nsim);

    for it = 1:Nsim
        AM_vec(it) = LinkSimulatorDiscrete(lambda, x_sizes, f_cum, C, F, N);
    end

    AM_ms      = AM_vec * 1000;   % s → ms
    media      = mean(AM_ms);
    [~, ~, ci] = ttest(AM_ms, media, 'alpha', alfa);

    fprintf('  lambda= %4d: AM = %.4f [%.4f - %.4f] msec\n', ...
             lambda, media, ci(1), ci(2));
end