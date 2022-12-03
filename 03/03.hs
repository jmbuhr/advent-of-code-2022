module Main where
import qualified Data.Set as Set
import Data.Char (ord, isUpper)


type Rucksack = (String, String)
parseLine :: String -> Rucksack
parseLine s = splitAt n s where
  n = length s `div` 2

findElement :: Rucksack -> Char
findElement (x,y) = findDuplicate x y

findDuplicate :: String -> String -> Char
findDuplicate [] [] = error "Why is this rucksack empty? Carry your weight, elve!"
findDuplicate x y = head $ Set.elems i where
  s1 = Set.fromList x
  s2 = Set.fromList y
  i = Set.intersection s1 s2

-- Lowercase item types a through z have priorities 1 through 26.
-- Uppercase item types A through Z have priorities 27 through 52.
-- 65 = ord 'A'
-- 97 = ord 'a'
charToValue c = x - n where
  x = ord c
  n | isUpper c = 38
    | otherwise = 96

main :: IO ()
main = do
  ls <- readFile "./input.dat"
  let rucksacks = map parseLine . lines $ ls
  print . sum . map (charToValue . findElement) $ rucksacks
  return ()

-- part 2
type CompleteRucksack = String

findBadge :: [CompleteRucksack] -> Char
findBadge = head . Set.elems . foldl1 Set.intersection . map Set.fromList


main' :: IO ()
main' = do
  ls <- readFile "./input.dat"
  let elveGroups = chunkN 3 $ lines ls
  print . sum . map (charToValue . findBadge) $ elveGroups
  return ()

chunkN :: Int -> [a] -> [[a]]
chunkN _ [] = []
chunkN n xs = take n xs : chunkN n (drop n xs)

