x = [5 10 100];
pmf = [0.9 0.09 0.01];

% Cumulative Distribution Function
cdf = cumsum(pmf);

% CDF
stairs(x, cdf, 'LineWidth', 2)
    
xlabel('x')
ylabel('F(x)')
title('CDF of X')