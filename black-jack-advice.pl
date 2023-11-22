% Simple black jack rules:
% mostly based off this photo: https://www.draftkings.com/v2/landingpages-assets/blt02fb52e5e7a6fbb9/blt5f35bb7ea125a73a/626c28083debbf3afdd2c9bc/DESKTOP_blackjackhtp2.png

move(M) :- write(M), nl.

value("2", 2).
value("3", 3).
value("4", 4).
value("5", 5).
value("6", 6).
value("7", 7).
value("8", 8).
value("9", 9).
value("10", 10).
value("j", 10).
value("q", 10).
value("k", 10).
value("a", 1).
value("a", 11).

same(A, A).

get_player_hand(PH) :- repeat, write('Enter one of your cards or s to stop: ' ), read_string(user, "\n", "\r", _, Response), 
					memberchk(Response, ["2", "3", "4", "5", "6", "7", "8", "9", "10", "j", "q", "k", "a", "s"]), 
					(Response == "s" -> PH = [] ; get_player_hand(PH1), PH = [Response|PH1]).
					
get_dealer_card(DC) :- repeat, write('Enter the house''s shown card: '), read_string(user, "\n", "\r", _, DC), 
					memberchk(DC, ["2", "3", "4", "5", "6", "7", "8", "9", "10", "j", "q", "k", "a"]).

print_hand([C|[]]) :- write(C).
print_hand([H|T]) :- write(H), write(', '), print_hand(T).

print_player(PH) :- write('Your hand: '), print_hand(PH), nl.
print_dealer(DC) :- write('Dealer''s hand: '), print_hand([DC]), nl.

sum_hand([], 0).
sum_hand([H|T], S) :- sum_hand(T, S2), value(H, X), S is S2 + X.

double(PH, DC) :- not(same(DC, "a")), sum_hand(PH, S), S == 11.
double(PH, DC) :- not(same(DC, "a")), not(same(DC, "10")), sum_hand(PH, S), S == 10.
double(PH, DC) :- value(DC, X), X < 7, X > 2, sum_hand(PH, S), S == 9.

split([H|[T|[]]]) :- same(H, T), (H == "8" ; H == "a").

stand(PH, _) :- sum_hand(PH, S), S > 16, not(S > 21).
stand(PH, DC) :- value(DC, X), X < 7, sum_hand(PH, S), S > 12, not(S > 21).
stand(PH, DC) :- value(DC, X), X < 7, X > 3, sum_hand(PH, S), S == 12.

hit(PH, _) :- sum_hand(PH, S), S < 12, not(S > 21).
hit(PH, DC) :- value(DC, X), X < 17, sum_hand(PH, S), S < 17, not(S > 21).
hit(PH, DC) :- value(DC, X), X < 4, sum_hand(PH, S), S == 12.

bust(PH) :- sum_hand(PH, S), S > 21.

won(PH) :- sum_hand(PH, S), S == 21.

make_move(PH, DC) :- double(PH, DC), move('Double.').
make_move(PH, _) :- split(PH), move('Split.').
make_move(PH, DC) :- stand(PH, DC), move('Stand.').
make_move(PH, DC) :- hit(PH, DC), move('Hit.').
make_move(PH, _) :- bust(PH), move('Busted!').
make_move(PH, _) :- won(PH), move('Winner!').

% query ask advice to run program
ask_advice :- get_player_hand(PH), get_dealer_card(DC), print_player(PH), print_dealer(DC), make_move(PH, DC).