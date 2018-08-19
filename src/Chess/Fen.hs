import Data.Char
import Data.Maybe
import Piece
import Board
import Color

startFEN = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"

foo = words startFEN
splitLines = splitByChar '/' $ head foo
first = head $ splitLines

test = concatMap files splitLines

zipRanks = zip [Rank8, Rank7 .. Rank1] 

parsePieces = concatMap parseRank $ zipRanks splitLines

parseRank :: (Rank, String) -> PieceList
parseRank (r, s) = map (toEntry r) (files s)

toEntry :: Rank -> (Int, Piece) -> PieceEntry
toEntry rank (f, p) = PieceEntry p i where
                      i = toIndex (toEnum f) rank

shift :: Int -> [(Int, a)] -> [(Int, a)]
shift k = map (\(i, x) -> (k+i,x))

files :: String -> [(Int, Piece)]
files [] = []
files (c:rst)
    | isDigit c = shift (digitToInt c) (files rst)
    | otherwise = (0, (fromJust . charToPiece) c):shift 1 (files rst)

-- I can't tell if I'm a genius or if this is a horribly disgusting hack
splitByChar c list = words $ map (\x -> if x == c then ' ' else x) list