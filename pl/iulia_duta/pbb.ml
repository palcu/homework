fmod LOGICEQ is

sort Logic .
sort Atom .

op _&&_ : Logic Logic -> Logic[assoc comm] .
op _||_ : Logic Logic -> Logic[assoc comm] .
op ~_ : Logic -> Logic .
op _->_ : Logic Logic -> Logic .

ops adevarat fals : -> Logic .
ops A B C D E F G H : -> Atom .
vars a b c d e f g h : Logic .

eq adevarat && adevarat = adevarat .
eq adevarat && fals = fals .
eq fals && fals = fals .
eq adevarat || adevarat = adevarat .
eq adevarat || fals = adevarat .
eq fals || fals = fals .
eq ~ adevarat = fals .
eq ~ fals = adevarat .

eq a || (b && c) = (a || b) && (a || c) .
eq ~(a && b) = ~ a || ~ b .

endfm