gcd(0, X, X).
gcd(X, Y, Z):- X>0, Y>0, X>=Y, A is X-Y, gcd(A, Y, Z).
gcd(X, Y, Z):- X>0, Y>0, X<Y, gcd(Y, X, Z).