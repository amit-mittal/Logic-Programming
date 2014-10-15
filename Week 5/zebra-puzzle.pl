person(english).
person(swede).
person(germans).
person(dane).
person(norway).

color(red).
color(yellow).
color(green).
color(white).
color(blue).

smoke(prince).
smoke(blend).
smoke(bluemasters).
smoke(dunhills).
smoke(pallmall).

drink(tea).
drink(milk).
drink(coffee).
drink(water).
drink(bier).

pet(dogs).
pet(horses).
pet(cats).
pet(birds).
pet(fish).

first(X):-person_color(norway, X).
first(X):-left(X, Y), left(Y, Z), left(Z, A), left(A, _).
left(green, white).
center(X):-left(Z, Y), left(Y, X), first(Z).

person_color(english, red).
person_color(X, Y):-person(X), color(Y).

person_pet(swede, dogs).
person_pet(X, horses):-neighbour(Y, X), person_smoke(Y, dunhills), person(X), person(Y).
person_pet(X, Y):-person(X), pet(Y).

person_smoke(germans, prince).
person_smoke(X, blend):-neighbour(Y, X), person_pet(Y, cats), neighbour(Z, X), person_drinks(Z, water), person(X), person(Y), person(Z).
person_smoke(X, bluemasters):-person_drinks(X, bier), person(X).
person_smoke(X, Y):-person(X), smoke(Y).

person_drinks(dane, tea).
person_drinks(X, Y):-(Y=:=milk, person(X), person_color(X, Y), center(Y));(person(X), drink(Y)).

color_drinks(green, coffee).
color_drinks(X, Y):-person_color(Z, X), person_drinks(Z, Y), person(Z), color(X), drink(Y).

smoke_pet(pallmall, birds).
smoke_pet(X, Y):-person_smoke(Z, X), person_pet(Z, Y), person(Z), smoke(X), pet(Y).

color_smoke(yellow, dunhills).
color_smoke(X, Y):-person_smoke(Z, Y), person_color(Z, X), person(Z), smoke(Y), color(X).

neighbour(norway, X):-person_color(X, blue), person(X).
neighbour(X, Y):-left(X, Y);left(Y, X).