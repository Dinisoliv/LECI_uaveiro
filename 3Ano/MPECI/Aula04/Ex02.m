% Exercise 2 - Server with HW and SW failures
T = [0     6     0     6
     1/90  0     0     0
     1/500 0     0     0
     0     0     1     0];
n = length(T);
Q = T;
for i = 1:n
    Q(i,i) = -sum(T(:,i));
end
M = [Q; ones(1,n)];
x = [zeros(n,1); 1];
u = M \ x;

% (c) Limiting probabilities
fprintf('pi_0 (Working)          = %.6f%%\n', 100*u(1));
fprintf('pi_1 (SW repair)        = %.6f%%\n', 100*u(2));
fprintf('pi_2 (HW repair)        = %.6f%%\n', 100*u(3));
fprintf('pi_3 (SW repair after HW) = %.6f%%\n', 100*u(4));

% (d) Server availability
fprintf('P(available) = %.6f%%\n', 100*u(1));

% (e) Average downtime in 30 days (hours)
downtime = (1 - u(1)) * 30 * 24;
fprintf('Avg downtime in 30 days = %.4f hours\n', downtime);