module Piece (
    Piece(..),
) where

import Data.Char
import Color

data PieceType = 
    Pawn   |
    Knight |
    Bishop |
    Rook   |
    Queen  |
    King
    deriving(Eq)

instance Show PieceType where
    show Pawn   = "p"
    show Knight = "n"
    show Bishop = "b"
    show Rook   = "r"
    show Queen  = "q"
    show King   = "k"

data Piece = Piece {
    pieceColor :: Color,
    pieceType :: PieceType
} deriving(Eq)

instance Show Piece where
    show (Piece White p) = map toUpper $ show p
    show (Piece Black p) = show p