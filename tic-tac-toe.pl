% Improved code from Programming Language Pragmatics by Michael L. Scott
% Plays a tic-tac-toe game where you are X and go first. 
% Hard to beat but it is possible

ordered_line(1, 2, 3).
ordered_line(4, 5, 6).
ordered_line(7, 8, 9).
ordered_line(1, 4, 7).
ordered_line(2, 5, 8).
ordered_line(3, 6, 9).
ordered_line(1, 5, 9).
ordered_line(3, 5, 7).

:- dynamic o/1.
:- dynamic x/1.

line(A, B, C) :- ordered_line(A, B, C).
line(A, B, C) :- ordered_line(A, C, B).
line(A, B, C) :- ordered_line(B, A, C).
line(A, B, C) :- ordered_line(B, C, A).
line(A, B, C) :- ordered_line(C, A, B).
line(A, B, C) :- ordered_line(C, B, A).

full(A) :- o(A).
full(A) :- x(A).
empty(A) :- not(full(A)).

same(A, A).
different(A, B) :- not(same(A, B)).

win(A) :- o(B), o(C), line(A, B, C).
block_win(A) :- x(B), x(C), line(A, B, C).
split(A) :- o(B), o(C), different(B, C), line(A, B, D), line(A, C, E), empty(D), empty(E).
block_split(A) :- x(B), x(C), different(B, C), line(A, B, D), line(A, C, E), empty(D), empty(E).
strong_build(A) :- o(B), line(A, B, C), empty(C), not(risky(C)).
weak_build(A) :- o(B), line(A, B, C), empty(C), not(double_risky(C)).
risky(_) :- o(D), line(_, D, E), empty(E).
double_risky(C) :- o(D), o(E), different(D, E), line(C, D, F), line(C, E, G), empty(F), empty(G).

good(A) :- win(A).
good(A) :- block_win(A).
good(A) :- split(A).
good(A) :- block_split(A).
good(A) :- strong_build(A).
good(A) :- weak_build(A).
good(5).
good(1).
good(3).
good(7).
good(9).
good(4).
good(2).
good(6).
good(8).

move(A) :- good(A), empty(A), !.

board_full :- full(1), full(2), full(3), full(4), full(5), full(6), full(7), full(8), full(9).

done :- ordered_line(A, B, C), o(A), o(B), o(C), write('I WIN!!!'), nl.
done :- board_full, write('Draw. Try again'), nl.

getmove :- write('Please enter a move: '), read(X), empty(X), assert(x(X)).
makemove :- move(X), !, assert(o(X)).
makemove :- board_full.

printsquare(N) :- o(N), write(' o ').
printsquare(N) :- x(N), write(' x ').
printsquare(N) :- empty(N), write(' . ').
printboard :- printsquare(1), write('|'), printsquare(2), write('|'), printsquare(3), nl, 
            write('---|---|---'), nl,
            printsquare(4), write('|'), printsquare(5), write('|'), printsquare(6), nl, 
            write('---|---|---'), nl,
            printsquare(7), write('|'), printsquare(8), write('|'), printsquare(9), nl.
clear :- x(A), retract(x(A)), fail.
clear :- o(A), retract(o(A)), fail.

% main target, to run consult this file then query play
play :- not(clear), repeat, getmove, respond.
respond :- ordered_line(A, B, C), x(A), x(B), x(C), printboard, write('You won.'), nl. 
respond :- makemove, printboard, done.