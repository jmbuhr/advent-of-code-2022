module Main where

import Data.Char (isDigit)
import Data.List (intercalate, isPrefixOf)
import Data.List.Extra (sort)
import qualified Data.Map as Map

main :: IO ()
main = do
  content <- readFile "input.dat"
  let files = parseInput content
      folderSizes = map snd . folderTotals $ files
      solution = sum . filter (<= 100000) $ folderSizes

  let sizes = sort folderSizes
      upper = (last sizes) - 40000000
      solution' = head . dropWhile (< upper) $ sizes

  print $ take 10 files
  print solution
  print solution'

type Size = Int
type Path = String
type File = (Path, Size)

parseInput :: String -> [File]
parseInput = processLines ["/"] . filter usefull . lines where
  usefull = not . ("dir " `isPrefixOf`)

processLines :: [String] -> [String] -> [File]
processLines _ [] = []
processLines ps (x : xs)
  | x == "$ cd /" = (joinPath ["/"], 0) : processLines ["/"] xs
  | x == "$ cd .." = processLines (tail ps) xs
  | "$ cd " `isPrefixOf` x =
    let folder = drop 5 x
        ps' = folder : ps
     in (joinPath ps', 0) : processLines ps' xs
  | x == "$ ls" = processLines ps xs
  | otherwise =
    let fsize = read . takeWhile isDigit $ x
     in (joinPath ps, fsize) : processLines ps xs

joinPath :: [String] -> String
joinPath = intercalate "/" . reverse

folderTotals :: [File] -> [File]
folderTotals fs = map (\p -> (p, sumSize p)) ps
 where
  m = Map.fromListWith (+) fs
  ps = reverse . Map.keys $ m
  sumSize p = sum . map (m Map.!) . filter (p `isPrefixOf`) $ ps
