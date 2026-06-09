%% Exercise 12 — Bar charts with CI error bars for AM and PD

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
lambda   = 1800;
C        = 10;
F_values = [50, 20, 10, 5];
N        = 1e4;
Nsim     = 100;
alfa     = 0.1;   % 90% CI

%% Run simulations and store results
n_F      = length(F_values);
means_AM = zeros(1, n_F);
err_AM   = zeros(2, n_F);   % row 1 = lower error, row 2 = upper error
means_PD = zeros(1, n_F);
err_PD   = zeros(2, n_F);

for k = 1:n_F
    F = F_values(k);

    AM_vec = zeros(1, Nsim);
    PD_vec = zeros(1, Nsim);

    for it = 1:Nsim
        [AM_vec(it), PD_vec(it)] = LinkSimulatorDP(lambda, x_sizes, ...
                                                    f_cum, C, F, N);
    end

    %% AM
    AM_ms      = AM_vec * 1000;
    media_AM   = mean(AM_ms);
    [~, ~, ci] = ttest(AM_ms, media_AM, 'alpha', alfa);

    means_AM(k)   = media_AM;
    err_AM(1, k)  = media_AM - ci(1);   % downward error
    err_AM(2, k)  = ci(2) - media_AM;   % upward error

    %% PD
    media_PD   = mean(PD_vec);
    [~, ~, ci] = ttest(PD_vec, media_PD, 'alpha', alfa);

    means_PD(k)   = media_PD;
    err_PD(1, k)  = media_PD - ci(1);
    err_PD(2, k)  = ci(2) - media_PD;
end

%% --- Plot ---
x_pos = 1:n_F;   % bar positions
x_labels = {'50', '20', '10', '5'};

figure;

%% Left subplot — Average packet delay (AM)
subplot(1, 2, 1);
b1 = bar(x_pos, means_AM);
b1.FaceColor = [0.2, 0.4, 0.8];
hold on;
errorbar(x_pos, means_AM, err_AM(1,:), err_AM(2,:), ...
    'k', 'LineStyle', 'none', 'LineWidth', 1.5, 'CapSize', 8);
set(gca, 'XTick', x_pos, 'XTickLabel', x_labels);
xlabel('Queue size (in no. of packets)');
ylabel('Avg. packet delay (msec)');
grid on;
hold off;

%% Right subplot — Packet drop probability (PD)
subplot(1, 2, 2);
b2 = bar(x_pos, means_PD);
b2.FaceColor = [0.2, 0.4, 0.8];
hold on;
errorbar(x_pos, means_PD, err_PD(1,:), err_PD(2,:), ...
    'k', 'LineStyle', 'none', 'LineWidth', 1.5, 'CapSize', 8);
set(gca, 'XTick', x_pos, 'XTickLabel', x_labels);
xlabel('Queue size (in no. of packets)');
ylabel('Packet drop probability (%)');
grid on;
hold off;