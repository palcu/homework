function [A] = my_rand(a, b, m, n)
    A = a + (b-a) .* rand(m, n)
end

a = -2
b = 2
u = 1
v = 1000

x = my_rand(a, b, u, v);
[N, X] = hist(x, 20)
% bar(X,N,1,'w');

M = N ./ double(v-u+1);
bar(X, M, 1, 'w');
