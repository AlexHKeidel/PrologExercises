/**
* Portfolio 1 Exercise 1
* Created by Alexander Keidel, 22397868
* On 25.01.2017
* Last edited 25.01.2017
*/

% male persons
male(john).
male(fred).
male(harry).

% female persons
female(mary).
female(julie).
female(susan).
female(anne).

% hair attributes
hair(john, blonde).
hair(fred, dark).
hair(harry, dark).
hair(mary, brunette).
hair(julie, blonde).
hair(susan, blonde).
hair(anne, brunette).

% gold attribute
rich(fred).
rich(julie).

% gender like attributes males only like females and vice versa
likesGender(X, Y):- male(X), female(Y); female(X), male(Y).

% likes rich attributes
likesRich(john).
likesRich(harry).
likesRich(julie).

% likes hair attributes
likesHair(john, blonde).
likesHair(fred, brunette).
likesHair(mary, dark).
likesHair(julie, dark).

% house attribute
ownsHouse(anne).

% car attribute
ownsCar(john).

% X likes Y or Y likes X
likes(X, Y):-
	likesGender(X, Y),
	(   (likesRich(X), rich(Y));
	(rich(X), likesRich(Y));
	(likesHair(X, hair(Y)));
	 (likesHair(Y, hair(X)))).

% mutually liking each other
likeMutual(X, Y):-
	likesGender(X, Y),
	(likesRich(X), rich(Y) ; rich(X), likesRich(Y),
	likesHair(X, hair(Y)) ; likesHair(Y, hair(X))).

