module Board(
    Board(..),
) where

import Piece
import Color

data Board = Board {
    position :: [Maybe Piece],
    sideToMove :: Color
} deriving (Show)

newBoard = Board {
    position = replicate 128 Nothing,
    sideToMove = White
}