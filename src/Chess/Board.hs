module Board(
    Board(..),
) where

import Data.Bits
import Piece
import Color

type Square = (Int, Maybe Piece)

data Board = Board {
    position :: [Square],
    sideToMove :: Color
} deriving (Show)

newBoard = Board {
    position = zip [0..] $ replicate 128 Nothing,
    sideToMove = White
}

foo = (0x16, Just $ Piece Black Rook) :: Square

squareIndex :: Square -> Int
squareIndex s = fst s

squarePiece :: Square -> Maybe Piece
squarePiece s = snd s

-- Convert an 0x88 index to a 0-7 rank/file
squareFile sq = (squareIndex sq) .&. 7
squareRank sq = shiftR (squareIndex sq) 4

-- Any non zero value means that the square is invalid
squareOnBoard sq = (squareIndex sq) .&. 0x88 == 0

--bar = filter (>3) [0..10]
squaresOnRank pos rank = filter (\x -> squareRank x == rank && squareOnBoard x) pos
squaresOnFile pos file = filter (\x -> squareFile x == file && squareOnBoard x) pos

bar = squaresOnRank (position newBoard) 7
baz = squaresOnFile (position newBoard) 7

{-
    function that returns a list of pieces on a rank or file
    map (string function) -> list
    append each mapped list to our string list
    unlines this string to show board
-}