-- Informatics 1 - Functional Programming 
-- Tutorial 7
--
-- Week 9 - Due: 19/20 Nov.


import LSystem
import Test.QuickCheck

-- Exercise 1

-- 1a. split
split :: Command -> [Command]
split (a :#: b) = split(a) ++ split(b)
split (Sit) = []
split (a) = [a]

-- 1b. join
join :: [Command] -> Command
join [] = Sit
join (x:xs) = x :#: join(xs)

-- 1c  equivalent
equivalent :: Command -> Command -> Bool
equivalent a b = split a == split b

-- 1d. testing join and split
prop_split_join :: Command -> Bool
prop_split_join a = equivalent(a a)

prop_split = undefined


-- Exercise 2
-- 2a. copy
copy :: Int -> Command -> Command
copy = undefined

-- 2b. pentagon
pentagon :: Distance -> Command
pentagon = undefined

-- 2c. polygon
polygon :: Distance -> Int -> Command
polygon = undefined



-- Exercise 3
-- spiral
spiral :: Distance -> Int -> Distance -> Angle -> Command
spiral = undefined


-- Exercise 4
-- optimise
optimise :: Command -> Command
optimise = undefined



-- L-Systems

-- 5. arrowhead
arrowhead :: Int -> Command
arrowhead = undefined

-- 6. snowflake
snowflake :: Int -> Command
snowflake = undefined

-- 7. hilbert
hilbert :: Int -> Command
hilbert = undefined

main :: IO ()
main = display (Go 30 :#: Turn 120 :#: Go 30 :#: Turn 120 :#: Go 30)
