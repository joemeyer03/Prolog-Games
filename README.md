# Prolog-Games
Few games created using Prolog

rock-paper-scissors.pl:  
  Can play rock, paper, scissors with the computer
  The computer tries to predict your next move based on your last move
  To run, run SWI-Prolog, consult the file, then query play.

tic-tac-toe.pl:
  Based on tic-tac-toe code from Michael J Scott's Programming Language Pragmatics.
  Made printing nicer and made a few other small changes.
  To run, run SWI-Prolog, consult the file, then query play.
  You make a move by entering a number 1-9 representing a square on the board.
  From what I can tell there is only one way to win:
    1. Go in any corner
    2. After the computer takes the middle take the opposite corner on the diagonal
    3. The computer will then try to block you from creating a split by taking one of the last two remaining corners, but 
    either corner would get you a split.
    4. Then, you block the computer from winning and create a split at the same time by taking the last corner
    5. The computer will block one of the possible winning moves, but there should be one left for you to take and win
