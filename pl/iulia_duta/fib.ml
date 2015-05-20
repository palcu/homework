fmod fibo is

including NAT .

op fib_ : Nat -> Nat .
var x :  Nat .

eq fib 0 = 0 .
eq fib 1 = 1 .
eq fib (s(s(x))) = fib (s(x)) + fib (x) .

endfm 