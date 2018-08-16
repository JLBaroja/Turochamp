module Board(
    Board(..),
    Rank(..),
    File(..),
    PieceList(..),
) where

import Data.Bits
import Data.Char
import Data.List
import Piece
import Color

type PieceList = [PieceEntry]

data Rank = Rank1 | Rank2 | Rank3 | Rank4 | Rank5 | Rank6 | Rank7 | Rank8
    deriving(Eq, Bounded, Enum)

instance Show Rank where
    show r = show $ (fromEnum r) + 1

data File = FileA | FileB | FileC | FileD | FileE | FileF | FileG | FileH
    deriving(Eq, Bounded, Enum)

instance Show File where
    show f = [chr (ord 'A' + (fromEnum f))]

data PieceEntry = PieceEntry {
    pieceAt :: Piece,
    squareIndex :: Int
} 

instance Show PieceEntry where
    show pe = (show $ pieceAt pe) ++ " on " ++ (show $ squareIndex pe)

data Board = Board {
    pieceList :: PieceList,
    sideToMove :: Color
} 

instance Show Board where
    show board = b where
                 b = "hi"

emptyBoard = Board {
    pieceList = [],
    sideToMove = White
}

toIndex :: File -> Rank -> Int
toIndex f r = 16 * rank07 + file07 where
              rank07 = fromEnum r
              file07 = fromEnum f

-- Convert an 0x88 index to a rank/file
indexToFile :: Int -> File
indexToFile index = toEnum $ (index) .&. 7

indexToRank :: Int -> Rank
indexToRank index = toEnum $ shiftR (index) 4

-- Any non zero value means that the square is invalid
onBoard :: Int -> Bool
onBoard index = index .&. 0x88 == 0