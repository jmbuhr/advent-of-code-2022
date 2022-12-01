import Data.List (groupBy, sort)

main = interact solve'

solve = show .
  maximum .
  sumElves

solve' = show .
  sum . take 3 . reverse . sort .
  sumElves

sumElves = map (sum . map read) . filter (/=[""]) . splitOn "" . lines
splitOn x = groupBy (\a b -> a /= x && b /= x)

test = unlines [
  "1000",
  "2000",
  "3000",
  "",
  "4000",
  "",
  "5000",
  "6000",
  "",
  "7000",
  "8000",
  "9000",
  "",
  "10000"
  ]



