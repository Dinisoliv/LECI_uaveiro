%% =========================================================================
%  MPECI 2025/2026 - PRACTICAL GUIDE 1 - FULL SOLUTIONS & EXAM NOTES
%  Métodos Probabilísticos para Engenharia de Computadores e Informática
%  University of Aveiro - DETI
% =========================================================================
%
%  EXAM THEORY NOTES (read before running code):
%
%  --- BERNOULLI / BINOMIAL DISTRIBUTION ---
%  A Binomial experiment has:
%    (1) n independent repetitions
%    (2) Each trial has 2 outcomes: "success" (prob p) or "failure" (prob 1-p)
%    (3) P(k successes in n trials) = C(n,k) * p^k * (1-p)^(n-k)
%
%  Key Matlab functions:
%    nchoosek(n,k)  → combinatorial C(n,k) = n! / (k!(n-k)!)
%    rand(r,c)      → uniform random matrix in [0,1)
%    sum(v)         → sum; on matrix: col-wise by default
%    sum(v>=k)      → count how many elements satisfy condition
%
%  --- CONDITIONAL PROBABILITY ---
%    P(A|B) = P(A ∩ B) / P(B)
%
%  --- INDEPENDENCE ---
%    A and B are independent iff P(A ∩ B) = P(A)*P(B)
%    Equivalently: P(A|B) = P(A)
%
%  --- TOTAL PROBABILITY & BAYES ---
%    P(B) = Σ P(B|Ai)*P(Ai)            [Total Probability]
%    P(Ai|B) = P(B|Ai)*P(Ai) / P(B)    [Bayes Theorem]
%
% =========================================================================


%% =========================================================================
%  TASK 1 - Simulation of simple random experiments
%% =========================================================================

%% ---- T1 Q1: Coin toss - P(2 heads in 3 tosses) -------------------------
% Analytical: P(2) = C(3,2)*0.5^2*0.5^1 = 3 * 0.25 * 0.5 = 0.375
%
% EXAM TIP: Relative frequency converges to true probability as N→∞
%           (Law of Large Numbers). With N=10000, expect ~2-3% error.

N = 1e4;  % number of experiments (increase for more accuracy)
p = 0.5;  % prob of heads
k = 2;    % desired number of heads
n = 3;    % number of tosses

tosses   = rand(n, N) < p;       % n×N matrix: 1=heads, 0=tails
successes = sum(tosses) == k;    % 1×N: 1 if exactly k heads
probSim_T1Q1 = sum(successes) / N;

probAna_T1Q1 = nchoosek(n,k) * p^k * (1-p)^(n-k);

fprintf('\n--- T1 Q1: P(2 heads in 3 tosses) ---\n');
fprintf('  Simulation : %.4f\n', probSim_T1Q1);
fprintf('  Analytical : %.4f\n', probAna_T1Q1);


%% ---- T1 Q2a: P(6 heads in 15 tosses) -----------------------------------

p=0.5; k=6; n=15; N=1e5;
tosses    = rand(n,N) < p;
probSim_T1Q2a = sum(sum(tosses)==k) / N;
probAna_T1Q2a = nchoosek(n,k)*p^k*(1-p)^(n-k);

fprintf('\n--- T1 Q2a: P(6 heads in 15 tosses) ---\n');
fprintf('  Simulation : %.4f\n', probSim_T1Q2a);
fprintf('  Analytical : %.4f\n', probAna_T1Q2a);


%% ---- T1 Q2b: P(at least 6 heads in 15 tosses) --------------------------
% "At least 6" = sum of P(k) for k=6,7,...,15
% In simulation: check if sum >= 6

p=0.5; n=15; N=1e5;
tosses = rand(n,N) < p;
probSim_T1Q2b = sum(sum(tosses) >= 6) / N;

probAna_T1Q2b = 0;
for k = 6:15
    probAna_T1Q2b = probAna_T1Q2b + nchoosek(n,k)*p^k*(1-p)^(n-k);
end

fprintf('\n--- T1 Q2b: P(>=6 heads in 15 tosses) ---\n');
fprintf('  Simulation : %.4f\n', probSim_T1Q2b);
fprintf('  Analytical : %.4f\n', probAna_T1Q2b);


%% ---- T1 Q3: Reusable function (defined at bottom of file) --------------
% Usage: prob = coinTossSim(p, nTosses, kHeads, N)
% Example:
prob_Q1  = coinTossSim(0.5, 3,  2,  1e5);
prob_Q2a = coinTossSim(0.5, 15, 6,  1e5);
fprintf('\n--- T1 Q3: Using coinTossSim function ---\n');
fprintf('  P(2 in 3)  = %.4f\n', prob_Q1);
fprintf('  P(6 in 15) = %.4f\n', prob_Q2a);


%% ---- T1 Q3b: Probability distribution plots for n=20, 40, 100 ---------
% EXAM TIP: As n increases, Binomial → Normal (Bell curve shape)

figure('Name','Binomial Distributions');
nVals = [20, 40, 100];
for i = 1:3
    n = nVals(i);
    probs = zeros(1, n+1);
    for k = 0:n
        probs(k+1) = coinTossSim(0.5, n, k, 2e4);
    end
    subplot(1,3,i);
    stem(0:n, probs, 'filled');
    xlabel('k (heads)'); ylabel('P(k)');
    title(sprintf('n = %d', n));
    grid on;
end
sgtitle('Binomial Distribution (simulated) for p=0.5');


%% ---- T1 Q4: Analytical calculation and comparison ----------------------
% Formula: P(k) = C(n,k) * p^k * (1-p)^(n-k)
% EXAM: This IS the Binomial PMF (Probability Mass Function)

fprintf('\n--- T1 Q4: Analytical values ---\n');
cases = {0.5,2,3; 0.5,6,15; 0.5,6,15};  % p,k,n
labels = {'P(2 in 3)', 'P(6 in 15)', ''};
p=0.5; k=2; n=3;
a1 = nchoosek(n,k)*p^k*(1-p)^(n-k);
p=0.5; k=6; n=15;
a2 = nchoosek(n,k)*p^k*(1-p)^(n-k);
fprintf('  P(2 in 3)  = %.6f\n', a1);
fprintf('  P(6 in 15) = %.6f\n', a2);


%% ---- T1 Q5: BER (Bit Error Rate) - Data packet reliability -------------
%
% EXAM THEORY NOTES:
%   BER = probability each bit has an error = 1e-5
%   Bits are INDEPENDENT (stated in problem)
%   A packet of L bytes = 8L bits
%
%   (a) P(no errors in 100B packet):
%       100 bytes = 800 bits
%       P(0 errors) = C(800,0)*BER^0*(1-BER)^800 = (1-BER)^800
%
%   (b) P(at least 2 errors in 1000B = 8000 bits):
%       P(>=2) = 1 - P(0) - P(1)
%       P(0) = (1-BER)^8000
%       P(1) = C(8000,1)*BER^1*(1-BER)^7999
%       P(>=2) = 1 - P(0) - P(1)

BER = 1e-5;

% (a) 100 bytes = 800 bits
n_a = 100 * 8;
P0_a = (1 - BER)^n_a;
fprintf('\n--- T1 Q5a: P(no errors | 100B packet) ---\n');
fprintf('  P(0 errors) = (1-BER)^%d = %.6f\n', n_a, P0_a);

% (b) 1000 bytes = 8000 bits, P(>=2 errors)
n_b = 1000 * 8;
P0_b = (1-BER)^n_b;
P1_b = nchoosek(n_b,1) * BER^1 * (1-BER)^(n_b-1);
P_ge2 = 1 - P0_b - P1_b;
fprintf('\n--- T1 Q5b: P(>=2 errors | 1000B packet) ---\n');
fprintf('  P(0 errors) = %.6f\n', P0_b);
fprintf('  P(1 error)  = %.6f\n', P1_b);
fprintf('  P(>=2 err)  = 1 - P(0) - P(1) = %.6f\n', P_ge2);


%% ---- T1 Q6 (Optional): Faucet factory (p_defective = 0.1, sample=5) ---
p_def = 0.1; n_fau = 5; N = 1e5;

% (a) P(exactly 3 defective)
k = 3;
probSim_fau_a = sum(sum(rand(n_fau,N) < p_def) == k) / N;
probAna_fau_a = nchoosek(n_fau,k)*p_def^k*(1-p_def)^(n_fau-k);
fprintf('\n--- T1 Q6a: P(3 defective in 5) ---\n');
fprintf('  Simulation : %.4f | Analytical : %.4f\n', probSim_fau_a, probAna_fau_a);

% (b) P(at most 2 defective) = P(0)+P(1)+P(2)
counts = sum(rand(n_fau,N) < p_def);  % 1×N: defective count per experiment
probSim_fau_b = sum(counts <= 2) / N;
probAna_fau_b = 0;
for k=0:2
    probAna_fau_b = probAna_fau_b + nchoosek(n_fau,k)*p_def^k*(1-p_def)^(n_fau-k);
end
fprintf('--- T1 Q6b: P(<=2 defective in 5) ---\n');
fprintf('  Simulation : %.4f | Analytical : %.4f\n', probSim_fau_b, probAna_fau_b);

% (c) Histogram of distribution
figure('Name','Faucet Defect Distribution');
histogram(counts, -0.5:5.5, 'Normalization','probability');
xlabel('Number of defective faucets'); ylabel('Probability');
title('Defective Faucet Distribution (n=5, p=0.1)');
grid on;


%% =========================================================================
%  TASK 2 - Probability, Conditional Probability, Independence
%% =========================================================================

%% ---- T2 Q1: Families with 2 children -----------------------------------
%
% EXAM THEORY NOTES:
%   Sample space for 2 children: {BB, BG, GB, GG}  (B=boy, G=girl)
%   Each equally likely with prob 0.25
%
%   (a) P(at least 1 boy) = 1 - P(GG) = 1 - 0.25 = 0.75
%
%   (b) Theoretical = 0.75
%
%   (c) P(both boys | at least 1 boy):
%       Conditioning reduces sample space to {BB, BG, GB}
%       P(BB | >=1 boy) = P(BB) / P(>=1 boy) = 0.25/0.75 = 1/3 ≈ 0.333
%
%   (d) P(2nd boy | 1st is boy):
%       Conditioning on 1st=boy → space = {BB, BG}
%       P(BB | 1st=B) = 0.25/0.5 = 0.5
%       → INDEPENDENCE: knowing 1st child's gender doesn't affect 2nd
%
%   KEY EXAM POINT: (c) and (d) give DIFFERENT answers (1/3 vs 1/2)
%   because the conditioning event is different!

N = 1e6;
children = rand(2,N) < 0.5;  % 1=boy, 0=girl; row1=child1, row2=child2

% (a) P(at least 1 boy)
atLeast1Boy = sum(children) >= 1;
prob_T2Q1a_sim = sum(atLeast1Boy) / N;
fprintf('\n--- T2 Q1a: P(>=1 boy in 2 children) ---\n');
fprintf('  Simulation: %.4f | Analytical: %.4f\n', prob_T2Q1a_sim, 0.75);

% (c) P(both boys | at least 1 boy)  → Conditional probability
bothBoys = sum(children) == 2;
prob_T2Q1c_sim = sum(bothBoys & atLeast1Boy) / sum(atLeast1Boy);
fprintf('--- T2 Q1c: P(both boys | >=1 boy) ---\n');
fprintf('  Simulation: %.4f | Analytical: %.4f\n', prob_T2Q1c_sim, 1/3);

% (d) P(2nd boy | 1st is boy)
firstIsBoy  = children(1,:) == 1;
secondIsBoy = children(2,:) == 1;
prob_T2Q1d_sim = sum(firstIsBoy & secondIsBoy) / sum(firstIsBoy);
fprintf('--- T2 Q1d: P(2nd=boy | 1st=boy) ---\n');
fprintf('  Simulation: %.4f | Analytical: 0.5000\n', prob_T2Q1d_sim);
fprintf('  → Events are INDEPENDENT (result = 0.5 = P(boy))\n');

% (e) Family with 5 children: P(exactly 1 more boy | >=1 boy)
% "at least 1 is boy AND exactly 1 total boy"
N=1e5;
children5 = rand(5,N) < 0.5;
boyCount5  = sum(children5);
cond_e     = boyCount5 >= 1;                        % at least 1 boy
event_e    = boyCount5 == 1;                        % exactly 1 boy
prob_T2Q1e = sum(event_e & cond_e) / sum(cond_e);
fprintf('--- T2 Q1e: P(exactly 1 boy | >=1 boy), 5 children ---\n');
fprintf('  Simulation: %.4f\n', prob_T2Q1e);
% Analytical: P(exactly1) / P(>=1) = [C(5,2)*0.5^5] / [1-0.5^5]
ana_e = (nchoosek(5,2)*0.5^5) / (1 - 0.5^5);
fprintf('  Analytical: %.4f\n', ana_e);

% (f) P(at least 1 more boy | >=1 boy) = P(>=2 boys | >=1 boy)
event_f = boyCount5 >= 2;
prob_T2Q1f = sum(event_f & cond_e) / sum(cond_e);
fprintf('--- T2 Q1f: P(>=2 boys | >=1 boy), 5 children ---\n');
fprintf('  Simulation: %.4f\n', prob_T2Q1f);
ana_f_num = 0;
for k=2:5; ana_f_num=ana_f_num+nchoosek(5,k)*0.5^5; end
ana_f = ana_f_num / (1-0.5^5);
fprintf('  Analytical: %.4f\n', ana_f);


%% ---- T2 Q2: Dart throwing game (Birthday-like problem) ----------------
%
% EXAM THEORY NOTES:
%   n darts, m targets; each dart hits a uniformly random target
%   P(no repeats) = m/m * (m-1)/m * (m-2)/m * ... * (m-n+1)/m
%                 = m! / ((m-n)! * m^n)   [if n <= m]
%   P(at least 1 repeat) = 1 - P(no repeats)
%
%   This is analogous to the BIRTHDAY PROBLEM (m=365, n=people)

N = 1e4;
n_darts = 20; m_targets = 100;

% (a) P(no target hit more than once)
noRepeat = 0;
for trial = 1:N
    hits = randi(m_targets, 1, n_darts);  % n random target indices
    if numel(unique(hits)) == n_darts     % all unique → no repeats
        noRepeat = noRepeat + 1;
    end
end
prob_T2Q2a = noRepeat / N;
fprintf('\n--- T2 Q2a: P(no repeats, n=20, m=100) ---\n');
fprintf('  Simulation: %.4f\n', prob_T2Q2a);
% Analytical:
ana_T2Q2a = prod((m_targets-n_darts+1 : m_targets) / m_targets);
fprintf('  Analytical: %.4f\n', ana_T2Q2a);

% (b) P(at least 1 repeat)
fprintf('--- T2 Q2b: P(>=1 repeat) = 1 - P(no repeat) ---\n');
fprintf('  Simulation: %.4f | Analytical: %.4f\n', 1-prob_T2Q2a, 1-ana_T2Q2a);

% (c) Graph: P(>=1 repeat) vs n for m=1000 and m=100000
mVals  = [1000, 100000];
nRange = 10:10:100;
N_sim  = 5000;
figure('Name','Dart Problem - P(at least 1 repeat)');
for mi = 1:2
    m = mVals(mi);
    pRepeat = zeros(size(nRange));
    for ni = 1:length(nRange)
        n = nRange(ni);
        rep = 0;
        for trial=1:N_sim
            hits = randi(m,1,n);
            if numel(unique(hits)) < n; rep=rep+1; end
        end
        pRepeat(ni) = rep/N_sim;
    end
    subplot(1,2,mi);
    plot(nRange, pRepeat, '-o', 'LineWidth', 1.5);
    xlabel('Number of darts (n)'); ylabel('P(>=1 repeat)');
    title(sprintf('m = %d targets', m)); grid on; ylim([0,1]);
end
sgtitle('P(at least 1 target hit twice) vs. number of darts');
% CONCLUSION: More targets → lower collision probability for same n


%% ---- T2 Q4: Birthday Problem -------------------------------------------
%
% EXAM THEORY NOTES:
%   Classic Birthday Problem:
%   P(at least 2 share birthday | n people, 365 days):
%     P(no match) = 365/365 * 364/365 * 363/365 * ... * (365-n+1)/365
%     P(>=1 match) = 1 - P(no match)
%   Answer (a): n=23 gives P>0.5
%   Answer (b): n=41 gives P>0.9

N_bp = 1e4;
thresh_a = 0; thresh_b = 0;
for n = 1:100
    % Analytical (faster than simulation for this)
    pNoMatch = prod((365-n+1:365)/365);
    pMatch   = 1 - pNoMatch;
    if pMatch > 0.5 && thresh_a == 0
        thresh_a = n;
        fprintf('\n--- T2 Q4a: Smallest n with P(same birthday)>0.5 ---\n');
        fprintf('  n = %d, P = %.4f\n', n, pMatch);
    end
    if pMatch > 0.9 && thresh_b == 0
        thresh_b = n;
        fprintf('--- T2 Q4b: Smallest n with P>0.9 ---\n');
        fprintf('  n = %d, P = %.4f\n', n, pMatch);
        break;
    end
end
% Verify Q4a by simulation:
n=23; N_bp=2e4;
matches = 0;
for trial=1:N_bp
    bdays = randi(365,1,n);
    if numel(unique(bdays)) < n; matches=matches+1; end
end
fprintf('  Simulation verification (n=23): P = %.4f\n', matches/N_bp);


%% ---- T2 Q5: Two dice rolled twice --------------------------------------
%
% EXAM THEORY NOTES:
%   Sample space: 36 equally likely outcomes (i,j) where i,j ∈ {1,...,6}
%
%   A = sum = 9:  {(3,6),(4,5),(5,4),(6,3)} → P(A)=4/36=1/9
%   B = 2nd even: {(i,2),(i,4),(i,6)} → P(B)=18/36=1/2
%   C = at least one 5: 36-25=11 outcomes → P(C)=11/36
%   D = no 1s: 5×5=25 outcomes → P(D)=25/36
%
%   INDEPENDENCE CHECK (exam method):
%   A⊥B? P(A∩B) = P(A)*P(B)?
%     A∩B: sum=9 AND 2nd even → {(3,6),(5,4)} → 2/36 = 1/18
%     P(A)*P(B) = (4/36)*(18/36) = 72/1296 = 1/18 ✓ → INDEPENDENT
%
%   C⊥D? P(C∩D) = P(C)*P(D)?
%     C∩D: at least one 5 AND no 1s → both dice in {2,3,4,5,6}, >=1 is 5
%          Total with no 1s: 5×5=25; no 5s AND no 1s: 4×4=16
%          C∩D = 25-16=9 → P(C∩D)=9/36=1/4
%     P(C)*P(D) = (11/36)*(25/36) = 275/1296 ≈ 0.2122 ≠ 0.25
%     → NOT INDEPENDENT

N = 1e6;
dice = randi(6, 2, N);  % row1=die1, row2=die2

% Events
A = (dice(1,:) + dice(2,:)) == 9;
B = mod(dice(2,:),2) == 0;
C = (dice(1,:)==5) | (dice(2,:)==5);
D = (dice(1,:)~=1) & (dice(2,:)~=1);

fprintf('\n--- T2 Q5a: Event probabilities (simulated) ---\n');
fprintf('  P(A) = %.4f  [exact: %.4f]\n', mean(A), 4/36);
fprintf('  P(B) = %.4f  [exact: %.4f]\n', mean(B), 18/36);
fprintf('  P(C) = %.4f  [exact: %.4f]\n', mean(C), 11/36);
fprintf('  P(D) = %.4f  [exact: %.4f]\n', mean(D), 25/36);

fprintf('\n--- T2 Q5b: Independence A and B ---\n');
pAB = mean(A & B);
fprintf('  P(A∩B) = %.4f, P(A)*P(B) = %.4f\n', pAB, mean(A)*mean(B));
fprintf('  → %s\n', ternary(abs(pAB - mean(A)*mean(B))<0.005, 'INDEPENDENT', 'NOT independent'));

fprintf('--- T2 Q5c: Independence C and D ---\n');
pCD = mean(C & D);
fprintf('  P(C∩D) = %.4f, P(C)*P(D) = %.4f\n', pCD, mean(C)*mean(D));
fprintf('  Exact: P(C∩D)=%.4f  P(C)*P(D)=%.4f\n', 9/36, (11/36)*(25/36));
fprintf('  → NOT INDEPENDENT\n');


%% ---- T2 Q6: Wireless link - Total Probability & Bayes ----------------
%
% EXAM THEORY NOTES:
%   Let I = "interference", I' = "normal"
%   P(I) = 0.02,  P(I') = 0.98
%   P(error|I') = 0.001  (0.1%)
%   P(error|I)  = 0.10   (10%)
%
%   (a) Total Probability:
%       P(error) = P(error|I')*P(I') + P(error|I)*P(I)
%                = 0.001*0.98 + 0.10*0.02
%                = 0.00098 + 0.002 = 0.00298
%
%   (b) Bayes Theorem:
%       P(I'|error) = P(error|I')*P(I') / P(error)
%                   = 0.00098 / 0.00298 ≈ 0.3289
%       P(I|error)  = P(error|I)*P(I) / P(error)
%                   = 0.002 / 0.00298 ≈ 0.6711
%
%   INTERPRETATION: Even though interference is rare (2%), when an error
%   occurs, there is a 67% chance the link was under interference!
%   This is a classic Bayes "rare event" paradox.

P_I    = 0.02;  P_nI   = 0.98;
P_e_nI = 0.001; P_e_I  = 0.10;

P_error = P_e_nI*P_nI + P_e_I*P_I;
P_nI_given_error = P_e_nI*P_nI / P_error;
P_I_given_error  = P_e_I*P_I  / P_error;

fprintf('\n--- T2 Q6a: P(error) by Total Probability ---\n');
fprintf('  P(error) = %.6f\n', P_error);

fprintf('--- T2 Q6b: Bayes - P(condition | error) ---\n');
fprintf('  P(normal | error)       = %.4f\n', P_nI_given_error);
fprintf('  P(interference | error) = %.4f\n', P_I_given_error);
fprintf('  Sum check: %.4f (should be 1.0)\n', P_nI_given_error+P_I_given_error);


%% ---- T2 Q7 (Optional): Bayes - Bug in programs -----------------------
%
% EXAM THEORY NOTES - BAYES WITH 3 HYPOTHESES:
%   Programmers: André (A), Bruno (B), Carlos (C)
%   Prior probabilities (proportion of programs):
%     P(A) = 20/100 = 0.20
%     P(B) = 30/100 = 0.30
%     P(C) = 50/100 = 0.50
%   Likelihoods (bug probability per programmer):
%     P(bug|A) = 0.01, P(bug|B) = 0.05, P(bug|C) = 0.001
%
%   P(bug) = P(bug|A)*P(A) + P(bug|B)*P(B) + P(bug|C)*P(C)
%          = 0.01*0.20 + 0.05*0.30 + 0.001*0.50
%          = 0.002 + 0.015 + 0.0005 = 0.0175
%
%   P(Carlos|bug) = P(bug|C)*P(C) / P(bug) = 0.0005/0.0175 ≈ 0.0286
%   P(Bruno|bug)  = 0.015/0.0175 ≈ 0.857  → MOST LIKELY

P_A=0.20; P_B=0.30; P_C=0.50;
P_bug_A=0.01; P_bug_B=0.05; P_bug_C=0.001;

P_bug = P_bug_A*P_A + P_bug_B*P_B + P_bug_C*P_C;
P_A_bug = P_bug_A*P_A / P_bug;
P_B_bug = P_bug_B*P_B / P_bug;
P_C_bug = P_bug_C*P_C / P_bug;

fprintf('\n--- T2 Q7: Bayes - Which programmer wrote the buggy code? ---\n');
fprintf('  P(bug)         = %.6f\n', P_bug);
fprintf('  P(André|bug)   = %.4f\n', P_A_bug);
fprintf('  P(Bruno|bug)   = %.4f  ← Most likely!\n', P_B_bug);
fprintf('  P(Carlos|bug)  = %.4f\n', P_C_bug);
fprintf('  Sum check: %.4f\n', P_A_bug+P_B_bug+P_C_bug);


%% =========================================================================
%  HELPER FUNCTIONS
%% =========================================================================

function prob = coinTossSim(p, nTosses, kHeads, N)
% COINTOSSSIM  Estimate P(exactly kHeads in nTosses) by simulation
%
%   prob = coinTossSim(p, nTosses, kHeads, N)
%
%   Inputs:
%     p       - probability of heads on each toss (e.g., 0.5)
%     nTosses - number of tosses per experiment
%     kHeads  - desired number of heads
%     N       - number of simulation experiments (e.g., 1e5)
%
%   Output:
%     prob    - estimated probability
%
%   Example:
%     p = coinTossSim(0.5, 3, 2, 1e5)  % P(2 heads in 3 tosses)

    tosses = rand(nTosses, N) < p;       % nTosses × N: 1=heads
    prob   = sum(sum(tosses) == kHeads) / N;
end

function out = ternary(cond, a, b)
% Simple ternary helper (not built-in in Matlab)
    if cond; out = a; else; out = b; end
end
