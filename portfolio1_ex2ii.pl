/**
* Portfolio Exercise 2 a
* The royal family
* Created by Alexander Keidel, 22397868 on 06.02.2017
* last edited on 06.02.2017
*/

%given facts
district(stirling, dunblane).
region(central, stirling).
country(scotland, central).
continent(europe, scotland).

%rule using the given facts (non-recursive)
within(X, Y):-district(X, Y);
	      region(X, Y);
	      country(X, Y);
	      continent(X, Y).

%rules for recursive finding
location(stirling, dunblane).
location(central, stirling).
location(scotland, central).
location(europe, scotland).

%recursive solution
within2(X, Y):- location(X, Y);
                location(X, Z),
		within2(Z, Y).
