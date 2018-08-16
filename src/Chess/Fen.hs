import Data.Char
import Piece
import Board
import Color

startFEN = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"

foo = words startFEN
bar = splitByChar '/' $ head foo
ranks = take 8 bar
first = head $ bar

-- There will always be a piece in the piece list
-- All we have to do is get the piece (if it exists)
    -- And then we have to use the rank/file to get a square index
    -- and then just make a giant list of pieceEntries from this
    -- and then define a board from it

rankToPieces :: String -> [Maybe Piece]
rankToPieces = concatMap parseChar

parseChar x = if isDigit x
                then replicate (digitToInt x) Nothing
                else [charToPiece x]

-- I can't tell if I'm a genius or if this is a horribly disgusting hack
splitByChar c list = words $ map (\x -> if x == c then ' ' else x) list