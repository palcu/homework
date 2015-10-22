function a = invert_exp(lambda, x)
    a = double(1) - double(1)/x;
end

function A = gen_selection(lambda, n)
    A = rand(1, n);
    A = arrayfun(@invert_exp, lambda, A);
end

lambda = 1;
n = 1000;

x = gen_selection(lambda, n);
[N, X] = hist(x, 1000);
M = N;
bar(X, M, 1, 'r');
sum(M);
