function a = invert_exp(lambda, x)
    a = (-1 / lambda) * log(x);
end

function A = gen_selection(lambda, n)
    A = rand(1, n);
    A = arrayfun(@invert_exp, lambda, A);
end

lambda = 1;
n = 1000;

x = gen_selection(lambda, n);
[N, X] = hist(x, 20);
M = N ./ (double(n) * ;
bar(X, M, 1, 'r');
sum(M)
