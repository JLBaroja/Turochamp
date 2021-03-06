module Chess.Piece (
    Piece(..),
    PieceType(..),
    charToPiece
) where

import Data.Char 
import Chess.Color

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

charToPiece :: Char -> Maybe Piece
charToPiece c = if lowercase `elem` "pnbrqk"
                then let color = if isUpper c then White else Black
                         kind  = case lowercase of
                                 'p' -> Pawn
                                 'n' -> Knight
                                 'b' -> Bishop
                                 'r' -> Rook
                                 'q' -> Queen
                                 'k' -> King
                     in Just $ Piece color kind
                else Nothing
            where lowercase = toLower c
