pkg load all
hold on

function a = F(x)
    if x == 1
        a = 0;
    else
        a = 1 / (1-x);
    end
end

function a = f(x)
    x_patrat = x * x;
    if x == 0
        a = 1;
    else
        a = 1 / x_patrat;
    end
end

function [A, B] = gen_selection(n)
    A = B = rand(1, n);
    A = arrayfun(@F, A);
    B = arrayfun(@f, B);
end

n = 1000;

[x, y] = gen_selection(n);
[N, X] = hist(x, 1000);
M = N / (double(n) * (X(2) - X(1)));
bar(X, M, 1, 'r');

abscise = 0 : 1 : max(X);
Y = arrayfun(@f, abscise);
plot(abscise, Y);
