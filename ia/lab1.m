# problema 1

function [ C ] = euclid( A, B )
    n = size(A, 1)
    m = size(A, 2)
    p = size(B, 1)

    for i = 1:n
        for j = 1:p
            distance = A(i,:) - B(j,:)
            mySum = sum(distance .* distance, 2)
            C(i, j) = sqrt(mySum);
        end
    end
end

a = [1 2 3; 4 5 6]
b = [2 3 4; 5 6 7]
C = euclid(a, b)
D = C .* C


# problema 2

X = [0 0 1 0 1 1 1 0 1]
T = [0 0 0 0 1 1 1 1 1]

n = size(X, 2)

M = zeros(2)
for i = 1:n
  M(X(i)+1, T(i)+1) = M(X(i)+1, T(i)+1) + 1
end


(M(1, 1) + M(2, 2))/n*100
(M(1, 2) + M(2, 1))/n*100

# problema 2 extinsa
X = [0 0 1 0 1 1 1 0 1 0]
T = [0 0 0 0 1 1 1 1 1 0]

mX = [X' ~X' zeros(n+1, 1)]
