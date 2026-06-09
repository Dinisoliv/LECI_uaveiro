%{
N = 1e5; % number of experiments
p = 0.5; % probability of heads
k = 6; % number of heads
n = 15; % number of tosses

experiments = rand(n,N);

tosses = experiments < 0.5;

results = sum(tosses);

successes = results > 6;        % successes = results == 6;

probSimulation = sum(successes) / N

p = 0.5;
n = 15;
k = 6;
Nexp = 100000;

prob1 = binomialMonteCarlo(p, n, k, Nexp)
%}

p = 0.5;
n = 15;
k = 6;
Nexp = 100000;

prob2 = 0;
for k = 6:n
    prob2 = prob2 + binomialMonteCarlo(p, n, k, Nexp);
end

prob2
