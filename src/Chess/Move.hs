module Chess.Move where

import Chess.Board
import Chess.Color
import Chess.Piece

-- Move vectors for each individual piece
rookVector = [-1, 1, 16, -16] 
bishopVector = [-15, 15, -17, 17]
knightVector = [-14, -18, -31, -33, 14, 18, 31, 33]
queenVector = rookVector ++ bishopVector

-- TODO: Add promotion possibility
data Move = Move {
    pieceToMove :: Piece,
    fromSquare :: Square,
    toSquare :: Square
}

d5 = Square 0x43

-- TODO: Remove this function
-- TODO: generate moves with the board position accounted for
getAllMovesFor :: PieceType -> Square -> [Square]
getAllMovesFor p s = case p of
                     Bishop -> slide bishopVector
                     Rook -> slide rookVector
                     Queen -> slide queenVector
                     King -> concatMap ((take 1) . slideFromOffset s) queenVector
                     Knight -> concatMap ((take 1) . slideFromOffset s) knightVector
                     otherwise -> []
                     where
                        slide = concatMap (slideFromOffset s)

foo = getAllMovesFor Rook d5
list = map (PieceEntry (Piece White Bishop)) foo
boardTest = Board (list) White

-- Only use with sliding pieces
-- generate an infinite list going in any direction
slideFromOffset :: Square -> Int -> [Square]
slideFromOffset from offset = takeWhile (onBoard) [Square x | x <- [start, next ..]] where
                                start = (index from) + offset
                                next = start + offset