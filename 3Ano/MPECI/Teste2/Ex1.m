pkt = 1200*8;          % bits per packet
mu  = 100e6 / pkt;     % service rate 
lam = 80e6  / pkt;     % arrival rate 
K   = 30;

rho   = lam/mu;
p0    = (1-rho)/(1-rho^(K+1));
p     = p0 * rho.^(0:K);
Ploss = p(end);
L     = sum((0:K).*p);
Wavg  = L / (lam*(1-Ploss)) * 1000;

Pgt6 = sum(p(8:end));   % exercise 2


figure;
bar(0:K, p);
grid on;
xlabel('Queue occupation (number of packets)');
ylabel('Probability');
title('Queue occupation (M/M/1/K, K = 30)');
xlim([-0.5 K+0.5]);
