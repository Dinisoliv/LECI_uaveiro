%% Exercise 6 — Average packet delay with 90% CI
lambda = 1000;   % packets/second
B      = 600;    % avg. packet size (Bytes)
C      = 10;     % link capacity (Mbps)
F      = 1000;   % queue capacity (packets)
N      = 1e4;    % stopping criterion
Nsim   = 100;    % number of simulation runs
alfa   = 0.1;    % significance level → 90% CI

AM_vec = zeros(1, Nsim);

for it = 1:Nsim
    AM_vec(it) = LinkSimulator(lambda, B, C, F, N);
end

media       = mean(AM_vec) * 1000;   % convert s → ms
AM_ms       = AM_vec * 1000;
[~, ~, ci]  = ttest(AM_ms, media, 'alpha', alfa);

fprintf('Exercise 6:\n');
fprintf('  AM = %.4f [%.4f - %.4f] msec\n', media, ci(1), ci(2));