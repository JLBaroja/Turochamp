module Chess.Fen (
    startPos,
    parseFEN
) where

import Data.Char
import Data.Maybe
import Chess.Piece
import Chess.Board
import Chess.Color

startFEN = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"

startPos = parseFEN startFEN

parseFEN :: String -> Board
parseFEN fen = board where
               board = Board {
                   pieceList = plist,
                   sideToMove = toMove
               }
               toMove = case splitFEN !! 1 of 
                        "w" -> White
                        "b" -> Black
               splitFEN = words fen
               pieceLocations = head splitFEN
               ranks = splitByChar '/' pieceLocations
               plist = parsePieces ranks

parsePieces :: [String] -> PieceList
parsePieces list = concatMap parseRank $ zipRanks list

zipRanks = zip $ reverse allRanks

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