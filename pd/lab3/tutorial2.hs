-- Informatics 1 - Functional Programming 
-- Tutorial 2
--
-- Week 4 - due: 11/12 Oct.

import Data.Char
import Data.List
import Data.Tuple
import Test.QuickCheck


-- 1.
rotate :: Int -> [Char] -> [Char]
rotate x cs | x < 0 = error "Function only defined on positive numbers!"
            | x > length cs = error "X is greater than length of characters!"
            | otherwise = rotate2 x cs

rotate2 :: Int -> [Char] -> [Char]
rotate2 0 cs = cs
rotate2 x (c:cs) = rotate2 (x-1) (cs++[c])

-- 2.
prop_rotate :: Int -> String -> Bool
prop_rotate k str = rotate (l - m) (rotate m str) == str
                        where l = length str
                              m = if l == 0 then 0 else k `mod` l

-- 3. 
makeKey :: Int -> [(Char, Char)]
makeKey x = zip ['A'..'Z'] (rotate x ['A'..'Z'])

-- 4.
lookUp :: Char -> [(Char, Char)] -> Char
lookUp c [] = c
lookUp c (x:xs) | c == fst x  = snd x
                | otherwise = lookUp c xs

-- 5.
encipher :: Int -> Char -> Char
encipher offset c = lookUp c (makeKey offset)

-- 6.
normalize :: String -> String
normalize xs = [toUpper x | x<-xs, isLetter x || isDigit x]

-- 7.
encipherStr :: Int -> String -> String
encipherStr x str = [encipher x c | c <- normalize str]

-- 8.
reverseKey :: [(Char, Char)] -> [(Char, Char)]
reverseKey xs = [swap x | x <- xs]

-- 9.
decipher :: Int -> Char -> Char
decipher x c | isLetter c = lookUp c (reverseKey (makeKey x))
             | otherwise = c

decipherStr :: Int -> String -> String
decipherStr x str = [decipher x c | c <- str]

-- 10.
prop_cipher :: Int -> String -> Property
prop_cipher n s = n>=0 && n<=26 ==> normalize s == decipherStr n (encipherStr n (normalize s))

-- 11.
contains :: String -> String -> Bool
contains text s = or [(s `isPrefixOf` (drop x text)) | x <- [0..length(text)]]
containsWords :: String -> [String] -> Bool
containsWords text words = or [contains text x | x<-words]

-- 12.
candidates :: String -> [(Int, String)]

candidates2 :: Int -> String -> [(Int, String)]
candidates str = candidates2 0 str
candidates2 26 str = []
candidates2 x str | enciphered <- encipherStr x str, 
                    containsWords enciphered ["THE", "AND"]
                        = (x, enciphered) : candidates2 (x+1) str
                  | otherwise = candidates2 (x+1) str

candidatesList :: String -> [(Int, String)]
candidatesList str = [y | y<-[(x, encipherStr x str) | x <- [0..25]], 
                          containsWords (snd y) ["THE", "AND"]]

candidatesList2 :: String -> [(Int, String)]
candidatesList2 str = [(x, y) | x <- [0..25], 
                                let y = encipherStr x str, 
                                containsWords y ["THE", "AND"]]

-- Optional Material

-- 13.
splitEachFive :: String -> [String]
splitEachFive s | length s < 5 = [(s ++ replicate (5 - length s) 'X')]
                | let y = splitAt 5 s,
                  otherwise = ((fst y) : (splitEachFive (snd y)))

-- 14.
prop_transpose :: String -> Bool
prop_transpose s = splitEachFive s == (transpose . transpose . splitEachFive $ s)

-- 15.
encrypt :: Int -> String -> String
encrypt x s = concat(transpose(splitEachFive(encipherStr x s)))

-- 16.
decrypt :: Int -> String -> String
-- nu merge
decrypt x s = decipherStr x concat(transpose(splitEachFive(s)))

-- Challenge (Optional)

-- 17.
countFreqs :: String -> [(Char, Int)]
countFreqs = undefined

-- 18
freqDecipher :: String -> [String]
freqDecipher = undefined
