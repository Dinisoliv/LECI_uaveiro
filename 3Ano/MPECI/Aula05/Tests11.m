%% Exercise 11 — AM and PD for different queue capacities

%% Build discrete packet size distribution (same as Ex. 7)
x_sizes = 64:1500;
n_other = length(x_sizes) - 3;
p_other = (1 - 0.29606 - 0.16417 - 0.19601) / n_other;

f_sizes = ones(1, length(x_sizes)) * p_other;
f_sizes(x_sizes == 64)   = 0.29606;
f_sizes(x_sizes == 110)  = 0.16417;
f_sizes(x_sizes == 1500) = 0.19601;

f_cum = [0, cumsum(f_sizes)];

%% Simulation parameters
lambda   = 1800;          % packets/second
C        = 10;            % Mbps
F_values = [50, 20, 10, 5];  % queue capacities to test
N        = 1e4;           % stopping criterion
Nsim     = 100;           % simulation runs
alfa     = 0.1;           % 90% CI

%% Store results for plotting in Ex. 12
n_F      = length(F_values);
means_AM = zeros(1, n_F);
ci_AM    = zeros(2, n_F);   % row 1 = lower, row 2 = upper
means_PD = zeros(1, n_F);
ci_PD    = zeros(2, n_F);

fprintf('Exercise 11:\n');

for k = 1:n_F
    F = F_values(k);

    AM_vec = zeros(1, Nsim);
    PD_vec = zeros(1, Nsim);

    for it = 1:Nsim
        [AM_vec(it), PD_vec(it)] = LinkSimulatorDP(lambda, x_sizes, ...
                                                    f_cum, C, F, N);
    end

    %% AM confidence interval
    AM_ms      = AM_vec * 1000;   % s → ms
    media_AM   = mean(AM_ms);
    [~, ~, ci] = ttest(AM_ms, media_AM, 'alpha', alfa);

    means_AM(k) = media_AM;
    ci_AM(1, k) = ci(1);
    ci_AM(2, k) = ci(2);

    %% PD confidence interval
    media_PD   = mean(PD_vec);
    [~, ~, ci] = ttest(PD_vec, media_PD, 'alpha', alfa);

    means_PD(k) = media_PD;
    ci_PD(1, k) = ci(1);
    ci_PD(2, k) = ci(2);

    fprintf('  F= %2d: AM = %.4f [%.4f - %.4f] msec\n', ...
             F, media_AM, ci_AM(1,k), ci_AM(2,k));
    fprintf('         PD = %.3f [%.3f - %.3f] %%\n', ...
             media_PD, ci_PD(1,k), ci_PD(2,k));
end