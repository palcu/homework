binocdf(3, 50, 0.2)
1 - poisscdf(1, 0.25)


X = [-10 : 0.1 : 10]
a = normpdf(X, -2, 2)
b = normpdf(X, 0, 1)
c = normpdf(X, 2, 0.5)

figure
plot(X, a, X, b, X, c)

% Not in Octave
% normspec([-2, 2], 0, 1)
% normspec([-3, 3], 0, 1)
% normspec([-4, 4], 0, 1)

time = [ 1 : 20 ]

function a = f(x)
    avg_time = 1/15
    a = avg_time * e ^ (-avg_time * x)
end

A = arrayfun(@f, time)
sol = 1 - sum(A)
