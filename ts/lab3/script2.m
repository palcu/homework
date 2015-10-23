pkg load all

function a = invert_exp(lambda, x)
    a = (-1 / lambda) * log(x);
end

function A = gen_selection(lambda, n)
    A = rand(1, n);
    A = arrayfun(@invert_exp, lambda, A);
end

lambda = 1;
n = 10000;

x = gen_selection(lambda, n);
[N, X] = hist(x, 20);
M = N / (double(n) * (X(2) - X(1)));
bar(X, M, 1, 'r');
hold on

abscise = 0 : 0.1 : 6;
Y = exppdf(abscise, 1);
plot(abscise, Y);
