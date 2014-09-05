/*Element is member of list*/
member(X, [X|_]).
member(X, [Y|Tail]):- X=\=Y, member(X, Tail).

/*Concatenate two lists*/
concat([], X, X).
concat([H|T1], Y, [H|T2]):- concat(T1, Y, T2).

/*Deletes an element from list*/
del(X, [X|T], T).
del(X, [Y|T1], [Y|T2]):- del(X, T1, T2).

/*Adds element to front of list*/
add(X, T, [X|T]).

/*Inserts element at arbit position of list*/
insert(X, Y, Z):- del(X, Z, Y).

/*Checks if X is sublist of Y*/
sublist(X, Y):- concat(Z, _, Y), concat(_, X, Z).

/*Checks if X is permutation of Y*/
permutation(X, X).
permutation([H|T], Y):- permutation(T, Z), insert(H, Z, Y).

/*Slow Sort*/
ordered([]).
ordered([_]).
ordered([X, Y|T]):- X=<Y, ordered([Y|T]).
slowsort(X, Y):- permutation(X, Y), ordered(Y).

/*Quick Sort*/
pivoting(_, [], [], []).
pivoting(X, [H|L1], [H|SL1], SL2):- H=<X, pivoting(X, L1, SL1, SL2).
pivoting(X, [H|L2], SL1, [H|SL2]):- H>X, pivoting(X, L2, SL1, SL2).
quicksort([], []).
quicksort([H|T], Y):- pivoting(H, T, L1, L2), quicksort(L1, SL1), quicksort(L2, SL2), concat(SL1, [H|SL2], Y).

/*Length*/
len([], 0).
len([_|T], X):- len(T, Y), X is Y+1.

/*reverse list*/
reverselist([], []).
reverselist([H|T], X):- reverselist(T, Y), concat(Y, [H], X).

/*reverse list faster*/
reverse_acc([], Y, Y).
reverse_acc([H|T], X, Y):- reverse_acc(T, [H|X], Y).
reverselistfast([], []).
reverselistfast(X, Y):- reverse_acc(X, [], Y).