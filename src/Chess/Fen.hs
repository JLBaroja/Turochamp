import Data.Char
import Data.List.Split
import Piece
import Board
import Color

startFEN = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"

foo = words startFEN

bar = splitOn "/" $ head foo

first = head $ bar

-- TODO: figure out how to construct squares from a piece list
-- while giving an appropriate index
rankToSquares :: String -> [Square]
rankToSquares r = squares where
                --squares = [Square i p | p <- pieces, i <- [0..7]]
                squares = [Square i p | i <- [0..7], p <- pieces]
                pieces = concatMap parseRankChar r

parseRankChar :: Char -> [Maybe Piece]
parseRankChar c = if isDigit c then
                take (digitToInt c) (repeat Nothing)
                else
                [charToPiece c]
