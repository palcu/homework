% ex 1 pc a
function [x] = myNormala(miu, sigma)
    while(1)
        u = rand;
        y = exprnd(1);
        if u <= exp((-y * y/2) + y - 0.5)
            break
        end
    end
    
    u1 = rand;
    if u1 <= 0.5 
        z = y;
    else
        z = -y;
    end;
    
    x = sigma * z + miu;
end
