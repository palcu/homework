%ex 1 pc b
function [] = prob1B(miu, sigma)
    Z = zeros(1000);
    vect = Z(1, :);

    for i = 1:1:1000
        vect(i) = prob1(miu, sigma);
    end
    
    [N C] = hist(vect, 15)
    N = N/(1000*(C(2)-C(1)));
    bar(C, N, 1); 
    
    hold on;
    
    v = min(vect):0.01:max(vect)  
    plot(v, normpdf(v, miu, sigma))
end