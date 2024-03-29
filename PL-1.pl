% Prolog 1

%%factorial definition
factorial(0,1).
factorial(N,Result) :- N > 0,P is N-1,factorial(P,Q),Result is N*Q.

%%bigger definition
bigger(X,Y,X) :- X > Y.
bigger(X, Y, Y) :- Y >= X.

%1: oddSize
% The base case handles when the list has one element, meaning that it
% has an odd length.  The recursive call determines that a list has an
% odd length by checking that the tail is an even length. Even length
% tail plus the head [length 1] results in an odd size list. The \+ in
% front of the call means "not oddSize", so even.
oddSize([_ | []]).
oddSize([_ | Tail]) :- \+ oddSize(Tail).

%2: evenSize
% The base case handles a list with no elements, as length 0 is
% considered an even length. The recursive call starts by skipping the
% first two elements of the list. If the resulting tail is even length,
% then the entire list has an odd length. Otherwise, the resursive call
% continues until the base case is reached.
evenSize([]).
evenSize([_,_|Tail]) :- evenSize(Tail).

%3: isPrefix
% The base case handles an empty list, which is always a prefix of any
% given list. The recursive call checks whether the first element "X" of
% list "Xs" matches first element of "Ys". If it does, then then the
% recursion checks if "Xs" is a prefix of "Ys". If all elements of "X"
% are found in "Y" and in the same order, then "X" is a prefix of "Y".
isPrefix([], _).
isPrefix([X|Xs], [X|Ys]) :- isPrefix(Xs, Ys).

%4: isMember
% The base case handles when the first element of list "X" is item "X",
% which validates since it is a member. The recursive call occurs when
% the first item is not "X". It first checks if "X" is a member of the
% tail of the list.  If so, it validates.  If not, it fails.
isMember(X, [X|_]).
isMember(X, [_|Tail]) :- isMember(X, Tail).

%5: remove
% The base case handles when the list "[X|Tail]" is empty, resulting in
% an empty list "Z". The recursive call removes the first occurance of
% "X" from list "Tail" and stores the resulting list as "Z". If "X" is
% not the head of the list "[Head|Tail]", then "Head" is added to the
% output list "[Head|Z]" and remove is again recusively called on "T".
remove(_, [], []).
remove(X, [X|Tail], Tail).
remove(X, [Head|Tail], [Head|Z]) :- X \= Head, remove(X, Tail, Z).

%6: isUnion
% The base case handles when the first list is empty, in which the union
% of "[]" and "Y" is just "Y". The recursive call checks if the first
% element of "X" is a member of "Y", and if so, performs the recursive
% call on the rest of "X" and "Y". If first of "X" is not in "Y", then
% first of "X" is appended to the result list "Z" and the recurse call
% is done on "X" and "Y". isMember predicate is used to check for
% membership of a list.
isUnion([], Y, Y).
isUnion([X|Xs], Y, Z) :- isMember(X, Y), isUnion(Xs, Y, Z).
isUnion([X|Xs], Y, [X|Z]) :- not(isMember(X, Y)), isUnion(Xs, Y, Z).

%7: isEqual
% The base case handles when both lists are empty, and validates if so.
% The recursive call checks if the head of the first list "X" is a
% member of the second list "Y" using the isMember predicate. If so, it
% is removed from "Y" using the remove predicate and the recursive call
% is made with the tails of both lists. If "X" is not in "Y", then the
% predicate does not validate.
isEqual([],[]).
isEqual([X|Xs],Y) :- isMember(X,Y), remove(X,Y,Z), isEqual(Xs,Z).

%8: isBetween
% The base case handles when the list is empty and is true if the
% difference between "A" and "B" <= 1. The recursive call checks that
% "A" < "B" and sets "X" to be "A+1", unifying it with the head of the
% list. It then recurse calls itself with "X" as the new "A", "B", and
% "Xs" as the new list. The numbers are ensured to be between "A" and
% "B" since "X" is always > "A" and < "B".
isBetween(A, B, []) :- B - A =< 1.
isBetween(A, B, [X|Xs]) :- A < B, X is A + 1, isBetween(X, B, Xs).

%9: blend
% The base cases handle when either the first or the second list is
% empty, in which the resulting list is just the nonempty list
% unchanged. The recursive call combines the heads of both lists and
% applies the blend predicate to tails of both lists. The result is the
% concatenation of the two heads and the result of the recursive call.
% blend alternates between the two heads until one or both lists are
% empty, beofre returning the concatenated list.
blend([], Y, Y).
blend(X, [], X).
blend([X|Xs], [Y|Ys], [X,Y|Zs]) :- blend(Xs, Ys, Zs).
