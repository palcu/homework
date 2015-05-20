fmod combb is

including NAT .

op comb : Nat Nat -> Nat .

vars n m : Nat .

eq comb (0, 0) = 1 .
eq comb (1, 0) = 1 .
eq comb (1, 1) = 1 .
eq comb (n, 0) = 1 .
eq comb (0, n) = 0 .
eq comb (s(n), s(m)) = comb (n, s(m)) + comb (n, m) .

endfm