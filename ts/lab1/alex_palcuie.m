1;

function f1()
    # a)
    A = [1, 2, 3; 4, 5, 6; 7, 8, 9]
    B = A([1 3], [1 3])
    A(2:3, 2:3)
    
    # b)
    A(end, :)
    A(:, 2)
    
    # c)
    pos = find(mod(A, 2) == 0)
    A(pos) = 0

    # d)
    V = [10, 11, 12],
    A = [A; V]
    C = [4; 7; 10; 13]
    A = [A C]
end

function f2(u, v)
   sqrt(sum((u - v) .^ 2)) 
end

function f3(m, n)
    # la prima "reshape"
    # la a doua "ones"
    A = [1:n]
end

function a = f4_1(x)
    a = x*x-x+1
end

function a = f4_2(x)
    a = 2*x+3
end

function f4()
    X1 = [-1 : 0.1 : 1]
    Y1 = arrayfun(@f4_1, X1)
    X2 = [1 : 0.1 : 3]
    Y2 = arrayfun(@f4_2, X2)
    figure
    plot([X1 X2], [Y1 Y2])
end

function a = f5(x)
    # fibonacci recursiv
    if x == 1
        a = 1,
    elseif x == 2
        a = [1 1],
    else
        b = f5(x-1),
        a = [b b(end-1) + b(end)],
    end
end

function f6(v, m)
    v2 = sort(v)
    indexes = [0 : 2 : size(v2, 2)]
    indexes = indexes(end-m+1: end)
    v2(indexes)
    v = v(~ismember(v, v2))
end

function alex_palcuie()
    #f1()
    #f2([0 0], [0 5])
    #f3(3, 6)
    #f4()
	#f5(5)
    f6([3 2 1 6 7 9 2 5], 3)
end

alex_palcuie()
