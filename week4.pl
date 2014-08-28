female(w).
female(d).

male(me).
male(f).
male(s1).
male(s2).

wife(w, me).
wife(d, f).

daughter(d, w).

son(s1, w).
son(s2, d).

father(f, me).
father(X, Y):-(son(Y, X), male(X), male(Y));(daughter(Y, X), male(X), female(Y));(son(Y, Z), wife(Z, X), female(Z));(daughter(Y, Z), wife(Z, X), female(Z)).

grandfather(X, Z):-(father(X, Y), father(Y, Z));(father(X, Y), father(A, Z), wife(Y, A)).
