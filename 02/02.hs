data Hand = Rock | Paper | Scissors deriving (Show)

parseHand :: String -> Hand
parseHand "A" = Rock
parseHand "B" = Paper
parseHand "C" = Scissors
parseHand "X" = Rock
parseHand "Y" = Paper
parseHand "Z" = Scissors
parseHand x = error $ "Parsing Error. Unkown Hand: " ++ x

instance Eq Hand where
  a == b = show a == show b

instance Ord Hand where
  compare Rock Rock      = EQ
  compare Rock Paper     = LT
  compare Rock Scissors  = GT
  compare Paper Paper    = EQ
  compare Paper Rock     = GT
  compare Paper Scissors = LT
  compare Scissors Scissors = EQ
  compare Scissors Rock = LT
  compare Scissors Paper = GT

score :: [Hand] -> Int
score (h1:[h2]) = winScore + handScore h2 where
  handScore Rock = 1
  handScore Paper = 2
  handScore Scissors = 3
  winScore = case compare h1 h2 of
    GT -> 0
    EQ -> 3
    LT -> 6
score _ = error "There was a line with not enough or more than two hands. Play fair, elves!"


parseLine :: String -> [Hand]
parseLine = map parseHand . words


main = do
  ls <- readFile "./input.dat"
  let hands = map parseLine . lines $ ls
      scores = map score hands
  print (sum scores)


