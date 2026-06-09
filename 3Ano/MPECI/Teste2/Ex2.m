lam = [1/(1.5*365), 1/(0.5*365), 1/60];
mu  = [1/2, 6, 24];

Q = [-sum(lam) lam;
      mu(1) -mu(1) 0 0;
      mu(2) 0 -mu(2) 0;
      mu(3) 0 0 -mu(3)];

pii = [Q'; ones(1,4)] \ [0;0;0;0;1];

fprintf('Availability = %.4f %%\n', pii(1)*100);

fprintf('VM unavailable = %.2f h/year\n', pii(4)*365*24);

fprintf('Server MTBF = %.1f days\n', 1/sum(lam));

mttr_h = [48, 4, 1];
fprintf('Server MTTR = %.2f h\n', sum(lam.*mttr_h)/sum(lam));
