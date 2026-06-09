n = 15;
p = 0.5;

prob = 0;
for k = 6:n
    prob = prob + nchoosek(n,k) * p^k * (1-p)^(n-k);
end

prob
