module Color (
    Color(..),
    other,
) where

data Color = White | Black
    deriving(Show, Eq)

other :: Color -> Color
other White = Black
other Black = White