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

instance Show File where
    show f = [chr (ord 'A' + (fromEnum f))]

data Square = Square {
    index   :: Int,
    pieceOn :: Maybe Piece
} 

instance Show Square where
    show sq = if onBoard sq
        then show (fileOf sq) ++ show (rankOf sq)
        else ""

data Board = Board {
    position   :: [Square],
    sideToMove :: Color
} 

instance Show Board where
    show board = show $ position board

newBoard = Board {
    position = map (\x -> Square x Nothing) [0 .. 127],
    sideToMove = White
}

-- Convert an 0x88 index to a 0-7 rank/file
fileOf :: Square -> File
fileOf square = toEnum $ (index square) .&. 7
rankOf :: Square -> Rank
rankOf square = toEnum $ shiftR (index square) 4
-- Any non zero value means that the square is invalid
onBoard sq = (index sq) .&. 0x88 == 0

--squaresOnRank pos r = filter (\x -> rankOf x == (fromEnum r) && onBoard x) pos
squaresOnRank r = filter (\x -> rankOf x == r && onBoard x)
squaresOnFile f = filter (\x -> fileOf x == f && onBoard x) 

pos = position newBoard
bar = squaresOnRank Rank1 pos
baz = squaresOnFile FileA pos