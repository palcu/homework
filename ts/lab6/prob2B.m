% ex 2 pc b
% apel pentru lambda = 1
function [x] = prob2B(lambda)
    Z = zeros(1000);
    vect = Z(1, :);
    
    for i = 1:1:1000
        vect(i) = myExp(lambda);
    end
    
    [N C] = hist(vect, 15)
    N = N/(1000 * (C(2) - C(1)));
    bar(C, N, 1);
    
    hold on;
    
    v = min(vect):0.01:max(vect);
    fExp = exppdf(v,1)/(1 - exp(-1));
    plot(v, fExp)
end

