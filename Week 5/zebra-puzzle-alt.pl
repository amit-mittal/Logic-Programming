% -*-prolog-*-
%
%  The Zebra puzzle:  Who owns the zebra?
%
%  According to a recent e-mail source, this puzzle originated with
%  the German Institute of Logical Thinking, Berlin, 1981. [It's possible.]
%  The terms of the puzzle are included as comments in the code below.
%
%  A solution which uses a list of colors, a list of nationalities,
%  a list of pets, a list of drinks, and a list of cigarettes, and
%  relies on the specifications of the puzzle to construct the lists.
%
%  Jonathan Mohr (mohrj@augustana.ab.ca)
%  Augustana University College, Camrose, AB, Canada  T4V 2R3
%  2001 Nov 21

solve([C1, N1, P1, D1, S1]) :-
% There are five houses.
% Each house has its own unique color.
	C1 = [_,_,_,_,_],
% All house owners are of different nationalities.
	N1 = [_,_,_,_,_],
% They all have different pets.
	P1 = [_,_,_,_,_],
% They all drink different drinks.
	D1 = [_,_,_,_,_],
% They all smoke different cigarettes.
	S1 = [_,_,_,_,_],
% The English man lives in the red house.
	samepos(red, C1, english, N1),
% The Swede has a dog.
	samepos(swedish, N1, dog, P1),
% The Dane drinks tea.
	samepos(danish, N1, tea, D1),
% The green house is on the left side of the white house.
	inorder(green, white, C1),
% In the green house, they drink coffee.
	samepos(green, C1, coffee, D1),
% The man who smokes Pall Mall has birds.
	samepos(birds, P1, pall_mall, S1),
% In the yellow house, they smoke Dunhill.
	samepos(yellow, C1, dunhill, S1),
% In the middle house, they drink milk.
	D1 = [_, _, milk, _, _],
% The Norwegian lives in the first house.
	N1 = [norwegian | _],
% The man who smokes Blend lives in the house next to the house with cats.
	next_to(blend, S1, cats, P1),
% In the house next to the house with the horse, they smoke Dunhill.
	next_to(dunhill, S1, horse, P1),
% The man who smokes Blue Master drinks beer.
	samepos(beer, D1, blue_master, S1),
% The German smokes Prince.
	samepos(german, N1, prince, S1),
% The Norwegian lives next to the blue house.
	next_to(norwegian, N1, blue, C1),
% They drink water in the house that is next to the house 
% where they smoke Blend.
	next_to(water, D1, blend, S1),
% Who owns the zebra?
	samepos(zebra, P1, Who, N1),
	format("The ~w owns the zebra.", Who), !.

samepos(A, [A|_], B, [B|_]).
samepos(A, [_|T1], B, [_|T2]) :-
	samepos(A, T1, B, T2).

inorder(L1, L2, [L1, L2 |_]).
inorder(L1, L2, [_| Rest ]) :-
    inorder(L1, L2, Rest).
    
next_to(A, [A|_], B, [_,B|_]).
next_to(A, [_,A|_], B, [B|_]).
next_to(A, [_|T1], B, [_|T2]) :-
    next_to(A, T1, B, T2).
 
