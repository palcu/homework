% ex 2 pc a
function [x] = myExp(lambda)
    k = 0;
    zStar = 0;
    while(mod(k, 2) ~= 1)
        z0 = rand;
        z1 = rand;
        zStar = z0;
        while(z0 >= z1)
            k = k + 1;
            z0 = z1;
            z1 = rand;
        end
    end
    
    x = zStar;
    x = x / lambda;
end

