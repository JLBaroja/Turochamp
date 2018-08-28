module Chess.Board(
    Board(..),
    Rank(..),
    File(..),
    PieceEntry(..),
    Square(..),
    PieceList,
    fileRanktoSquare,
    allRanks,
    onBoard,
) where

import Data.Bits
import Data.Char
import Data.List
import Chess.Piece
import Chess.Color

newtype Square = Square {
    index :: Int
} deriving(Eq)

instance Show Square where
    show sq = show (squareToFile sq) ++ show (squareToRank sq)

type PieceList = [PieceEntry]

data Rank = Rank1 | Rank2 | Rank3 | Rank4 | Rank5 | Rank6 | Rank7 | Rank8
    deriving(Eq, Bounded, Enum)

allRanks = [Rank1, Rank2 .. Rank8] 

instance Show Rank where
    show r = show $ (fromEnum r) + 1

data File = FileA | FileB | FileC | FileD | FileE | FileF | FileG | FileH
    deriving(Eq, Bounded, Enum)

allFiles = [FileA, FileB .. FileH]

instance Show File where
    show f = [chr (ord 'A' + (fromEnum f))]

data PieceEntry = PieceEntry {
    pieceAt :: Piece,
    squareOf :: Square
} 

instance Show PieceEntry where
    show pe = (show $ pieceAt pe) ++ " on " ++ (show $ squareOf pe)

data Board = Board {
    pieceList :: PieceList,
    sideToMove :: Color
} 

instance Show Board where
    show board = pos where
         pos = ranks ++ toMove
         ranks = concatMap showRank (reverse allRanks)
         showRank r = "| " ++ (concatMap (entryAt r) allFiles) ++ "\n"
         entryAt r f = p ++ " | " where
            p = case find (\entry -> (squareOf entry) == (fileRanktoSquare f r)) (pieceList board) of
                        Just entry -> show $ pieceAt entry
                        Nothing -> " "
         toMove = (show $ sideToMove board) ++ " to move"

emptyBoard = Board {
    pieceList = [],
    sideToMove = White
}

fileRanktoSquare :: File -> Rank -> Square
fileRanktoSquare f r = Square $ 16 * rank07 + file07 where
              rank07 = fromEnum r
              file07 = fromEnum f

-- Convert an 0x88 index to a rank/file
squareToFile :: Square -> File
squareToFile sq = toEnum $ (index sq) .&. 7

squareToRank :: Square -> Rank
squareToRank sq = toEnum $ shiftR (index sq) 4

-- Any non zero value means that the square is invalid
onBoard :: Square -> Bool
onBoard sq = (index sq) .&. 0x88 == 0