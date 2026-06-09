    %% Ex4 - M/M/1
lambda = 8;       % clients/min
mu = 10;          % clients/min
rho = lambda/mu;  % = 0.8

% (a) Average time in the system
W = 1 / (mu - lambda);
fprintf('a) W = %.4f min = %.2f seconds\n', W, W*60);

% (b) Average server occupation
fprintf('b) Server occupation = %.1f%%\n', rho*100);

% (c) Average queue occupation
LQ = lambda^2 / (mu * (mu - lambda));
fprintf('c) LQ = %.4f clients\n', LQ);

% (d) P(queue > k)
% Queue > k means n >= k+2, and P(n >= j) = rho^j for M/M/1
for k = [6 20 40]
    p = rho^(k+2);
    fprintf('d) P(queue > %d) = rho^%d = %.6f%%\n', k, k+2, p*100);
end

% (e) Plot W vs lambda
lambda_range = 1:0.1:9;
W_range = 1 ./ (mu - lambda_range);
plot(lambda_range, W_range, 'b-', 'LineWidth', 2);
xlabel('\lambda (clients/min)');
ylabel('W (min)');
title('Average time in system vs arrival rate');
grid on;