% Possible outcomes
x = 1:6;

% Probability Mass Function
pmf = ones(1,6) / 6;

% Cumulative Distribution Function
cdf = cumsum(pmf);

figure

% PMF
stem(x, pmf, 'filled')
hold on

% CDF
stairs(x, cdf, 'LineWidth', 2)
    
xlabel('x')
ylabel('Probability')
title('PMF and CDF of a Fair Die')
legend('PMF','CDF')
grid on