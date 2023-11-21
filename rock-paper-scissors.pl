% Can play rock, paper, scissors with the computer
% Computer tries to predict your next move based off your last

player_win :- write('You win!'), nl.
player_lose :- write('You lose.'), nl.
draw :- write('It''s a draw'), nl.

:- dynamic(current_pick/1).
:- dynamic(last_pick/1).
:- dynamic(last_result/1).		% if -1, then nobody won, if 0, then user won, if 1, then comp won

:- dynamic(win_count/1).
:- dynamic(total_games_count/1).

wins(p, r).
wins(r, s).
wins(s, p).

winner(P, C) :- wins(P, C), player_win, set_last_result(0), inc_total.
winner(P, C) :- wins(C, P), player_lose, set_last_result(1), inc_wins, inc_total.
winner(C, C) :- draw, set_last_result(-1), inc_total.

inc_wins :- win_count(X), Y is X + 1, retractall(win_count(_)), assertz(win_count(Y)).
inc_total :- total_games_count(X), Y is X + 1, retractall(total_games_count(_)), assertz(total_games_count(Y)).

show_counts :- nl, write('My wins: '), win_count(Y), write(Y), nl, write('Total games: '), total_games_count(X), write(X), nl.

computer_pick(X) :- last_result(-1), random_member(X, [r, p, s]), show_comp_pick(X).
computer_pick(X) :- last_result(0), last_pick(Z), wins(X, Z), show_comp_pick(X).
computer_pick(X) :- last_result(1), last_pick(X), show_comp_pick(X).

show_comp_pick(r) :- write(rock), nl.
show_comp_pick(p) :- write(paper), nl.
show_comp_pick(s) :- write(scissors), nl.

set_last_pick() :- retractall(last_pick(_)), current_pick(X), assertz(last_pick(X)).
set_curr_pick(P) :- retractall(current_pick(_)), assertz(current_pick(P)).
set_last_result(P) :- retractall(last_result(_)), assertz(last_result(P)).

get_pick(T) :- repeat, write('Rock, paper, or scissors(r/p/s)? '), read(T), memberchk(T, [r, p, s, q]).

same(A, A).

setup :- total_games_count(_).
setup :- not(total_games_count(_)), 
		assertz(current_pick(-1)), assertz(last_pick(-1)), assertz(last_result(-1)),
	 	assertz(win_count(0)), assertz(total_games_count(0)).

% main target, to run consult this file then query play
play_game :- get_pick(P), set_last_pick(), set_curr_pick(P), computer_pick(C), winner(P, C), show_counts.
play :- setup, play_game.