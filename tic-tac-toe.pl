% Improved code from Programming Language Pragmatics by Michael L. Scott
% Plays a tic-tac-toe game where you are X and go first. 
% Can play on easy, medium, hard or impossible

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
build(A) :- o(B), line(A, B, C), empty(C).
strong_build(A) :- o(B), line(A, B, C), empty(C), not(risky(C)).
weak_build(A) :- o(B), line(A, B, C), empty(C), not(double_risky(C)).
risky(C) :- x(D), line(C, D, E), empty(E).
double_risky(C) :- x(D), x(E), different(D, E), line(C, D, F), line(C, E, G), empty(F), empty(G).

good(A, _) :- win(A).
good(A, _) :- block_win(A).
good(A, D) :- different(D, e), split(A).				% don't do splits on easy mode
good(A, D) :- same(D, h), block_split(A).				% don't block splits on easy, medium, or impossible (better version for impossible below)
good(A, D) :- different(D, i), build(A).				% build on all but impossible
good(A, D) :- same(D, i), strong_build(A).				% do strong and weak build just for impossible
good(A, D) :- same(D, i), weak_build(A).
good(5, _).
good(1, _).
good(3, _).
good(7, _).
good(9, _).
good(4, _).
good(2, _).
good(6, _).
good(8, _).

move(A, D) :- good(A, D), empty(A), !.

board_full :- full(1), full(2), full(3), full(4), full(5), full(6), full(7), full(8), full(9).

done :- ordered_line(A, B, C), o(A), o(B), o(C), write('I WIN!!!'), nl.
done :- board_full, write('Draw. Try again'), nl.

getmove :- write('Please enter a move: '), read(X), empty(X), assert(x(X)).
makemove(D) :- move(X, D), !, assert(o(X)).
makemove(_) :- board_full.

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
play(D) :- not(clear), repeat, getmove, respond(D).
respond(_) :- ordered_line(A, B, C), x(A), x(B), x(C), printboard, write('You won.'), nl. 
respond(D) :- makemove(D), printboard, done.
