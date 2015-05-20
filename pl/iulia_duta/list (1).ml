fmod length is

including NAT .
including BOOL .

subsort Nat < List .
sort List .


op sort _ : List -> List .
op head _ : List -> List .
op _ add _ : List List -> List [assoc id: VID] .

op bubblesort _ : List -> List .

op length _ : List -> Nat .
op member : List Nat -> Bool .
op first _ : List -> Nat .
op last _ : List -> Nat .
op reverse _ : List -> List .

op minim  : List List -> List . 
op maxim : List List -> List .
op inverse_ : List -> List .
op bubblesortm _ : List -> List .

ops VID : -> List .
ops NULL : -> Nat .
vars a b : Nat .
vars L L1 L2 : List .

eq member(VID, a) = false .
eq member(b add L, a) = (a == b) or member(L, a) .



eq length(VID) = 0 .
eq length(a add L) = 1 + length(L) .

eq first(VID) = NULL .
eq first(a add L) = a .

eq last(VID) = NULL .
eq last(a add L) = last(L) .

eq reverse(VID) = VID .
eq reverse(a add L) = reverse(L) add a .

eq head(VID) = VID .
eq head(a add L) = L .

eq minim(a, b) = min(a, b) .
eq minim(a, VID) = a .

eq maxim(a, b) = max(a, b) .
eq maxim(a, VID) = a .

eq sort(VID) = VID .
eq sort(a add VID) = a .
eq sort(a add L) = minim(a, first(sort(L))) add sort(maxim(a, first(sort(L))) add head(sort(L))) .

eq inverse(VID) = VID .
eq inverse(a add VID) = a add VID .
eq inverse(a add b add L) = minim(a, b) add inverse(maxim(a, b) add L) .



eq bubblesort(VID) = VID .
eq bubblesort(a add VID) = a add VID .
ceq bubblesort(L1 add a add b add L2) = bubblesort(L1 add b add a add L2) if (a > b) .

endfm