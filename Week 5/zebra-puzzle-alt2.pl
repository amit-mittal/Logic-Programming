%  -*-prolog-*-
%
%  The Zebra puzzle:  Who owns the zebra?
%
%  According to a recent e-mail source, this puzzle originated with
%  the German Institute of Logical Thinking, Berlin, 1981. [It's possible.]
%  The terms of the puzzle are included as comments in the code below.
%
%  Solution by Jonathan Mohr (mohrj@augustana.ca)
%  Augustana University College, Camrose, AB, Canada  T4V 2R3


%  Invoke this predicate if you just want to see the answer to the
%  question posed at the end of the puzzle.
solve :-
    solve(_).


%  Invoke this predicate (with a variable parameter) if you want to
%  see a complete solution.
solve(S) :-

% There are five houses.
% Each house has its own unique color.
% All house owners are of different nationalities.
% They all have different pets.
% They all drink different drinks.
% They all smoke different cigarettes.

% (The constraints that all colors, etc., are different can only be
% applied after all or most of the variables have been instantiated.
% See below.)

% S = [[Color1, Nationality1, Pet1, Drink1, Smoke1] |_]
% The order of the sublists is the order of the houses, left to right.
    S = [[C1,N1,P1,D1,S1],
         [C2,N2,P2,D2,S2],
         [C3,N3,P3,D3,S3],
         [C4,N4,P4,D4,S4],
         [C5,N5,P5,D5,S5]],

% The English man lives in the red house.
    member([red, 'English man', _, _, _], S),
% The Swede has a dog.
    member([_, 'Swede', dog, _, _], S),
% The Dane drinks tea.
    member([_, 'Dane', _, tea, _], S),
% The green house is on the left side of the white house.
    left_of([green |_], [white |_], S),
% In the green house, they drink coffee.
    member([green, _, _, coffee, _], S),
% The man who smokes Pall Mall has birds.
    member([_, _, birds, _, pall_mall], S),
% In the yellow house, they smoke Dunhill.
    member([yellow, _, _, _, dunhill], S),
% In the middle house, they drink milk.
    D3 = milk,
% The Norwegian lives in the first house.
    N1 = 'Norwegian',
% The man who smokes Blend lives in the house next to the house with cats.
    next_to([_, _, _, _, blend], [_, _, cats |_], S),
% In the house next to the house with the horse, they smoke Dunhill.
    next_to([_, _, _, _, dunhill], [_, _, horse |_], S),
% The man who smokes Blue Master drinks beer.
    member([_, _, _, beer, blue_master], S),
% The German smokes Prince.
    member([_, 'German', _, _, prince], S),
% The Norwegian lives next to the blue house.
    next_to([_, 'Norwegian' |_], [blue |_], S),
% They drink water in the house that is next to the house 
% where they smoke Blend.
    next_to([_, _, _, water,_], [_, _, _, _, blend], S),

%
% The puzzle is so constrained that the following checks are not really
% required, but I include them for completeness (since one would not
% know in advance of solving the puzzle if it were fully constrained
% or not).
%
% Each house has its own unique color.
    C1 \== C2, C1 \== C3, C1 \== C4, C1 \== C5,
    C2 \== C3, C2 \== C4, C2 \== C5,
    C3 \== C4, C3 \== C5, C4 \== C5,
% All house owners are of different nationalities.
    N1 \== N2, N1 \== N3, N1 \== N4, N1 \== N5,
    N2 \== N3, N2 \== N4, N2 \== N5,
    N3 \== N4, N3 \== N5, N4 \== N5,
% They all have different pets.
    P1 \== P2, P1 \== P3, P1 \== P4, P1 \== P5,
    P2 \== P3, P2 \== P4, P2 \== P5,
    P3 \== P4, P3 \== P5, P4 \== P5,
% They all drink different drinks.
    D1 \== D2, D1 \== D3, D1 \== D4, D1 \== D5,
    D2 \== D3, D2 \== D4, D2 \== D5,
    D3 \== D4, D3 \== D5, D4 \== D5,
% They all smoke different cigarettes.
    S1 \== S2, S1 \== S3, S1 \== S4, S1 \== S5,
    S2 \== S3, S2 \== S4, S2 \== S5,
    S3 \== S4, S3 \== S5, S4 \== S5,

% Who owns the zebra?
    member([_, Who, zebra, _, _], S),
    write('The '), write(Who), write(' owns the zebra.\n').

% Or, replace the last line by:
%   format("The ~w owns the zebra.", Who).

left_of(L1, L2, [L1, L2 |_]).
left_of(L1, L2, [_| Rest ]) :-
    left_of(L1, L2, Rest).
    
next_to(L1, L2, S) :-
    left_of(L1, L2, S).
next_to(L1, L2, S) :-
    left_of(L2, L1, S).