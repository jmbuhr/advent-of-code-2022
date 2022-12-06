module Main where
import Data.List (group, sort)

main = readFile "./input.dat" >>=
  print . show . solve

main' = readFile "./input.dat" >>=
  print . show . solve'


type Buffer = [Char]
type Iterator = Int
type BufferSize = Int

process :: BufferSize -> Buffer -> Iterator -> String -> Int
process n _ i [] = i
process n b i (s:rest) | length b < n = process n b' i' s' where
  b' = s : b
  i' = i + 1
  s' = rest
process n b i (s:rest)
  | unique b  = i
  | otherwise = process n b' i' s' where
    b' = updateBuffer s b
    i' = i + 1
    s' = rest

process4 = process 4
process14 = process 14


updateBuffer :: Char -> Buffer -> Buffer
updateBuffer c [] = [c]
updateBuffer c b  = c : (init b)

unique :: Ord a => [a] -> Bool
unique s = length s == length (group $ sort s)

solve :: String -> Int
solve = process4 [] 0

solve' = process14 [] 0


input = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"
-- >>> solve input
-- 11

