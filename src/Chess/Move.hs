module Chess.Move(
    Move(..),
) where

import Chess.Board
import Chess.Color
import Chess.Piece
import Chess.Fen

-- Move vectors for each individual piece
rookDirections = [-1, 1, 16, -16] 
bishopDirections = [-15, 15, -17, 17]
knightDirections = [-14, -18, -31, -33, 14, 18, 31, 33]
queenDirections = rookDirections ++ bishopDirections

-- TODO: Add promotion possibility
data Move = Move {
    pieceToMove :: Piece,
    fromSquare :: Square,
    toSquare :: Square
}

d5 = Square 0x43

foo = concatMap ((take 1) . vectorFromSquare d5) knightDirections
bar = map (vectorFromSquare d5) rookDirections

testBoard = emptyBoard
testEntry = PieceEntry (Piece White Rook) d5 

test = getMovesForPiece testBoard testEntry

-- Take a pieceEntry & board, get list of moves
getMovesForPiece :: Board -> PieceEntry -> [Square]
getMovesForPiece board entry = foo where
    foo = []
    sq = squareOf entry
    piece = pieceAt entry
    color = pieceColor piece
    enemy = other color
    {-
    moves = case pieceType piece of
        Pawn -> []
        Knight -> []
        Bishop -> slide bishopDirections
        Rook -> slide rookDirections
        Queen -> slide queenDirections
        King -> [] -}

vectorFromSquare square direction = 
    takeWhile onBoard [Square x | x <- [start, next ..]] where
    start = (index square) + direction
    next = start + direction