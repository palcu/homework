function [x] = myNormala(miu, sigma)
    found = 0;
    no_pasi = 0;
    while(!found)
        no_pasi++;
        u = rand();
        y = exprnd(1);
        if u <= exp((-y * y/2) + y - 0.5)
            found = 1;
        end
    end

    if rand() <= 0.5
        z = y;
    else
        z = -y;
    end
    
    no_pasi;
    x = sigma*z + miu;
end

N = 10000;
Y = zeros(1, N);
for i = 1:N
    Y(i) = myNormala(0, 1);
end

hist(Y);
