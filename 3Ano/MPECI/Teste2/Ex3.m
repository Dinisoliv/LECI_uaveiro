lam    = 1;
M      = 200;
N      = 1e4;
R      = 20;

par = zeros(1,R);
for r = 1:R
    par(r) = SimulatorA(lam, M, N);
end

m = mean(par);
s = std(par);
alpha = 0.10;
t = tinv(1 - alpha/2, R-1);
h = t * s / sqrt(R);


m       % mean
m-h     % low interval
m+h     % high interval