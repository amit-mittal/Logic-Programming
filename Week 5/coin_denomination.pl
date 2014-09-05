/*addition*/
add(0, X, X).
add(ss(X), Y, ss(Z)):- add(X, Y, Z).

/*multiplication*/
mul(0, _, 0).
mul(ss(X), Y, Z):- mul(X, Y, A), add(Y, A, Z).

/*coin exchange problem*/
exchange(0, [], []):- X=:=0.
exchange(0, [_|T], [0|L]):- exchange(0, T, L).
exchange(X, [H|T], [A|B]):- add(Val, Y, X), mul(H, A, Val), exchange(Y, T, B).