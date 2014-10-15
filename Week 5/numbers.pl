/*addition*/
add(0, X, X).
add(ss(X), Y, ss(Z)):- add(X, Y, Z).

/*multiplication*/
mul(0, _, 0).
mul(ss(X), Y, Z):- mul(X, Y, A), add(Y, A, Z).
/*^^NOT HALTING IF Z is specified and others are not*/

/*factorial*/
factorial(0, ss(0)).
factorial(ss(X), Y):- factorial(X, Z), mul(ss(X), Z, Y).