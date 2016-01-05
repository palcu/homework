module HW03 where

data Expression =
    Var String                   -- Variable
  | Val Int                      -- Integer literal
  | Op Expression Bop Expression -- Operation
  deriving (Show, Eq)

-- Binary (2-input) operators
data Bop = 
    Plus     
  | Minus    
  | Times    
  | Divide   
  | Gt
  | Ge       
  | Lt  
  | Le
  | Eql
  deriving (Show, Eq)

data Statement =
    Assign   String     Expression
  | Incr     String
  | If       Expression Statement  Statement
  | While    Expression Statement       
  | For      Statement  Expression Statement Statement
  | Sequence Statement  Statement        
  | Skip
  deriving (Show, Eq)

type State = String -> Int

-- Exercise 1 -----------------------------------------

extend :: State -> String -> Int -> State
extend st name val = \x -> if x == name then val else st x

empty :: State
empty x = 0

-- Exercise 2 -----------------------------------------

evalE :: State -> Expression -> Int
evalE st (Val x) = x
evalE st (Var s) = st s
evalE st (Op e1 sign e2) = evalMic (evalE st e1) sign (evalE st e2)

evalMic :: Int -> Bop -> Int -> Int
evalMic a Plus b = a + b
evalMic a Minus b = a - b
evalMic a Eql b = fromEnum(a == b)
evalMic a Times b = a * b
evalMic a Divide b = a `div` b
evalMic a Gt b = fromEnum(a > b)
evalMic a Ge b = fromEnum(a >= b)
evalMic a Lt b = fromEnum(a < b)
evalMic a Le b = fromEnum(a <= b)


-- Exercise 3 -----------------------------------------

data DietStatement = DAssign String Expression
                   | DIf Expression DietStatement DietStatement
                   | DWhile Expression DietStatement
                   | DSequence DietStatement DietStatement
                   | DSkip
                     deriving (Show, Eq)

desugar :: Statement -> DietStatement
desugar (Assign x expr) = (DAssign x expr)
desugar (If x expr1 expr2) = (DIf x (desugar expr1) (desugar expr2))
desugar (While expr s) = (DWhile expr (desugar s))
desugar (Sequence e1 e2) = (DSequence (desugar e1) (desugar e2))
-- desugar (For s1 e s2 s3) = (DSequence (desugar s1) DWhile(e DSequence((desugar s3) (desugar s2))))
-- desugar (For s1 e s2 s3) = Sequence(s1 s2)



-- Exercise 4 -----------------------------------------

evalSimple :: State -> DietStatement -> State
evalSimple = undefined

run :: State -> Statement -> State
run = undefined

-- Programs -------------------------------------------

slist :: [Statement] -> Statement
slist [] = Skip
slist l  = foldr1 Sequence l

{- Calculate the factorial of the input

   for (Out := 1; In > 0; In := In - 1) {
     Out := In * Out
   }
-}
factorial :: Statement
factorial = For (Assign "Out" (Val 1))
                (Op (Var "In") Gt (Val 0))
                (Assign "In" (Op (Var "In") Minus (Val 1)))
                (Assign "Out" (Op (Var "In") Times (Var "Out")))


{- Calculate the floor of the square root of the input

   B := 0;
   while (A >= B * B) {
     B++
   };
   B := B - 1
-}
squareRoot :: Statement
squareRoot = slist [ Assign "B" (Val 0)
                   , While (Op (Var "A") Ge (Op (Var "B") Times (Var "B")))
                       (Incr "B")
                   , Assign "B" (Op (Var "B") Minus (Val 1))
                   ]

{- Calculate the nth Fibonacci number

   F0 := 1;
   F1 := 1;
   if (In == 0) {
     Out := F0
   } else {
     if (In == 1) {
       Out := F1
     } else {
       for (C := 2; C <= In; C++) {
         T  := F0 + F1;
         F0 := F1;
         F1 := T;
         Out := T
       }
     }
   }
-}
fibonacci :: Statement
fibonacci = slist [ Assign "F0" (Val 1)
                  , Assign "F1" (Val 1)
                  , If (Op (Var "In") Eql (Val 0))
                       (Assign "Out" (Var "F0"))
                       (If (Op (Var "In") Eql (Val 1))
                           (Assign "Out" (Var "F1"))
                           (For (Assign "C" (Val 2))
                                (Op (Var "C") Le (Var "In"))
                                (Incr "C")
                                (slist
                                 [ Assign "T" (Op (Var "F0") Plus (Var "F1"))
                                 , Assign "F0" (Var "F1")
                                 , Assign "F1" (Var "T")
                                 , Assign "Out" (Var "T")
                                 ])
                           )
                       )
                  ]
