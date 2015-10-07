-- http://www.seas.upenn.edu/~cis194/hw/01-intro.pdf

type Peg = String
type Move = (Peg, Peg)
hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
hanoi x a b c = [(a, b), (b, c)]
