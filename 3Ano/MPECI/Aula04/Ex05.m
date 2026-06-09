%% Ex5 - M/M/1/m
lambda = 80;       % clients/second
mu = 100;          % clients/second
rho = lambda/mu;   % = 0.8
m = 10;            % system capacity

% Stationary probabilities (slide 48)
n = 0:m;
co = rho.^n;
PI = co / sum(co);

% (a) Discard probability = pi_m (PASTA)
fprintf('a) P(discard) = pi_%d = %.4f%%\n', m, PI(m+1)*100);

% (b) Avg time in system when not discarded
L = sum(n .* PI);                    % avg clients in system
lambda_eff = lambda * (1 - PI(m+1)); % effective arrival rate
W = L / lambda_eff;                  % Little's theorem
fprintf('b) W = %.4f ms\n', W*1000);

% (c) Avg queue occupation
LQ = L - (1 - PI(1));   % L minus avg number being served
fprintf('c) LQ = %.4f clients\n', LQ);

% (d) Bar chart of discard probability vs m
m_values = 5:5:40;
p_discard = zeros(size(m_values));
for k = 1:length(m_values)
    mv = m_values(k);
    co_v = rho.^(0:mv);
    pi_v = co_v / sum(co_v);
    p_discard(k) = pi_v(mv+1) * 100;
end
bar(m_values, p_discard);
xlabel('System capacity m');
ylabel('Discard probability (%)');
title('Client discard probability vs system capacity');