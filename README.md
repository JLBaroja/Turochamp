## Turochamp

The only modern open-source [UCI](https://en.wikipedia.org/wiki/Universal_Chess_Interface) implementation of the world's first chess playing algorithm, Turochamp, written in Haskell.

Turochamp was a theoretical chess playing algorithm created by [Alan Turing](https://en.wikipedia.org/wiki/Alan_Turing) and David Champernowne in 1948.
Since there was no machine yet that could execute the instructions, Turing acted as a human CPU, performing calculations on paper which required more than half an hour per move.
Only [one game](http://www.chessgames.com/perl/chessgame?gid=1356927) from 1952 is recorded, where Turochamp lost to one of Turing's colleagues.
However, it won an earlier unrecorded game versus Champernowne's wife, a beginner at chess. 

Turochamp is an important piece of chess and computing history,
and surprisingly nobody has made an open source version of the engine until now.
The ChessBase software company created a Turochamp engine in 2004,
but unfortunately it is closed source, bundled with an installer,
and only runs on their paid Fritz software (~$80).

## Accuracy

The purpose of this project is to emulate Turing's algorithm as accurately as possible.
There are a few missing cases in the algorithm such as stalemate or the 50-move rule.

ChessBase descirbed this problem and their solution to it in their [blog post](https://en.chessbase.com/post/reconstructing-turing-s-paper-machine):

> ...the ChessBase team encountered a problem: the engine refused to duplicate all of Turing’s moves as recorded in the Glennie game. It deviated in ten places...

Their implementation had been reviewed by multiple people, including Ken Thompson, and nobody could explain the inconsistent moves.
The conclusion was that Turing made mistakes during the long calculations and likely also pruned certain lines that he knew would be bad from the start so that he didn't have to spend extra time calculating bad lines (that turned out to be better than he had thought).

With that being said, this version of the engine (like the ChessBase one) will follow the strict rules
from Turing's intended design, even though that would ironically produce different results from Turing's recorded game.

This engine will aim to duplicate every single move between the [game](http://www.chessgames.com/perl/chessgame?gid=1670503) between Garry Kasparov and the ChessBase Turing engine.


### Evaluation

- **Point Values for Material:** *Pawn=1, Knight=3, Bishop=3.5, Rook=5, Queen=10*
- **Mobility:** *For the pieces other than Kings and pawns, add the square roots of the number of moves that the piece can make, counting a capture as two moves.*
- **Piece safety:** *If a Rook, Bishop, or Knight is defended once, add 1 point; add 1.5 points if it is defended twice.*
- **King mobility:** *Use the same method as above, but don’t count castling.*
- **King safety:** *Deduct x points for a vulnerable King, with x being the number of moves that a Queen could move if it were on the same square as the one occupied by the King.*
- **Castling:** *When evaluating a move, add 1 point if castling is still possible after the move is made. Add another point if castling is immediately possible or if the castling move has just been performed.*
- **Pawn credit:** *Score 0.2 points for each square advanced, plus 0.3 points for each pawn defended by one or more non-pawns.*
- **Checks and mate threats:** *Score 1 point for the threat of mate and a half-point for a check.*

___

> *"If I were to sum up the weakness of the system in a few words I would describe it as a caricature of my own play. It was in fact based on an introspective analysis of my thought processes when playing, with considerable simplifications. It makes oversights which are very similar to those which I make myself, and which may in both cases by ascribed to the considerable moves being rather inappropriately chosen. This fact might be regarded as supporting the rather glib view which is often expressed, to the effect that 'one cannot programme a machine to play a better game than one plays oneself'. This statement should I think be compared with another of rather similar form. 'No animal can swallow an animal heaveier than himself'. Both statements are, so far as I know, untrue. "* 
>
>\- Alan Turing

As Turing suspected, the chess programs of today are able to easily defeat even the strongest human players under normal conditions. Whether computation could ever solve chess remains an open question.

Alan Turing, (1953) *[Faster Than Thought](https://docs.google.com/file/d/0B0xb4crOvCgTNmEtRXFBQUIxQWs/edit)*.