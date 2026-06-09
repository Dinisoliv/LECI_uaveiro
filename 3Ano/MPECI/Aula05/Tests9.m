%% Exercise 9 — Bar chart with CI error bars

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
lambdas = [1000, 1250, 1500, 1750, 2000];
C    = 10;
F    = 1000;
N    = 1e4;
Nsim = 100;
alfa = 0.1;   % 90% CI

%% Run simulations and store results
n_lambda = length(lambdas);
means    = zeros(1, n_lambda);   % mean AM for each lambda
ci_low   = zeros(1, n_lambda);   % lower CI bound
ci_high  = zeros(1, n_lambda);   % upper CI bound

for k = 1:n_lambda
    lambda = lambdas(k);
    AM_vec = zeros(1, Nsim);

    for it = 1:Nsim
        AM_vec(it) = LinkSimulatorDiscrete(lambda, x_sizes, f_cum, C, F, N);
    end

    AM_ms      = AM_vec * 1000;   % s → ms
    media      = mean(AM_ms);
    [~, ~, ci] = ttest(AM_ms, media, 'alpha', alfa);

    means(k)   = media;
    ci_low(k)  = ci(1);
    ci_high(k) = ci(2);
end

%% Plot bar chart with error bars
% Error bar values are distances from mean to each CI bound
err_low  = means - ci_low;    % downward error
err_high = ci_high - means;   % upward error

figure;
b = bar(lambdas, means);
b.FaceColor = [0.2, 0.4, 0.8];   % blue bars
hold on;

% Add error bars
% errorbar requires x, y, neg_err, pos_err
errorbar(lambdas, means, err_low, err_high, ...
    'k', ...            % black lines
    'LineStyle', 'none', ...
    'LineWidth', 1.5, ...
    'CapSize', 8);

xlabel('Packet arrival rate (pps)');
ylabel('Avg. packet delay (msec)');
grid on;
hold off;