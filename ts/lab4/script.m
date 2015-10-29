function x =  simVarDiscreta(X, p)
    v = zeros(1, size(p, 2) + 1);
    L = length(p) + 1;
    for i = 2:L
        v(i) = v(i-1) + p(i-1);
    end

    u = rand();
    for i = 2:L
        if u < v(i)
            x = X(i-1);
            break
        end
    end
end

X = [0, 1, 2];
p = [0.3, 0.2, 0.5];
x = simVarDiscreta(X, p);

N = 1000;
Y = zeros(1, N);
for i = 1:N
    Y(i) = simVarDiscreta(X, p);
end

hist(Y);
