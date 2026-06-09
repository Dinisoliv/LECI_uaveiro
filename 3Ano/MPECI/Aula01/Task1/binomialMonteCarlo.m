function prob = binomialMonteCarlo(p, numTosses, desiredHeads, numExperiments)
% binomialMonteCarlo estimates Binomial probability via simulation
%
% Inputs:
%   p               - probability of head
%   numTosses       - number of coin tosses
%   desiredHeads    - number of heads of interest
%   numExperiments  - number of Monte Carlo experiments
%
% Output:
%   prob            - estimated probability P(X = desiredHeads)

    % Generate experiments
    experiments = rand(numTosses, numExperiments);
    
    % Convert to heads (1) / tails (0)
    tosses = experiments < p;
    
    % Count heads per experiment
    results = sum(tosses);
    
    % Count successes
    successes = results == desiredHeads;
    
    % Estimate probability
    prob = sum(successes) / numExperiments;
end
