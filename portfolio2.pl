/**
 * Portfolio 2
 * Created by Alexander Keidel, 22397868
 * On 20.02.2017
 * Last edited 02.03.2017
 */

%Classifying numbers, non cut version from example
class(Number, positive) :- Number > 0.
class(0,zero).
class(Number, negative) :- Number < 0.

%Classifying numbers as positive, negative or zero using cuts
%If a number is greater than 0, it is positive. Using a cut
%will stop the program from evaluating the rest of the rules in this
%section.
%If a number is not greater than zero, it may be negative or zero.
%So the code checks to see if it is lesser than zero, meaning negative.
%If so, cut, otherwise it must be zero.
classify(Number, positive):- Number > 0,!.
classify(Number, negative):- Number < 0,!.
classify(0, zero).

%Exercise 1.b
%Splitting numbers into negative, positive and zeros.
%This particular version does not work
split([],[],[]).
split([Head|Tail], Positives, Negatives):-
	split(Tail, Positives, [Head|Negatives]);
	split(Tail, [Head|Positives], Negatives).
	%([Head] == [ ] -> !,fail;
	%(Head < 0 ->
	%writeln("Head < 0"),
	%append([], [Negatives], Safety),
	%append(Safety, Head, NewNegatives),
	%split(Tail, Positives, NewNegatives);
	%writeln("Head >= 0"),
	%append([], [Positives], Safety),
	%append(Safety, Head, NewPositives),
	%split(Tail, NewPositives, Negatives)).

/**this split approach is not working at all, since Positives and Negatives are no t lists, completely stopping this approach, as appending them or treating them as lists does not work. This could be considered an imperative approach, and was left in the code to show an example that seemed logical at the time, but is a fundamentally wrong approach to recursion and functional/logical programming
	  The idea was to have nested if statements to provide the code with an exit condition for recursion. Inside the if would be another nested if that checked the Head of the list for being smaller or greater than (or equal to) zero. It would then add the items to the list. This is revisited later with a functioning soluton.*/

% second version using the previously created classify rule and
% recursion, by splitting the list into head and tail until all values
% are classified (by the program failing to find a Head in the final
% iteration).
split2(Numbers):- [Head|Tail] = Numbers,
	classify(Head, Y),
	writeln(Head is Y),
	split2(Tail).

% third version using the maplist operator, which takes all values
% contained within a list (second parameter) and uses them as a
% parameter in the defined function (first parameter of maplist/2).
split3(Numbers):- maplist(s3classify, Numbers).

% specific classify function, as the maplist/2 operator does not take
% additional parameters.
s3classify(Number):- Number >= 0, writeln(Number is positive),!.
s3classify(Number):- writeln(Number is negative).

% this final version tries to approximate the solution in the given
% question. It takes three list parameters.
% The first list (our input numbers), are split into a head and tail.
% If the value of the head (the first value in a list) is greater or
% equal to 0, it is added to the list of positive values. A recursive
% call is made to split4/3 with the tail (the rest of the list), the
% accumilated list of positive values (L1) and lastly the negative
% values (L2). A cut is used to prevent backtracking, as each iteration
% otherwise will print its results to the user.
% If H is smaller 0, the
% third rule is called, where the logic is adjusted so the negative
% values are appended with the head, then calling the split4/3 function
% recursively.
split4([],[],[]).
split4([H|T], [H|L1], L2):-
	H >= 0,
	split4(T, L1, L2),!.
split4([H|L], L1, [H|L2]):-
	split4(L, L1, L2).

%-----------------------------------------------------------------------
%Exercise 1.c Binary Tree
%Example tree to use for this:
% t(root, t(5, nil, t(value, nil, t(test, nil, nil))), t(someNode,nil, nil))
%This recurisve piece of code will find the deepest part of a binary
%tree, defined as t(Value, Left, Right).
%It will write the value of each node into the console.
% It traverses the tree left first, going into all possible nodes,
% starting with each left node, such that the leftmost branch will be
% explored first, and the rightmost branch last.
% The depth is calculated by a depth value that is passed to each
% traverse function, finding the maximum through the max operator, in
% addition to incrementing the value on each iteration using the "is"
% operator (similar to an = operation).
traverseTree(_, 0).
traverseTree(t(Value, Left, Right), Depth):-
	writeln(Value),
        traverseTree(Left, LeftDepth),
	traverseTree(Right, RightDepth),
	Depth is max(LeftDepth, RightDepth) + 1.

% ------------------------------------------------------------------------
% Exercise 2: Graph search

%Define the edges based on the graph
edge(a,b).
edge(a,c).
edge(a,d).
edge(b,e).
edge(c,e).
edge(c,f).
edge(d,f).
edge(d,g).
edge(g,e).
edge(e,a).

%1. Determine if a path exists in a directed, acyclic graph
% Through recursion it is determined if a starting point connects to an
% end point.
findpath(Start, End):-
	edge(Start, End);
	edge(Start, X),
	findpath(X, End).

%2. Show the exact paths that are possible from Start to End
% This code uses recursion to find all possible paths where the Start
% meets the End, no matter how long they take.
% Due to its recursive nature, it will print the result as such:
% End <- Path... <- Start
% i.e. showpath(a, b) will show like this b <- a
% If more than one step is needed, it will look like this:
% e <-b b <- a
% If more than one path is found, it will show them all by pressing the
% space bar after one has been displayed.
% If no path is available it will return false.
% This code works for both acyclic and cyclic path finding, as it keeps
% track of visited fields. If the last edge (commmented out) is
% uncommented, it will enable this code to find showpath(a,a).
showpath(Start, End):-
find(Start, End, [], 0).
find(Start, End, Visited, Length):-
	edge(Start, End),
	write(End),
	write(" <- "),
	write(Start),!; %cut, solution for this one has been found
	edge(Start, X),
	find(X, End, [Start|Visited], Length), %append list of visited fields with Start
	write(" "),
	write(X),
	write(" <- "),
	write(Start),
	write(" ").
	%length(Visited, NewLength),
	%Length is NewLength.

%Show all possible paths
showallpaths():-
	edge(X,Y),
	showpath(X,Y).
