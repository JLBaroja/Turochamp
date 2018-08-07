module Board(
    Board(..),
) where

import Data.Bits
import Data.Char
import Piece
import Color

data Rank = Rank1 | Rank2 | Rank3 | Rank4 | Rank5 | Rank6 | Rank7 | Rank8
    deriving(Eq, Bounded, Enum)

instance Show Rank where
    show r = show $ (fromEnum r) + 1

data File = FileA | FileB | FileC | FileD | FileE | FileF | FileG | FileH
    deriving(Eq, Bounded, Enum)

-- instance Show File where
--    show f = show $ ord $ ((fromEnum f) + 65)

data Square = Square {
    index   :: Int,
    pieceOn :: Maybe Piece
} 

instance Show Square where
    show sq = show $ rankOf sq

data Board = Board {
    position   :: [Square],
    sideToMove :: Color
} deriving (Show)

newBoard = Board {
    position = map (\x -> Square x Nothing) [0 .. 127],
    sideToMove = White
}

-- Convert an 0x88 index to a 0-7 rank/file
fileOf square = (index square) .&. 7
rankOf square = shiftR (index square) 4
-- Any non zero value means that the square is invalid
onBoard sq = (index sq) .&. 0x88 == 0

squaresOnRank pos r = filter (\x -> rankOf x == (fromEnum r) && onBoard x) pos
squaresOnFile pos f = filter (\x -> fileOf x == (fromEnum f) && onBoard x) pos

pos = position newBoard
bar = squaresOnRank pos Rank1
baz = squaresOnFile pos FileA