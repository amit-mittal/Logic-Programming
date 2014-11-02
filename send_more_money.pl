%% Some facts about the digits
digit(0).
digit(1).
digit(2).
digit(3).
digit(4).
digit(5).
digit(6).
digit(7).
digit(8).
digit(9).

%% Defining base 2 digit sums
sum(X, Y, Z):- digit(X), digit(Y), Z is X + Y.

%% Defining sum of no.s from right to left 
solve([], [], [], 0).
solve([X1|X], [Y1|Y], [Z1|Z], Carry):-
			sum(X1, Y1, T),
			Temp is T + Carry,
			Rem is Temp mod 10,
			digit(Z1),
			digit(Rem),
			Z1 =:= Rem,
			NCarry is div(Temp, 10),
			solve(X, Y, Z, NCarry).

%% Main predicate which user will be calling, Z = X + Y
solve(X, Y, Z):- 
			length(X, XLen),
			length(Y, YLen),
			XLen =:= YLen,
			length(Z, YLen),
			reverse(X, Xr),
			reverse(Y, Yr),
			reverse(Z, Zr),
			solve(Xr, Yr, Zr, 0).