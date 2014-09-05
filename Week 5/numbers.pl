/*addition*/
add(0, X, X).
add(ss(X), Y, ss(Z)):- add(X, Y, Z).

/*multiplication*/
mul(0, _, 0).
mul(ss(X), Y, Z):- mul(X, Y, A), add(A, X, Z).