fmod length is

including NAT .
including BOOL .

sort List .

op _ add _ : Nat List -> List .
op length _ : List -> Nat .
op member : List Nat -> Bool .

ops VID : -> List .
vars a, b : Nat .
var L : List .

eq member(VID, a) = false .
eq member(b add L, a) = (a == b) or member(L, a) . 
eq length(VID) = 0 . 
eq length(a add L) = 1 + length(L) .



endfm