lambda = 25;
Nexp = 100000;

X = poissrnd(lambda,1,Nexp);

prob_sim_b = sum(X > 30) / Nexp

lambda = 25;

prob_b = 1 - poisscdf(30, lambda)