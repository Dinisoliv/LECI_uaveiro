lambda = [8 5 2 1];        % forward rates
miu    = [600 100 20 5];  % backward rates
ber    = [1e-6 1e-5 1e-4 1e-3 1e-2];

% (a) stationary probabilities via birth-death formula
co = [1, lambda./miu];
co = cumprod(co);
pi = co / sum(co);
fprintf('Stationary probabilities:\n');
disp(pi)

% (c) holding times in minutes
q = [lambda(1), lambda(2:end)+miu(1:end-1), miu(end)];
T_min = 60 ./ q;
fprintf('Holding times (min): '); disp(T_min)

% (d) 100-byte frame error probability
p_err_100  = 1 - (1 - ber).^(100*8);
P_err_100  = sum(pi .* p_err_100);
fprintf('P(error | 100 B)  = %.4f%%\n', 100*P_err_100);

% (e) 1500-byte frame no-error probability
p_ok_1500  = (1 - ber).^(1500*8);
P_ok_1500  = sum(pi .* p_ok_1500);
fprintf('P(no error | 1500 B) = %.4f%%\n', 100*P_ok_1500);

% (f) posterior probabilities given error on 1500-byte frame
p_err_1500 = 1 - p_ok_1500;
P_err_1500 = sum(pi .* p_err_1500);
post = (pi .* p_err_1500) / P_err_1500;
fprintf('P(10^-6 | E) = %.4f%%\n', 100*post(1));
fprintf('P(10^-2 | E) = %.4f%%\n', 100*post(5));