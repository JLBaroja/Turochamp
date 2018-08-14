import Data.Char
import Piece
import Board
import Color

startFEN = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"

foo = words startFEN

bar = splitByChar '/' $ head foo

first = head $ bar

-- TODO: figure out how to construct squares from a piece list
-- while giving an appropriate index
rankToSquares :: String -> [Square]
rankToSquares r = squares where
                squares = [Square i p | i <- [0..7], p <- pieces]
                pieces = concatMap parseRankChar r

parseRankChar :: Char -> [Maybe Piece]
parseRankChar c = if isDigit c then
                take (digitToInt c) (repeat Nothing)
                else
                [charToPiece c]

-- I can't tell if I'm a genius or if this is a horribly disgusting hack
splitByChar c list = words $ map (\x -> if x == c then ' ' else x) list