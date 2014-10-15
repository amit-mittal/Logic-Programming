/*addition*/
add(0, X, X).
add(ss(X), Y, ss(Z)):- add(X, Y, Z).

/*multiplication*/
mul(0, _, 0).
mul(_, 0, 0).
mul(ss(X), Y, Z):- mul(X, Y, A), add(Y, A, Z).

/*coin exchange problem*/
exchange(0, [], []).
/*Assuming H wont be 0*/
exchange(0, [H|T], [A|B]):- mul(H, A, 0), exchange(0, T, B).
exchange(ss(X), [H|T], [A|B]):- add(Val, Y, ss(X)), mul(H, A, Val), exchange(Y, T, B).