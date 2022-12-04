{-# LANGUAGE GADTs #-}
module Main where


main :: IO ()
main = do
  content <- readFile "./input.dat"
  let elves = map lineToElves $ lines content
  let result = sum (map (fromEnum . compareTwo) elves)
  print result

main' :: IO ()
main' = do
  content <- readFile "./input.dat"
  let elves = map lineToElves $ lines content
  let result = sum (map (fromEnum . compareTwo') elves)
  print result

data Elve where
  Elve :: {left :: Int, right :: Int} -> Elve deriving(Show)

lineToElves :: [Char] -> [Elve]
lineToElves = map parseElve . split ',' where
  parseElve s = case split '-' s of
    [l,r]          -> Elve (read l) (read r)
    _somethingElse -> error "You shall not parse!"


between :: Int -> (Int, Int) -> Bool
between t (l,r) = t >= l && t <= r

containsEachOther :: Elve -> Elve -> Bool
containsEachOther (Elve l r) (Elve l' r') =
  l `between` (l',r') && r `between` (l',r') ||
  l' `between` (l,r) && r' `between` (l,r)

compareTwo :: [Elve] -> Bool
compareTwo [e1,e2] = containsEachOther e1 e2
compareTwo _anythingElse = error "There are too many elves on this line. Get organzied, elves!"

compareTwo' :: [Elve] -> Bool
compareTwo' [e1,e2] = overlapsEachOther e1 e2
compareTwo' _anythingElse = error "There are too many elves on this line. Get organzied, elves!"

overlapsEachOther :: Elve -> Elve -> Bool
overlapsEachOther (Elve l r) (Elve l' r') =
  l `between` (l',r') || r `between` (l',r') ||
  l' `between` (l,r) || r' `between` (l,r)


split :: Eq a => a -> [a] -> [[a]]
split c s = case break (==c) s of
                (a, _:b) -> a : split c b
                (a, _)   -> [a]


