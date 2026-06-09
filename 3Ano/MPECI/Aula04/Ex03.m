%% Ex3 - Data Center with 100 servers
N = 100;
mu_rate = 2/3;   % repair rate per technician (24/36 per day)

for t = [1 2 3]
    fprintf('===== t = %d technician(s) =====\n', t);
    
    % Birth rates: lambda_n = (100-n)/200, n = 0..99
    lambda = (N - (0:N-1)) / 200;
    
    % Death rates: mu_n = min(n,t) * 2/3, n = 1..100
    miu = min(1:N, t) * mu_rate;
    
    % Birth-death formula (slide 23)
    co = [1, lambda./miu];
    co = cumprod(co);
    PI = co / sum(co);
    
    % i) Average number of servers down
    n_vals = 0:N;
    avg_down = sum(n_vals .* PI);
    fprintf('  i)   Avg servers down:      %.4f\n', avg_down);
    fprintf('       Avg servers working:   %.4f\n', N - avg_down);
    
    % ii) Average number of technicians busy
    tech_busy = min(0:N, t);
    avg_tech = sum(tech_busy .* PI);
    fprintf('  ii)  Avg technicians busy:  %.4f\n', avg_tech);
    
    % iii) P(at least 90 servers working) = P(n <= 10 down)
    p_90 = sum(PI(1:11)) * 100;    % PI(1) = pi_0, ..., PI(11) = pi_10
    fprintf('  iii) P(>=90 working):       %.4f%%\n', p_90);
    fprintf('\n');
end