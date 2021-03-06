/**
* Portfolio Exercise 2 a
* The royal family
* Created by Alexander Keidel, 22397868 on 06.02.2017
* last edited on 06.02.2017
*/

%male persons
male(philip).
male(charles).
male(andrew).
male(edward).
male(william).
male(harry).

%female persons
female(elizabeth).
female(anne).
female(diana).

%parents
parents(charles, elizabeth, philip).
parents(anne, elizabeth, philip).
parents(andrew, elizabeth, philip).
parents(edward, elizabeth, philip).
parents(william, diana, charles).
parents(harry, diana, charles).

%given original brother rule
brother(X, Y):- male(X),
	parents(X,M,F),
	parents(Y,M,F).

%sister rule based on original brother rule
sister(X, Y):- female(X),
	parents(X, M, F),
	parents(Y, M, F).

%new brother rule to prevent finding person their own sibling
brother2(X, Y):-
	male(X),
	parents(X, M, F),
	parents(Y, M, F),
        (X \= Y).

%new sister rule to prevent finding person as their own sibling
sister2(X, Y):-
	female(X),
	parents(X, M, F),
	parents(Y, M, F),
	 (X \= Y).



