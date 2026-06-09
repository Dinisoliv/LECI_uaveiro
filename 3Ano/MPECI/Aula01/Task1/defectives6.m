p = 0.1;
n = 5;
Nexp = 100000;

experiments = rand(n, Nexp);
defects = experiments < p;
results = sum(defects);

% Estimate probabilities
probabilities = zeros(1, n+1);

for k = 0:n
    probabilities(k+1) = sum(results == k) / Nexp;
end

stem(0:n, probabilities)
xlabel('Number of defective faucets')
ylabel('Estimated Probability')
title('Estimated Binomial Distribution (n=5, p=0.1)')