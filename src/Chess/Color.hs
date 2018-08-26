module Chess.Color (
    Color(..),
    other,
) where

data Color = White | Black
    deriving(Show, Read, Eq)

other :: Color -> Color
other White = Black
other Black = White