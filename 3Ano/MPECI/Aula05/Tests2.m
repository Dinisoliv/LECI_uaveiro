%% Exercise 2 — Confidence intervals for PB and DB
lambda = 2;    % requests/minute
invmiu = 90;   % minutes (average movie duration)
B      = 2;    % Mbps per movie
M      = 200;  % max simultaneous movies
N      = 1e4;  % stopping criterion
alfa   = 0.1;  % significance level → 90% confidence interval

%% --- (a) 10 simulation runs ---
Nsim = 10;
PB_a = zeros(1, Nsim);
DB_a = zeros(1, Nsim);

for it = 1:Nsim
    [PB_a(it), DB_a(it)] = VideoStreamingSimulatorPBDB(lambda, invmiu, B, M, N);
end

media = mean(PB_a);
[~, ~, ci] = ttest(PB_a, media, 'alpha', alfa);
fprintf('Exercise 2(a):\n');
fprintf('  PB = %.3f [%.3f - %.3f] %%\n', media, ci(1), ci(2));

media = mean(DB_a);
[~, ~, ci] = ttest(DB_a, media, 'alpha', alfa);
fprintf('  DB = %.2f [%.2f - %.2f] Mbps\n', media, ci(1), ci(2));

%% --- (b) 100 simulation runs ---
Nsim = 100;
PB_b = zeros(1, Nsim);
DB_b = zeros(1, Nsim);

for it = 1:Nsim
    [PB_b(it), DB_b(it)] = VideoStreamingSimulatorPBDB(lambda, invmiu, B, M, N);
end

media = mean(PB_b);
[~, ~, ci] = ttest(PB_b, media, 'alpha', alfa);
fprintf('Exercise 2(b):\n');
fprintf('  PB = %.3f [%.3f - %.3f] %%\n', media, ci(1), ci(2));

media = mean(DB_b);
[~, ~, ci] = ttest(DB_b, media, 'alpha', alfa);
fprintf('  DB = %.2f [%.2f - %.2f] Mbps\n', media, ci(1), ci(2));