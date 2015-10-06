-- Informatics 1 - Functional Programming 
-- Lab week tutorial part II
--
--

import PicturesSVG
import Test.QuickCheck



-- Exercise 9:

pic1 :: Picture
pic1 = ((knight `beside` (invert knight)) `above` ((invert knight) `beside` knight))

pic2 :: Picture
pic2 = ((knight `beside` (invert knight)) `above` (flipV ((knight) `beside` (invert knight))))


-- Exercise 10:
-- a)

emptyRow :: Picture
emptyRow = (repeatH 4 (whiteSquare `beside` blackSquare))

-- b)

otherEmptyRow :: Picture
otherEmptyRow = (repeatH 4 (blackSquare `beside` whiteSquare))

-- c)

middleBoard :: Picture
middleBoard = (repeatV 2 (emptyRow `above` otherEmptyRow))

-- d)

whiteRow :: Picture
pieceRow :: Picture
pieceRow = (rook `beside` knight `beside` bishop `beside` queen `beside` king `beside` bishop `beside` knight `beside` rook)
whiteRow = (pieceRow `over` otherEmptyRow)

blackRow :: Picture
blackRow = ((invert pieceRow) `over` emptyRow)

-- e)

populatedBoard :: Picture
pawnRow = (repeatH 8 pawn)
whitePawnRow = (pawnRow `over` emptyRow)
blackPawnRow = ((invert pawnRow) `over` otherEmptyRow)
populatedBoard = (blackRow `above` blackPawnRow `above` middleBoard `above` whitePawnRow `above` whiteRow)



-- Functions --

twoBeside :: Picture -> Picture
twoBeside x = beside x (invert x)


-- Exercise 11:

twoAbove :: Picture -> Picture
twoAbove x = above x (invert x)

fourPictures :: Picture -> Picture
fourPictures x = twoBeside (twoAbove x)
