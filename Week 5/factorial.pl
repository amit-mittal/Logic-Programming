factorial(0, 1).
factorial(X, Y):- X>0, A is X-1, factorial(A, B), Y is X*B.
/*factorial(X, Y):- X>0, A is X-1, Y is X*B, factorial(A, B).*/
/*^^Not working*/
/*Why ordering of above statements matter?*/
/*factorial(X, Y):- X>0, A is X-1, factorial(A, Z), Y =:= (X*Z).*/