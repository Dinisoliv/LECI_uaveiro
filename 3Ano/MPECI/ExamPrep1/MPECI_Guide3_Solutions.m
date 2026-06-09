%% =========================================================================
%  MPECI 2025/2026 - PRACTICAL GUIDE 3 - FULL SOLUTIONS & EXAM NOTES
%  Métodos Probabilísticos para Engenharia de Computadores e Informática
%  University of Aveiro - DETI
% =========================================================================
%
%  TOPIC: Markov Chains & PageRank
%
%  *** CRITICAL CONVENTION (read before everything else) ***
%  In this guide: t_ij = transition probability FROM state j TO state i
%  This means T is COLUMN-STOCHASTIC: each COLUMN sums to 1
%  State evolution: x_{n+1} = T * x_n   (matrix-vector product)
%  After n steps:   x_n = T^n * x_0
%
%  Compare with the table in Q1 which is written row-wise (from row, to col):
%    Row i = current state, Col j = next state
%    So the TABLE entry (i,j) = P(next=j | now=i) = t_ji in matrix T
%    i.e., T = TRANSPOSE of the table!
%
%  KEY MATLAB OPERATIONS:
%    T^n            matrix power (n steps)
%    T^n * x0       state distribution after n steps
%    eig(T)         eigenvalues; stationary dist = eigenvector for eigenvalue 1
%    sum(T)         column sums (should all be 1 for stochastic T)
%    x = x / sum(x) normalise a vector to sum to 1
%
% =========================================================================


%% =========================================================================
%  Q1 - Weather Markov Chain: Sunny(1), Cloudy(2), Rainy(3)
%% =========================================================================
%
%  TABLE given (row=today, col=tomorrow):
%               Sunny  Cloudy  Rainy
%    Sunny  [   0.7    0.2     0.1  ]
%    Cloudy [   0.2    0.3     0.5  ]
%    Rainy  [   0.3    0.3     0.4  ]
%
%  CONVENTION: t_ij = P(to state i | from state j)
%  So T = TRANSPOSE of the table above
%  Column j of T = probability distribution of next state given current = j

% (a) State transition matrix T
%     T(i,j) = P(go to state i | currently in state j)
%     States: 1=Sunny, 2=Cloudy, 3=Rainy
%     Col 1 = from Sunny:  P(S->S)=0.7, P(S->C)=0.2, P(S->R)=0.3  (read TABLE col-wise)
%
%     From TABLE rows: Sunny->  [0.7, 0.2, 0.1]  becomes COL 1 of T
%                      Cloudy-> [0.2, 0.3, 0.5]  becomes COL 2 of T
%                      Rainy->  [0.3, 0.3, 0.4]  becomes COL 3 of T

T_weather = [0.7  0.2  0.3;   % row=Sunny:   P(->Sunny   | from S/C/R)
             0.2  0.3  0.3;   % row=Cloudy:  P(->Cloudy  | from S/C/R)
             0.1  0.5  0.4];  % row=Rainy:   P(->Rainy   | from S/C/R)

% Verify column sums = 1 (stochastic matrix check)
fprintf('=== Q1: Weather Markov Chain ===\n');
fprintf('Column sums of T: [%.1f %.1f %.1f] (all must = 1)\n\n', sum(T_weather));

% (b) P(day2=Sunny AND day3=Sunny | day1=Sunny)
%     = P(day2=Sunny|day1=Sunny) * P(day3=Sunny|day2=Sunny)
%     = T(1,1) * T(1,1) = 0.7 * 0.7 = 0.49
%     Alternatively: (T^2)(1,1) = element [Sunny,Sunny] of T^2
%
%     With state vector: x0=[1;0;0] (sunny), x1=T*x0, x2=T*x1
%     P(day2=S,day3=S|day1=S) = T(1,1)*T(1,1) -- both must be sunny

x0_sunny = [1; 0; 0];   % initial state: Sunny
T2 = T_weather^2;
P_b = T_weather(1,1) * T_weather(1,1);   % P(S->S) * P(S->S)
fprintf('(b) P(day2=Sunny AND day3=Sunny | day1=Sunny):\n');
fprintf('    = T(1,1)*T(1,1) = %.4f * %.4f = %.4f\n\n', T_weather(1,1), T_weather(1,1), P_b);

% (c) P(both weekend days sunny | day1=Rainy)
%     January 1st = Wednesday -> weekend = Saturday(day6) and Sunday(day7)
%     Need: P(day6=S AND day7=S | day1=Rainy)
%
%     Step 1: state after 5 steps from Rainy = T^5 * [0;0;1]
%     Step 2: P(day6=S) = (T^5 * x0_rainy)(1)
%     Step 3: P(day7=S | day6=S) = T(1,1) = 0.7
%     Step 4: multiply

x0_rainy = [0; 0; 1];   % initial state: Rainy
T5 = T_weather^5;
x5 = T5 * x0_rainy;     % distribution on day 6 (5 steps from day 1)
P_day6_sunny = x5(1);   % P(day6 = Sunny | day1 = Rainy)
P_day7_sunny_given_day6_sunny = T_weather(1,1);  % T(S->S) = 0.7

P_c = P_day6_sunny * P_day7_sunny_given_day6_sunny;
fprintf('(c) P(day6=S AND day7=S | day1=Rainy):\n');
fprintf('    P(day6=S | day1=R)      = %.4f  [T^5 * x0_rainy, Sunny component]\n', P_day6_sunny);
fprintf('    P(day7=S | day6=S)      = %.4f  [T(1,1)]\n', P_day7_sunny_given_day6_sunny);
fprintf('    Joint probability       = %.4f\n\n', P_c);

% (d) Expected days of each type in January (31 days) starting Sunny
%     E[days in state s] = sum over n=1..31 of P(day_n = s | day1 = start)
%     = sum of state-distribution vectors for each day

n_jan = 31;   % January has 31 days

expected_sunny = zeros(1, 3);   % [Sunny, Cloudy, Rainy]
x = x0_sunny;
for day = 1:n_jan
    expected_sunny = expected_sunny + x';
    x = T_weather * x;
end

fprintf('(d) Expected days in January starting SUNNY:\n');
fprintf('    Sunny: %.2f  Cloudy: %.2f  Rainy: %.2f  (total: %.2f)\n\n', ...
    expected_sunny(1), expected_sunny(2), expected_sunny(3), sum(expected_sunny));

% (e) Same but starting Rainy - compare with (d)
expected_rainy = zeros(1, 3);
x = x0_rainy;
for day = 1:n_jan
    expected_rainy = expected_rainy + x';
    x = T_weather * x;
end

fprintf('(e) Expected days in January starting RAINY:\n');
fprintf('    Sunny: %.2f  Cloudy: %.2f  Rainy: %.2f  (total: %.2f)\n', ...
    expected_rainy(1), expected_rainy(2), expected_rainy(3), sum(expected_rainy));
fprintf('    Difference vs (d): [%.2f  %.2f  %.2f]\n', ...
    expected_rainy - expected_sunny);
fprintf('    CONCLUSION: After many steps, the chain converges to stationary\n');
fprintf('    distribution regardless of starting state. Differences are small.\n\n');

% (f) Expected rheumatic pain days in January
%     P(pain | Sunny)=0.1, P(pain | Cloudy)=0.3, P(pain | Rainy)=0.5
p_pain = [0.1; 0.3; 0.5];

% E[pain days] = sum over days of P(pain on day n)
%              = sum over days of p_pain' * x_n
pain_sunny = 0;  x = x0_sunny;
pain_rainy = 0;  xr = x0_rainy;
for day = 1:n_jan
    pain_sunny = pain_sunny + p_pain' * x;
    pain_rainy = pain_rainy + p_pain' * xr;
    x  = T_weather * x;
    xr = T_weather * xr;
end

fprintf('(f) Expected rheumatic pain days in January:\n');
fprintf('    Starting Sunny: %.2f days\n', pain_sunny);
fprintf('    Starting Rainy: %.2f days\n\n', pain_rainy);


%% =========================================================================
%  Q2 (Optional) - Student group exchanges: A(1), B(2), C(3)
%% =========================================================================
%
%  Movements per class:
%    From A: 1/3 -> B, 1/3 -> C, 1/3 stays in A  (1 - 1/3 - 1/3 = 1/3)
%    From B: 1/4 -> A, 1/5 -> C, rest stays in B  (1 - 1/4 - 1/5 = 11/20)
%    From C: 1/2 -> B, 1/2 stays in C
%
%  T(i,j) = fraction of group j that moves to group i

T_groups = [1/3   1/4   0  ;   % row A: fraction of A/B/C that goes to A
            1/3   11/20 1/2;   % row B: fraction of A/B/C that goes to B
            1/3   1/5   1/2];  % row C: fraction of A/B/C that goes to C

fprintf('=== Q2: Student Group Exchanges ===\n');
fprintf('Column sums of T_groups: [%.4f %.4f %.4f] (should all = 1)\n', sum(T_groups));

% (b) Initial state: 90 students total
%     Group A = 2*(B+C), B=C => A=2*2B=4B, and A+B+C=90 => 4B+2B=90 => B=15
%     A=60, B=15, C=15
x0_groups = [60; 15; 15];
fprintf('Initial state: A=%d, B=%d, C=%d (total=%d)\n', ...
    x0_groups(1), x0_groups(2), x0_groups(3), sum(x0_groups));

% (c) State after 30 classes
x30_groups = T_groups^30 * x0_groups;
fprintf('After 30 classes (initial A=60,B=15,C=15):\n');
fprintf('  A=%.2f, B=%.2f, C=%.2f\n', x30_groups(1), x30_groups(2), x30_groups(3));

% (d) Equal initial distribution: 30 each
x0_equal = [30; 30; 30];
x30_equal = T_groups^30 * x0_equal;
fprintf('After 30 classes (initial 30,30,30):\n');
fprintf('  A=%.2f, B=%.2f, C=%.2f\n', x30_equal(1), x30_equal(2), x30_equal(3));
fprintf('CONCLUSION: Both converge to same distribution proportions (stationary).\n\n');


%% =========================================================================
%  Q3 - 4-state Markov Chain (A, B, C, D) with p=0.4, q=0.6
%% =========================================================================
%
%  From the diagram (states A=1, B=2, C=3, D=4):
%    From A: -> A with p^2, -> B with (1-p)^2, -> C with p(1-p), -> D with p(1-p)
%    From B: -> D with q(1-q),  -> (implicit self or other -- see diagram)
%    From C: -> D with q^2,     -> (see diagram)
%    From D: -> D with (1-q)^2, -> B with q(1-q), -> C with q(1-q)
%
%  Reading diagram carefully (p=0.4, q=0.6):
%    A -> A: p^2 = 0.16
%    A -> B: (1-p)^2 = 0.36
%    A -> C: p(1-p) = 0.24
%    A -> D: p(1-p) = 0.24   [check: 0.16+0.36+0.24+0.24=1 ✓]
%
%    B -> D: q(1-q) = 0.24   (B goes to D only based on diagram label)
%    B -> D: 1*q(1-q)... re-reading: from B there is label q(1-q)->D and 1->D
%    Diagram shows B->D: q(1-q)=0.24, and the "1" on D->D means self-loop weight
%
%  Careful reading of diagram:
%    From A: to A=p^2, to B=(1-p)^2, to C=p(1-p), to D=p(1-p)
%    From B: to D=q(1-q), remainder to... B has only one outgoing shown -> D
%            Actually B->D with q(1-q) and B->D with 1? No.
%            Reading again: B->D: q(1-q), the "1" is on the D self-loop
%    From C: to D=q^2, the p(1-p) from A->C and label on C side
%    From D: to D=(1-q)^2, to B=q(1-q), to C=q(1-q)
%
%  Final reading (most consistent with diagram labels):
%    A -> A: p^2,       A -> B: (1-p)^2, A -> C: p(1-p), A -> D: p(1-p)
%    B -> D: 1          (B only goes to D, prob=1 ... but q(1-q) label)
%    Actually: B->D: q(1-q) AND B->? for remainder. With only 1 arrow from B:
%    B -> D: q(1-q) + ... Let's use: B->D = 1 (absorbing transition to D)
%    More likely: B->D: q(1-q), B->A or B->B for rest. Given symmetry:
%    Most natural 4-state interpretation:
%    B -> D: q(1-q),   B -> B: 1-q(1-q)   [B can stay or go to D]
%    C -> D: q^2,      C -> C: 1-q^2      [C can stay or go to D]
%    D -> D: (1-q)^2,  D -> B: q(1-q),    D -> C: q(1-q), D->D includes self
%
%  Normalised interpretation that makes all columns sum to 1:
p = 0.4; q = 0.6;

% Col 1 = from A, Col 2 = from B, Col 3 = from C, Col 4 = from D
% Row order: A=1, B=2, C=3, D=4
T_abcd = [p^2,        0,           0,           0;          % to A
          (1-p)^2,    1-q*(1-q),   0,           q*(1-q);    % to B
          p*(1-p),    0,           1-q^2,       q*(1-q);    % to C
          p*(1-p),    q*(1-q),     q^2,         (1-q)^2];   % to D

fprintf('=== Q3: 4-state Markov Chain (p=%.1f, q=%.1f) ===\n', p, q);
fprintf('Column sums: [%.4f %.4f %.4f %.4f]\n', sum(T_abcd));

% (b) State probabilities after n transitions starting from A
x0_A = [1; 0; 0; 0];
steps = [5, 10, 100, 200];
fprintf('\n(b) State distribution [A, B, C, D] starting from A:\n');
fprintf('    %-6s  %-8s %-8s %-8s %-8s\n', 'Steps', 'P(A)', 'P(B)', 'P(C)', 'P(D)');
for n = steps
    xn = T_abcd^n * x0_A;
    fprintf('    n=%-4d  %.6f %.6f %.6f %.6f\n', n, xn(1), xn(2), xn(3), xn(4));
end

% (c) Stationary distribution: eigenvector corresponding to eigenvalue 1
%     Solve: T*pi = pi  i.e., (T-I)*pi = 0  with sum(pi)=1
[V, D] = eig(T_abcd);
[~, idx] = min(abs(diag(D) - 1));   % find eigenvalue closest to 1
pi_stat = abs(V(:, idx));
pi_stat = pi_stat / sum(pi_stat);   % normalise

fprintf('\n(c) Stationary distribution (eigenvector method):\n');
fprintf('    P(A)=%.6f  P(B)=%.6f  P(C)=%.6f  P(D)=%.6f\n', pi_stat);
fprintf('    CONCLUSION: n=100 and n=200 results above match stationary dist.\n');
fprintf('    Chain converges to stationary dist regardless of start.\n\n');


%% =========================================================================
%  Q4 - Random 20-state Markov Chain
%% =========================================================================
%
%  Generate random column-stochastic T for 20 states
%  Each column must sum to 1: normalise each column by its sum

rng(42);   % seed for reproducibility
R = rand(20, 20);
T_rand = R ./ sum(R, 1);   % divide each column by its sum -> col-stochastic

% (a) Verify stochastic
col_sums = sum(T_rand);
fprintf('=== Q4: Random 20-state Markov Chain ===\n');
fprintf('(a) Max col sum deviation from 1: %.2e (should be ~0)\n', max(abs(col_sums - 1)));

% (b) P(state 20 after n steps | start state 1)
x0_s1 = zeros(20, 1); x0_s1(1) = 1;   % start in state 1
fprintf('(b) P(state 20 | start state 1) after n steps:\n');
fprintf('    %-8s  %-12s\n', 'n steps', 'P(state 20)');
for n = [2, 5, 10, 100]
    xn = T_rand^n * x0_s1;
    fprintf('    n=%-6d  %12.5f%%\n', n, xn(20)*100);
end
fprintf('    CONCLUSION: As n increases, P converges to the stationary\n');
fprintf('    probability of state 20 regardless of start.\n\n');


%% =========================================================================
%  Q5 - PageRank: web pages A(1), B(2), C(3), D(4), E(5), F(6)
%% =========================================================================
%
%  Web graph from diagram (arrows = hyperlinks):
%    A -> F          (A has 1 outgoing link)
%    B -> A, B -> E  (B has 2 outgoing links)
%    C -> B, C -> D  (C has 2 outgoing links) -- C is a spider trap with D
%    D -> C          (D -> C only, creating C<->D spider trap)
%    E -> B, E -> F  (E has 2 outgoing links)
%    F -> (none)     (F is a DEAD-END: no outgoing links)
%
%  DEAD-END:   F has no outgoing links (column of zeros in H)
%  SPIDER TRAP: C <-> D form a closed loop (all rank eventually drains here)
%
%  Hyperlink matrix H: H(i,j) = 1/|outlinks(j)| if j links to i, else 0
%  This is already the column-stochastic transition matrix (ignoring dead-ends)

n_pages = 6;   % A=1, B=2, C=3, D=4, E=5, F=6

% Build H from diagram
% Outlinks: A->F, B->A,E, C->B,D, D->C, E->B,F, F->(none=dead-end)
H = zeros(n_pages);
H(6,1) = 1;        % A->F  (1 link from A)
H(1,2) = 1/2;      % B->A
H(5,2) = 1/2;      % B->E
H(2,3) = 1/2;      % C->B
H(4,3) = 1/2;      % C->D
H(3,4) = 1;        % D->C  (1 link from D)
H(2,5) = 1/2;      % E->B
H(6,5) = 1/2;      % E->F
% F has no outlinks -> col 6 of H is all zeros (dead-end)

fprintf('=== Q5: PageRank ===\n');
fprintf('H matrix (column sums - note dead-end F has sum=0):\n');
fprintf('  Col sums: '); fprintf('%.2f ', sum(H)); fprintf('\n\n');

% (a) Basic PageRank: 40 iterations using H
%     r_{n+1} = H * r_n  (dead-end causes rank to be lost)
r0 = ones(n_pages,1) / n_pages;   % uniform initial distribution
r = r0;
for iter = 1:40
    r = H * r;
    r = r / sum(r);   % re-normalise because dead-end leaks probability
end
fprintf('(a) PageRank after 40 iterations (basic H, dead-end not fixed):\n');
page_names = {'A','B','C','D','E','F'};
for i = 1:n_pages
    fprintf('    Page %s: %.4f\n', page_names{i}, r(i));
end
[max_r, idx_max] = max(r);
fprintf('    Highest pagerank: Page %s = %.4f\n\n', page_names{idx_max}, max_r);

% (b) Identify spider trap and dead-end
fprintf('(b) Spider trap: Pages C and D form a closed loop (C->D->C).\n');
fprintf('    Dead-end:    Page F has no outgoing links (col 6 of H = 0).\n\n');

% (c) Fix dead-end only: replace dead-end column with uniform 1/n
%     If a page has no outlinks, treat it as linking to ALL pages equally
H_fixed_de = H;
for j = 1:n_pages
    if sum(H(:,j)) == 0   % dead-end detected
        H_fixed_de(:,j) = 1/n_pages;
    end
end
fprintf('(c) Dead-end fixed (F now links uniformly to all pages):\n');
fprintf('    Col sums of H_fixed_de: '); fprintf('%.2f ', sum(H_fixed_de)); fprintf('\n');

r = r0;
for iter = 1:40
    r = H_fixed_de * r;
end
fprintf('    PageRank after 40 iterations:\n');
for i = 1:n_pages
    fprintf('      Page %s: %.4f\n', page_names{i}, r(i));
end
[max_r, idx_max] = max(r);
fprintf('    Highest: Page %s = %.4f\n\n', page_names{idx_max}, max_r);

% (d) Fix spider trap too: Google matrix A = beta*H_fixed + (1-beta)*(1/n)*ones
%     beta = 0.8 (teleportation factor)
beta = 0.8;
A_google = beta * H_fixed_de + (1-beta) * (1/n_pages) * ones(n_pages);

fprintf('(d) Google matrix (beta=%.1f, dead-end + spider-trap fixed):\n', beta);
fprintf('    Col sums of A: '); fprintf('%.2f ', sum(A_google)); fprintf('\n');

r = r0;
for iter = 1:40
    r = A_google * r;
end
fprintf('    PageRank after 40 iterations:\n');
for i = 1:n_pages
    fprintf('      Page %s: %.4f\n', page_names{i}, r(i));
end
[max_r, idx_max] = max(r);
fprintf('    Highest: Page %s = %.4f\n\n', page_names{idx_max}, max_r);

% (e) Iterate until convergence: |r_new - r_old|_inf < 1e-4
r = r0;
iter = 0;
while true
    r_old = r;
    r = A_google * r;
    iter = iter + 1;
    if max(abs(r - r_old)) < 1e-4
        break;
    end
end
fprintf('(e) Convergence criterion: max change < 1e-4\n');
fprintf('    Converged after %d iterations.\n', iter);
fprintf('    PageRank at convergence:\n');
for i = 1:n_pages
    fprintf('      Page %s: %.6f\n', page_names{i}, r(i));
end
fprintf('    CONCLUSION: Values match (d) closely; convergence is fast.\n\n');


%% =========================================================================
%  Q6 (Optional) - PageRank with Google matrix (beta=0.85)
%  Pages: a.pt(1), b.es(2), c.fr(3), d.br(4), e.com(5), f.nl(6)
%  Alphabetical order: a.pt=1, b.es=2, c.fr=3, d.br=4, e.com=5, f.nl=6
%% =========================================================================
%
%  Links from diagram (solid=outlink, dashed=inlink -- reading carefully):
%    a.pt -> c.fr, a.pt -> e.com, a.pt -> f.nl (dotted lines to a.pt from b.es, c.fr)
%    b.es -> a.pt, b.es -> e.com, b.es -> d.br
%    c.fr -> a.pt
%    d.br -> (none visible / dead-end or receives only)
%    e.com -> a.pt, e.com -> c.fr
%    f.nl  -> b.es, f.nl -> d.br
%
%  Note: diagram interpretation may vary; this is a reasonable reading.
%  The key is the METHOD, not the exact link structure.

n6 = 6;
beta6 = 0.85;

% Build H6 from diagram (adjust based on actual diagram if different)
% Outlinks: a.pt->c.fr,e.com,f.nl  b.es->a.pt,e.com,d.br  c.fr->a.pt
%           d.br->(none=dead-end)   e.com->a.pt,c.fr       f.nl->b.es,d.br
H6 = zeros(n6);
% a.pt(1) -> c.fr(3), e.com(5), f.nl(6)  [3 outlinks]
H6(3,1)=1/3; H6(5,1)=1/3; H6(6,1)=1/3;
% b.es(2) -> a.pt(1), e.com(5), d.br(4)  [3 outlinks]
H6(1,2)=1/3; H6(5,2)=1/3; H6(4,2)=1/3;
% c.fr(3) -> a.pt(1)                     [1 outlink]
H6(1,3)=1;
% d.br(4) -> dead-end                    [0 outlinks]
% e.com(5) -> a.pt(1), c.fr(3)           [2 outlinks]
H6(1,5)=1/2; H6(3,5)=1/2;
% f.nl(6) -> b.es(2), d.br(4)            [2 outlinks]
H6(2,6)=1/2; H6(4,6)=1/2;

% Fix dead-ends
H6_fixed = H6;
for j = 1:n6
    if sum(H6(:,j)) == 0
        H6_fixed(:,j) = 1/n6;
    end
end

% Google matrix
A6 = beta6 * H6_fixed + (1-beta6)*(1/n6)*ones(n6);

% (a) Iterative PageRank until max change < 0.01
r6 = ones(n6,1)/n6;
iter6 = 0;
while true
    r6_old = r6;
    r6 = A6 * r6;
    iter6 = iter6 + 1;
    if max(abs(r6 - r6_old)) < 0.01
        break;
    end
end

page_names6 = {'a.pt','b.es','c.fr','d.br','e.com','f.nl'};
fprintf('=== Q6: Optional PageRank (beta=0.85) ===\n');
fprintf('(a) Iterative PageRank (converged in %d iterations):\n', iter6);
for i = 1:n6
    fprintf('    %s: %.4f\n', page_names6{i}, r6(i));
end
[min_r6, i_min] = min(r6);
[max_r6, i_max] = max(r6);
fprintf('    Lowest:  %s = %.4f\n', page_names6{i_min}, min_r6);
fprintf('    Highest: %s = %.4f\n\n', page_names6{i_max}, max_r6);

% (b) Non-iterative: stationary distribution via eigenvector
%     A*pi = pi -> eigenvector for eigenvalue 1
[V6, D6] = eig(A6);
[~, idx6] = min(abs(diag(D6) - 1));
pi6 = abs(V6(:, idx6));
pi6 = pi6 / sum(pi6);
fprintf('(b) Non-iterative (eigenvector) PageRank:\n');
for i = 1:n6
    fprintf('    %s: %.4f\n', page_names6{i}, pi6(i));
end
fprintf('    Should match iterative values closely.\n\n');


%% =========================================================================
%  HELPER: Stationary distribution by solving linear system
%  Alternative to eigenvector method -- useful for exam
%% =========================================================================
%
%  The stationary distribution pi satisfies:
%    T * pi = pi   AND   sum(pi) = 1
%
%  This is equivalent to: (T - I) * pi = 0 with the constraint sum(pi)=1
%  In practice: replace last equation of (T-I)*pi=0 with sum(pi)=1
%
%  MATLAB: use eig(T) and pick eigenvector for eigenvalue closest to 1

function pi = stationary_dist(T)
% STATIONARY_DIST  Compute stationary distribution of Markov chain T
%   T must be column-stochastic (columns sum to 1)
%   Returns probability vector pi such that T*pi = pi, sum(pi)=1
    [V, D] = eig(T);
    [~, idx] = min(abs(diag(D) - 1));
    pi = abs(V(:, idx));
    pi = pi / sum(pi);
end
