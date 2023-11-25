# Prolog-Games
Few games created using Prolog

## rock-paper-scissors.pl:  
  - Can play rock, paper, scissors with the computer
  - To run, run SWI-Prolog, consult the file, then query play.
  - The computer tries to predict your next move based on your last move
    - Statistically speaking, a person will choose an option that just worked for them. They will assume an opponent will do the same if they win.
    - If the computer loses it assumes the user will pick the move again, so the computer picks the move that beats the user's last move.
    - If the computer wins it assumes the user will pick the move that will beat the computer's last move, so the computer picks the user's last move.

## tic-tac-toe.pl:
  - Based on tic-tac-toe code from Michael J Scott's Programming Language Pragmatics.
  - Made printing nicer, added difficulties, and made a few other small changes.
  - To run, run SWI-Prolog, consult the file, then query play(D) where D is "e", "m", "h", or "i", for easy, medium, hard, or impossible respectively.
  - You make a move by entering a number 1-9 representing a square on the board.
  - Easy mode will go for a win and block a win, but it will never try and build a split or try to block a split
  - Medium will do the same as easy, except it adds trying to create splits.
  - Hard will do the same as medium except it will also try to block splits you create.
    - From what I can tell there is only one way to win on hard mode:
      - 1. Go in any corner
      - 2. After the computer takes the middle take the opposite corner on the diagonal
      - 3. The computer will then try to block you from creating a split by taking one of the last two remaining corners, but 
      either corner would get you a split.
      - 4. Then, you block the computer from winning and create a split at the same time by taking the last corner
      - 5. The computer will block one of the possible winning moves, but there should be one left for you to take and win
  - Impossible will not block splits using the same rule as hard. It uses two different build functions, unlike the other difficulties that use one, and they build while making sure the opponent cannot win.

## black-jack-advice.pl:
  - Takes your deck of cards, the dealer's shown card, and determines if you should hit, stand, double, or split.
  - To run, run SWI-Prolog, consult the file, then query ask_advice.
  - After running, the user will be asked to enter their cards, then the dealer's with a, k, q, j, representing ace, king, queen, and jack respectively.
  - Program essentially follows this picture:
  <img src="https://www.draftkings.com/v2/landingpages-assets/blt02fb52e5e7a6fbb9/blt5f35bb7ea125a73a/626c28083debbf3afdd2c9bc/DESKTOP_blackjackhtp2.png" alt="draft kings black jack moves for every set of cards" width="300"/>
