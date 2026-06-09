%% =========================================================================
%  MPECI 2025/2026 - PRACTICAL GUIDE 2 - FULL SOLUTIONS & EXAM NOTES
%  Métodos Probabilísticos para Engenharia de Computadores e Informática
%  University of Aveiro - DETI
% =========================================================================
%
%  DISTRIBUTIONS COVERED:
%    - Uniform (discrete)    PMF: p(x)=1/n
%    - Binomial              PMF: C(n,k)*p^k*(1-p)^(n-k)  E=np    Var=np(1-p)
%    - Geometric             PMF: (1-p)^(k-1)*p            E=1/p   Var=(1-p)/p^2
%    - Poisson               PMF: e^(-L)*L^k/k!            E=L     Var=L
%    - Exponential (cont.)   PDF: L*e^(-Lx)                E=1/L   Var=1/L^2
%    - Gaussian/Normal(cont) PDF: (1/s*sqrt(2pi))*e^(...)  E=mu    Var=s^2
%
%  KEY MATLAB FUNCTIONS (all distributions):
%    poisspdf(k, L)       Poisson PMF at k
%    poisscdf(k, L)       Poisson CDF up to k
%    poissrnd(L, r, c)    Poisson random samples
%    exppdf(x, 1/L)       Exponential PDF  *** MATLAB uses MEAN=1/L, not rate L ***
%    exprnd(1/L, r, c)    Exponential random samples
%    normcdf(x, mu, s)    Gaussian CDF
%    randn(r, c)          Standard Normal N(0,1) samples
%    nchoosek(n, k)       Binomial coefficient C(n,k)
%
%  EXAM REMINDER - E[X] and Var[X] from PMF:
%    E[X]   = sum(x .* p)
%    E[X^2] = sum(x.^2 .* p)
%    Var[X] = E[X^2] - E[X]^2
%
% =========================================================================


%% =========================================================================
%  TASK 1 - Discrete Random Variables (theory questions)
%% =========================================================================

%% ---- T1 Q1: Fair 6-sided die -------------------------------------------
%
% X in {1,2,3,4,5,6}, each with probability 1/6
%
% PMF:  p(x) = 1/6 for x = 1..6
% CDF:  F(k) = k/6 for integer k in 1..6
% E[X]   = (1+2+3+4+5+6)/6 = 3.5
% Var[X] = E[X^2] - E[X]^2 = 91/6 - 12.25 = 35/12 ≈ 2.9167
%
% P(X>=4) = 3/6 = 0.5
% P(X=3|X<5) = P(X=3 AND X<5) / P(X<5) = (1/6) / (4/6) = 1/4 = 0.25

x_die = 1:6;
p_die = ones(1,6)/6;
F_die = cumsum(p_die);

EX_die   = sum(x_die .* p_die);
Var_die  = sum(x_die.^2 .* p_die) - EX_die^2;
P_ge4    = sum(p_die(x_die >= 4));
P_X3_lt5 = p_die(3) / sum(p_die(x_die < 5));

fprintf('=== T1 Q1: Fair Die ===\n');
fprintf('  E[X]        = %.4f  (exact: 3.5)\n',        EX_die);
fprintf('  Var[X]      = %.4f  (exact: 35/12=%.4f)\n', Var_die, 35/12);
fprintf('  P(X>=4)     = %.4f  (exact: 0.5)\n',        P_ge4);
fprintf('  P(X=3|X<5) = %.4f  (exact: 0.25)\n\n',     P_X3_lt5);


%% ---- T1 Q2: Geometric distribution (p = 0.3) ---------------------------
%
% X = number of trials until FIRST success, X in {1, 2, 3, ...}
% PMF:  P(X=k) = (1-p)^(k-1) * p
% CDF:  F(k)   = 1 - (1-p)^k
% E[X]   = 1/p
% Var[X] = (1-p)/p^2
%
% MEMORYLESS PROPERTY (exam classic):
%   P(X > s+t | X > t) = P(X > s)   for all s,t >= 0
%   "Past failures carry no information about future trials"
%
% P(X>3)      = (1-p)^3 = 0.7^3 = 0.343
% P(X>3|X>1)  = P(X>3)/P(X>1) = 0.7^3/0.7^1 = 0.7^2 = 0.49
% P(X>2)      = 0.7^2 = 0.49  -> same! confirms memoryless property

p_geo = 0.3;
k_geo = 1:20;
pmf_geo = (1-p_geo).^(k_geo-1) * p_geo;
cdf_geo = 1 - (1-p_geo).^k_geo;

EX_geo    = 1/p_geo;
Var_geo   = (1-p_geo)/p_geo^2;
P_Xgt3    = (1-p_geo)^3;
P_Xgt3_given_Xgt1 = P_Xgt3 / (1-p_geo)^1;
P_Xgt2    = (1-p_geo)^2;

fprintf('=== T1 Q2: Geometric (p=0.3) ===\n');
fprintf('  E[X]              = %.4f  (exact: %.4f)\n', EX_geo, 1/p_geo);
fprintf('  Var[X]            = %.4f  (exact: %.4f)\n', Var_geo, (1-p_geo)/p_geo^2);
fprintf('  P(X>3)            = %.4f  (exact: 0.343)\n', P_Xgt3);
fprintf('  P(X>3|X>1)        = %.4f\n', P_Xgt3_given_Xgt1);
fprintf('  P(X>2)            = %.4f  <- same -> MEMORYLESS confirmed\n\n', P_Xgt2);

figure('Name','T1 Q2 - Geometric PMF and CDF');
subplot(1,2,1);
stem(k_geo, pmf_geo, 'filled');
xlabel('k'); ylabel('P(X=k)'); title('PMF - Geometric(p=0.3)'); grid on;
subplot(1,2,2);
stem(k_geo, cdf_geo, 'filled');
xlabel('k'); ylabel('F(k)'); title('CDF - Geometric(p=0.3)'); grid on;


%% ---- T1 Q3: Poisson distribution (lambda = 3) --------------------------
%
% PMF:  P(X=k) = e^(-L) * L^k / k!
% E[X] = L,  Var[X] = L   <- mean equals variance (exam favourite!)
%
% P(X=0) = e^(-3) ≈ 0.0498
% P(X>5) = 1 - poisscdf(5, 3)

L3 = 3;
k_pois = 0:15;
pmf_pois3 = poisspdf(k_pois, L3);
cdf_pois3 = poisscdf(k_pois, L3);

P_X0_L3   = poisspdf(0, L3);
P_Xgt5_L3 = 1 - poisscdf(5, L3);

fprintf('=== T1 Q3: Poisson (lambda=3) ===\n');
fprintf('  E[X] = Var[X] = lambda = 3  (always true for Poisson)\n');
fprintf('  P(X=0) = %.4f  (exact: e^-3=%.4f)\n', P_X0_L3, exp(-3));
fprintf('  P(X>5) = %.4f\n\n', P_Xgt5_L3);

figure('Name','T1 Q3 - Poisson PMF and CDF');
subplot(1,2,1);
stem(k_pois, pmf_pois3, 'filled');
xlabel('k'); ylabel('P(X=k)'); title('PMF - Poisson(lambda=3)'); grid on;
subplot(1,2,2);
stairs([k_pois k_pois(end)+1], [cdf_pois3 1], 'LineWidth', 1.5);
xlabel('k'); ylabel('F(k)'); title('CDF - Poisson(lambda=3)'); grid on;


%% ---- T1 Q4: Poisson - Packet errors (lambda = 2) -----------------------
%
% lambda = 2 errors per packet on average
% (a) P(0 errors)  = e^(-2)
% (b) P(>3 errors) = 1 - poisscdf(3, 2)
% (c) E[errors]    = lambda = 2
% (d) 1000 * P(0 errors) expected packets with zero errors

L_pkt = 2;
P0_pkt    = poisspdf(0, L_pkt);
Pgt3_pkt  = 1 - poisscdf(3, L_pkt);

fprintf('=== T1 Q4: Poisson Packet Errors (lambda=2) ===\n');
fprintf('  P(0 errors)            = %.4f  (e^-2 = %.4f)\n', P0_pkt, exp(-2));
fprintf('  P(>3 errors)           = %.4f\n', Pgt3_pkt);
fprintf('  E[errors per packet]   = %.0f\n', L_pkt);
fprintf('  Expected 0-error pkts  = %.1f out of 1000\n\n', 1000*P0_pkt);


%% ---- T1 Q5: Custom die game - PMF of score Y ---------------------------
%
% Die outcome -> score Y:
%   Roll 1       -> Y = -4   P(Y=-4) = 1/6
%   Roll 2 or 3  -> Y =  0   P(Y= 0) = 2/6
%   Roll 4 or 5  -> Y =  2   P(Y= 2) = 2/6
%   Roll 6       -> Y =  6   P(Y= 6) = 1/6
%
% E[Y] = (-4)(1/6) + (0)(2/6) + (2)(2/6) + (6)(1/6) = 6/6 = 1
% E[Y^2] = (16)(1/6) + (0)(2/6) + (4)(2/6) + (36)(1/6) = 60/6 = 10
% Var[Y] = 10 - 1^2 = 9
%
% E[Y] = 1 != 0 -> NOT a fair game
% Expected total after 100 games = 100 * E[Y] = +100 points

y_vals = [-4,  0,  2,  6];
p_Y    = [1/6, 2/6, 2/6, 1/6];

EY   = sum(y_vals .* p_Y);
VarY = sum(y_vals.^2 .* p_Y) - EY^2;

fprintf('=== T1 Q5: Die Game ===\n');
fprintf('  E[Y]              = %.4f  (exact: 1)\n',  EY);
fprintf('  Var[Y]            = %.4f  (exact: 9)\n',  VarY);
fprintf('  Fair game?        NO  (need E[Y]=0)\n');
fprintf('  Expected gain/100 = +%.0f points\n\n', 100*EY);


%% =========================================================================
%  TASK 2 - Lab exercises
%% =========================================================================

%% ---- T2 Q1: Die PMF and CDF plots (stem + stairs) ----------------------

figure('Name','T2 Q1 - Die PMF and CDF');
subplot(1,2,1);
stem(x_die, p_die, 'filled', 'LineWidth', 1.5);
xlabel('x'); ylabel('Prob. mass function of x');
title('1(a) PMF'); xlim([0 7]); ylim([0 0.25]); grid on;

subplot(1,2,2);
stairs([0 x_die 7], [0 F_die 1], 'LineWidth', 1.5);
xlabel('x'); ylabel('Cumulative distribution function of x');
title('1(b) CDF'); xlim([0 7]); ylim([0 1.1]); grid on;


%% ---- T2 Q2: Banknote box -----------------------------------------------
%
% Box contents: 90x5EUR + 9x10EUR + 1x100EUR = 100 notes total
%
% Sample space (elementary experiment = pick 1 note):
%   Omega = {note_1, ..., note_100}, each with P = 1/100
%
% Random variable X = face value of drawn note:
%   X in {5, 10, 100}
%   P(X=5)   = 90/100 = 0.90
%   P(X=10)  =  9/100 = 0.09
%   P(X=100) =  1/100 = 0.01
%
% CDF:
%   F(x) = 0     for x < 5
%   F(x) = 0.90  for 5  <= x < 10
%   F(x) = 0.99  for 10 <= x < 100
%   F(x) = 1.00  for x >= 100

x_notes = [5,    10,   100];
p_notes = [0.90, 0.09, 0.01];
F_notes = cumsum(p_notes);

EX_notes  = sum(x_notes .* p_notes);
Var_notes = sum(x_notes.^2 .* p_notes) - EX_notes^2;

fprintf('=== T2 Q2: Banknote Box ===\n');
fprintf('  E[X]   = %.2f EUR\n', EX_notes);
fprintf('  Var[X] = %.2f\n\n', Var_notes);

figure('Name','T2 Q2 - Banknote CDF');
stairs([0 x_notes 110], [0 F_notes 1], 'LineWidth', 2);
xlabel('Banknote value (EUR)'); ylabel('F_X(x)');
title('CDF - Banknote Box (EUR)'); grid on;
xticks([0 5 10 100]); ylim([0 1.1]);


%% ---- T2 Q3: Binomial - 4 coin tosses -----------------------------------
%
% X = number of heads in n=4 tosses of a fair coin
% X ~ Binomial(n=4, p=0.5)
% PMF: P(X=k) = C(4,k) * (0.5)^4  for k = 0,1,2,3,4
% E[X]   = n*p = 2
% Var[X] = n*p*(1-p) = 1
%
% (f) Key probabilities:
%   P(X>=2) = 1 - P(0) - P(1) = 1 - 1/16 - 4/16 = 11/16 = 0.6875
%   P(X<=1) = P(0) + P(1)     = 5/16 = 0.3125
%   P(1<=X<=3) = P(1)+P(2)+P(3) = 14/16 = 0.875

n_c = 4; p_c = 0.5; N = 1e5;
k_c = 0:n_c;

% Simulation
tosses_c = rand(n_c, N) < p_c;
heads_c  = sum(tosses_c);
pmf_sim_c = arrayfun(@(k) sum(heads_c==k)/N, k_c);

% Analytical
pmf_ana_c = arrayfun(@(k) nchoosek(n_c,k)*p_c^k*(1-p_c)^(n_c-k), k_c);

% Stats from simulation
EX_sim_c  = sum(k_c .* pmf_sim_c);
Var_sim_c = sum((k_c - EX_sim_c).^2 .* pmf_sim_c);

% Probabilities from analytical PMF
P_ge2_c  = sum(pmf_ana_c(k_c >= 2));
P_le1_c  = sum(pmf_ana_c(k_c <= 1));
P_1to3_c = sum(pmf_ana_c(k_c >= 1 & k_c <= 3));

fprintf('=== T2 Q3: Binomial (n=4, p=0.5) ===\n');
fprintf('  Sim:  E[X]=%.4f  Var=%.4f  std=%.4f\n', EX_sim_c, Var_sim_c, sqrt(Var_sim_c));
fprintf('  Ana:  E[X]=%.4f  Var=%.4f  std=%.4f\n', n_c*p_c, n_c*p_c*(1-p_c), sqrt(n_c*p_c*(1-p_c)));
fprintf('  PMF comparison:\n');
fprintf('    k   Sim      Ana\n');
for k = k_c
    fprintf('    %d   %.4f   %.4f\n', k, pmf_sim_c(k+1), pmf_ana_c(k+1));
end
fprintf('  P(X>=2)    = %.4f  (exact: 11/16=%.4f)\n', P_ge2_c,  11/16);
fprintf('  P(X<=1)    = %.4f  (exact:  5/16=%.4f)\n', P_le1_c,   5/16);
fprintf('  P(1<=X<=3) = %.4f  (exact: 14/16=%.4f)\n\n', P_1to3_c, 14/16);

figure('Name','T2 Q3 - Binomial PMF comparison');
stem(k_c-0.1, pmf_sim_c, 'b', 'filled'); hold on;
stem(k_c+0.1, pmf_ana_c, 'r', 'filled');
legend('Simulated','Analytical');
xlabel('k'); ylabel('P(X=k)');
title('Binomial(4, 0.5) - Simulation vs Analytical');
grid on; hold off;


%% ---- T2 Q4 (Optional): Defective parts (Binomial p=0.3, n=5) ----------

p_d = 0.3; n_d = 5; N = 1e5;
k_d = 0:n_d;
defects = sum(rand(n_d, N) < p_d);

pmf_sim_d = arrayfun(@(k) sum(defects==k)/N, k_d);
pmf_ana_d = arrayfun(@(k) nchoosek(n_d,k)*p_d^k*(1-p_d)^(n_d-k), k_d);
cdf_ana_d = cumsum(pmf_ana_d);

P_le2_sim_d = sum(defects <= 2) / N;
P_le2_ana_d = sum(pmf_ana_d(k_d <= 2));

fprintf('=== T2 Q4: Defective Parts (n=5, p=0.3) ===\n');
fprintf('  P(X<=2) sim = %.4f  ana = %.4f\n\n', P_le2_sim_d, P_le2_ana_d);

figure('Name','T2 Q4 - Defective Parts CDF');
stairs([-1 k_d n_d+1], [0 cdf_ana_d 1], 'LineWidth', 2);
xlabel('k (defective parts)'); ylabel('F(k)');
title('CDF - Defective Parts (n=5, p=0.3)'); grid on;


%% ---- T2 Q5 (Optional): 2-engine vs 4-engine plane crash ---------------
%
% Rule: plane crashes if MORE THAN HALF of engines fail
%   2 engines: crash if >= 2 fail  ->  P_crash2 = p^2
%   4 engines: crash if >= 3 fail  ->  P_crash4 = C(4,3)*p^3*(1-p) + p^4
%
% CONCLUSION: For p < 0.5 (realistic), P_crash2 < P_crash4
%   -> Prefer 2-engine plane for any realistic failure probability

p_range  = logspace(-3, log10(0.5), 300);
P_crash2 = p_range.^2;
P_crash4 = 4*p_range.^3.*(1-p_range) + p_range.^4;

fprintf('=== T2 Q5: 2 vs 4 Engine Plane ===\n');
fprintf('  For p < 0.5: 2-engine plane is SAFER\n');
fprintf('  Crossover exactly at p = 0.5\n\n');

figure('Name','T2 Q5 - Plane Crash Probability');
loglog(p_range, P_crash2, 'b-', 'LineWidth', 2); hold on;
loglog(p_range, P_crash4, 'r-', 'LineWidth', 2);
legend('2 engines','4 engines','Location','northwest');
xlabel('p (engine failure probability)'); ylabel('P(crash)');
title('Crash probability: 2-engine vs 4-engine plane');
grid on; hold off;


%% ---- T2 Q6: Binomial -> Poisson approximation (BER) -------------------
%
% Poisson is a good approximation to Binomial when:
%   n is large, p is small, and lambda = n*p stays constant
%
% (a) 100 bytes = 800 bits, BER=1e-5, lambda = 800*1e-5 = 0.008
%     P(0 errors): Binomial = (1-BER)^800, Poisson = e^(-0.008)
%
% (b) 1000 bytes = 8000 bits, lambda = 8000*1e-5 = 0.08
%     P(>=2 errors) = 1 - P(0) - P(1)
%     Both methods give essentially identical results

BER = 1e-5;

% (a)
n_a   = 100*8; L_a = n_a*BER;
P0_bi_a  = (1-BER)^n_a;
P0_po_a  = exp(-L_a);

% (b)
n_b   = 1000*8; L_b = n_b*BER;
Pge2_bi_b = 1 - (1-BER)^n_b - n_b*BER*(1-BER)^(n_b-1);
Pge2_po_b = 1 - poisscdf(1, L_b);

fprintf('=== T2 Q6: Binomial vs Poisson (BER=1e-5) ===\n');
fprintf('  (a) 100B  | Binomial: %.8f  Poisson: %.8f\n', P0_bi_a,   P0_po_a);
fprintf('  (b) 1000B | Binomial: %.8f  Poisson: %.8f\n\n', Pge2_bi_b, Pge2_po_b);


%% ---- T2 Q7: Poisson email server (lambda=5 msg/s) ----------------------
%
% Rate = 5 messages/second
% KEY: scale lambda by the time window!
%   2-second window: lambda = 5*2 = 10
%   5-second window: lambda = 5*5 = 25
%
% (a) P(X < 10 in 2s) = poisscdf(9, 10)
% (b) P(X > 30 in 5s) = 1 - poisscdf(30, 25)

L_s = 5;
N_p = 1e5;

L_2s = L_s * 2;
msgs_2s    = poissrnd(L_2s, 1, N_p);
P_lt10_sim = sum(msgs_2s < 10) / N_p;
P_lt10_ana = poisscdf(9, L_2s);

L_5s = L_s * 5;
msgs_5s    = poissrnd(L_5s, 1, N_p);
P_gt30_sim = sum(msgs_5s > 30) / N_p;
P_gt30_ana = 1 - poisscdf(30, L_5s);

fprintf('=== T2 Q7: Poisson Email Server ===\n');
fprintf('  (a) P(<10 in 2s)  Sim=%.4f  Ana=%.4f  [lambda=%.0f]\n', P_lt10_sim, P_lt10_ana, L_2s);
fprintf('  (b) P(>30 in 5s)  Sim=%.4f  Ana=%.4f  [lambda=%.0f]\n\n', P_gt30_sim, P_gt30_ana, L_5s);


%% ---- T2 Q8: Exponential distribution (lambda=1) -----------------------
%
% PDF: f(x) = lambda * e^(-lambda*x) for x >= 0
% E[X] = 1/lambda,  Var[X] = 1/lambda^2
%
% *** IMPORTANT MATLAB NOTE ***
% exppdf(x, mu) and exprnd(mu) use mu = MEAN = 1/lambda (NOT the rate)
% For lambda=1:   use exppdf(x, 1)   -> mean=1
% For lambda=0.2: use exppdf(x, 5)   -> mean=5

L8 = 1; mu8 = 1/L8;
x_e = 0:0.1:10;

figure('Name','T2 Q8 - Exponential(lambda=1)');
subplot(1,2,1);
plot(x_e, exppdf(x_e, mu8), 'LineWidth', 2);
xlabel('x'); ylabel('f_X(x)');
title('PDF - Exponential(\lambda=1)'); grid on;

samples_e8 = exprnd(mu8, 1, 1e5);
subplot(1,2,2);
histogram(samples_e8, 100, 'Normalization', 'pdf'); hold on;
plot(x_e, exppdf(x_e, mu8), 'r-', 'LineWidth', 2);
legend('Histogram (10^5 samples)','Theoretical PDF');
xlabel('x'); ylabel('Density');
title('Exponential(\lambda=1): histogram vs PDF');
grid on; hold off;


%% ---- T2 Q9: Exponential memoryless property (lambda=0.2) --------------
%
% MEMORYLESS PROPERTY:
%   P(X > s+t | X > t) = P(X > s)   for all s,t >= 0
%
% Analytical proof:
%   P(X>s+t | X>t) = P(X>s+t) / P(X>t)
%                  = e^(-L(s+t)) / e^(-Lt)
%                  = e^(-Ls) = P(X>s)   confirmed!
%
% With lambda=0.2, s=2, t=3:
%   P(X>5)/P(X>3) = e^(-1.0)/e^(-0.6) = e^(-0.4) = P(X>2)

L9 = 0.2; mu9 = 1/L9;
s = 2; t = 3;

samples_e9 = exprnd(mu9, 1, 1e5);

P_Xgt_spt  = sum(samples_e9 > s+t) / 1e5;
P_Xgt_t    = sum(samples_e9 > t)   / 1e5;
P_Xgt_s    = sum(samples_e9 > s)   / 1e5;
P_cond_sim = P_Xgt_spt / P_Xgt_t;

P_cond_ana = exp(-L9*s);

fprintf('=== T2 Q9: Exponential Memoryless (lambda=0.2) ===\n');
fprintf('  Mean of samples:           %.4f  (exact: 1/L=%.1f)\n', mean(samples_e9), mu9);
fprintf('  P(X>%d+%d | X>%d) sim   = %.4f\n', s, t, t, P_cond_sim);
fprintf('  P(X>%d)          sim   = %.4f\n', s, P_Xgt_s);
fprintf('  P(X>%d)          exact = %.4f  <- should match above\n', s, P_cond_ana);
fprintf('  -> Memoryless property confirmed\n\n');


%% ---- T2 Q10: P(X < Y) = lambdaX/(lambdaX+lambdaY) --------------------
%
% X ~ Exp(lambdaX=0.4),  Y ~ Exp(lambdaY=0.1),  independent
%
% Analytical result: P(X < Y) = lambdaX / (lambdaX + lambdaY)
%   With lambdaX=0.4, lambdaY=0.1: P(X<Y) = 0.4/0.5 = 0.8
%
% Intuition: X fires faster on average (higher rate), so it finishes first more often

LX = 0.4; LY = 0.1; N = 1e5;
X_s = exprnd(1/LX, 1, N);
Y_s = exprnd(1/LY, 1, N);

P_XltY_sim = sum(X_s < Y_s) / N;
P_XltY_ana = LX / (LX + LY);

fprintf('=== T2 Q10: P(X<Y) for two exponentials ===\n');
fprintf('  lambdaX=%.1f, lambdaY=%.1f\n', LX, LY);
fprintf('  P(X<Y) sim   = %.4f\n', P_XltY_sim);
fprintf('  P(X<Y) exact = %.4f  [lambdaX/(lambdaX+lambdaY)=%.1f/%.1f]\n\n', P_XltY_ana, LX, LX+LY);


%% ---- T2 Q11 (Optional): Poisson typos in a 100-page book --------------
%
% lambda = 0.02 typos/page
% Total typos in 100 pages ~ Poisson(lambda_total = 0.02*100 = 2)
% P(at most 1 typo) = poisscdf(1, 2)

L_typo = 0.02 * 100;
P_le1_typo = poisscdf(1, L_typo);

fprintf('=== T2 Q11: Poisson Typos (100 pages) ===\n');
fprintf('  lambda_total = %.1f\n', L_typo);
fprintf('  P(<=1 typo)  = %.4f\n\n', P_le1_typo);


%% ---- T2 Q12: Gaussian - classroom enrolment ----------------------------
%
% X ~ N(mu=100, sigma=10) students
% n practical classes, 20 students each -> capacity = 20*n
% P(n classes enough) = P(X <= 20*n) = normcdf(20*n, 100, 10)
%
% n=5: P(X<=100) = 0.5000   (median = mean for symmetric Gaussian)
% n=6: P(X<=120) = normcdf(120,100,10) ≈ 0.9772  (2 sigma above mean)
% n=7: P(X<=140) = normcdf(140,100,10) ≈ 0.99997 (4 sigma above mean)

mu_cl = 100; sig_cl = 10;
N_cl  = 1e5;
X_cl  = mu_cl + sig_cl * randn(1, N_cl);   % N(100,10) samples

fprintf('=== T2 Q12: Gaussian Classroom (mu=100, sigma=10) ===\n');
fprintf('  n    Simulation    Analytical   [capacity]\n');
for n_cl = [5, 6, 7]
    cap = 20 * n_cl;
    P_sim_cl = sum(X_cl <= cap) / N_cl;
    P_ana_cl = normcdf(cap, mu_cl, sig_cl);
    fprintf('  n=%d  %.4f       %.4f       [%d students]\n', n_cl, P_sim_cl, P_ana_cl, cap);
end
fprintf('\n');


%% ---- T2 Q13: Cookie weights - E[Sn], Var[Sn], Markov, Chebyshev, CLT -
%
% Xi ~ i.i.d., mu=20g, sigma^2=9g^2, sigma=3g
% Sn = X1 + X2 + ... + Xn
%
% (a) E[Sn] = n*mu = 20n
%     Var[Sn] = n*sigma^2 = 9n
%
% (b) MARKOV INEQUALITY:  P(X >= a) <= E[X] / a    (requires X >= 0)
%     P(Xi >= 30) <= 20/30 = 2/3 ≈ 0.667
%     Only uses the mean -> very loose bound
%
% (c) CHEBYSHEV INEQUALITY:  P(|X-mu| >= k) <= sigma^2 / k^2
%     P(|Xi-20| >= 10) <= 9/100 = 0.09
%     Uses mean + variance -> tighter bound
%
% (d) CENTRAL LIMIT THEOREM:
%     S100 ~ N(100*20, 100*9) = N(2000, 900),  std_S = 30
%     P(1970 < S100 < 2030) = P(-1 < Z < 1) ≈ 0.6827
%     This is the "68% rule" (±1 standard deviation)

mu_ck = 20; var_ck = 9; sig_ck = sqrt(var_ck);
n_ck  = 100;

E_Sn    = n_ck * mu_ck;
Var_Sn  = n_ck * var_ck;
std_Sn  = sqrt(Var_Sn);

markov_bound = mu_ck / 30;
cheb_bound   = var_ck / 10^2;

P_clt = normcdf(2030, E_Sn, std_Sn) - normcdf(1970, E_Sn, std_Sn);

fprintf('=== T2 Q13: Cookie Weights ===\n');
fprintf('  (a) E[S100]=%.0fg  Var[S100]=%.0f  std=%.1fg\n', E_Sn, Var_Sn, std_Sn);
fprintf('  (b) Markov:     P(Xi>=30)     <= %.4f  (loose, mean only)\n', markov_bound);
fprintf('  (c) Chebyshev:  P(|Xi-20|>=10)<= %.4f  (tighter, mean+var)\n', cheb_bound);
fprintf('  (d) CLT: P(1970<S100<2030)    = %.4f  (68%% rule = +-1 sigma)\n', P_clt);

% Simulation check for (d)
N_ck_sim = 1e5;
S100_sim = sum(mu_ck + sig_ck*randn(n_ck, N_ck_sim));
P_clt_sim = sum(S100_sim > 1970 & S100_sim < 2030) / N_ck_sim;
fprintf('  (d) Simulation:                 %.4f  (should match above)\n\n', P_clt_sim);
