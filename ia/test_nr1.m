a = zeros(8, 1);
b = zeros(8, 1);
c = zeros(8, 1);
m = zeros(8, 3);
for i=0:1
    for j=0:1
        for k=0:1
            index = i*4 + j*2 + k + 1;
            m(index, 1) = i;
            m(index, 2) = j;
            m(index, 3) = k;
            a(index) = (j & (i | (~i & k)));
            b(index) = (i & j) | (i | (~i & j));
            c(index) = (i & ~j) | (~i & j & k);
        end
    end
end
% plotpv(m', a')
% a se poate
% plotpv(m', b')
% b se poate
% plotpv(m', c')
% c nu se poate

net = newp([0 1; 0 1; 0 1], 1);
net.trainParam.epochs = 200;
net.iw{1, 1} = [3 3 3];
net = train(net, m', b');
l = 5;
m = zeros(l*l*l, 3);
o = zeros(l*l*l, 1);
for i=1:l
    for j=1:l
        for k=1:l
            a1 = i / 10.0;
            a2 = j / 10.0;
            a3 = k / 10.0;
            Y = sim(net, [a1; a2; a3]);
            o(i*l*l+j*l+k) = Y;
            m(i*l*l+j*l+k, 1) = a1;
            m(i*l*l+j*l+k, 2) = a2;
            m(i*l*l+j*l+k, 3) = a3;
        end
    end
end
m'
o'
plotpv(m', o')
plotpc(net.IW{1}, net.b{1})
