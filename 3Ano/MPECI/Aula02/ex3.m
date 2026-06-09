n = 4;

numExp = 100000;

experiments = rand(n, numExp);

tosses = experiments < 0.5;

X = sum(tosses);

pmf_sim = zeros(1,n+1);

for k = 0:n
    pmf_sim(k+1) = sum(X == k) / numExp;
end

pmf_sim

pmf_theo = binopdf(0:4, 4, 0.5);

pmf_theo

mean_sim = mean(X)
var_sim = var(X)
std_sim = std(X)

