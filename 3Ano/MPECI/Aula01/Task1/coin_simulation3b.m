p = 0.5;
n = 100;
Nexp = 100000;

probabilities = zeros(1,n+1);

for k = 0:n
    probabilities(k+1) = binomialMonteCarlo(p,n,k,Nexp)
end

stem(0:n, probabilities)
title('Monte Carlo Estimate - n = 100')
xlabel('Number of Heads')
ylabel('Estimated Probability')
