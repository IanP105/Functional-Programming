% Prolog 2

%% You can fill the 4 gallon jug from the faucet, taking you from a
%% problem state [X,Y] to a problem state [4,Y],
%% provided X < 4.
move([X,Y],'Top off 4-gallon jug from faucet',[4,Y]) :- X<4.
%%
%
%2. Rule corresponding to the move 'Top off 3-gallon jug from faucet'
% Takes you from problem state [X,Y] to state [X,3].  Y tops off at 3.
move([X,Y],'Top off 3-gallon jug from faucet', [X,3]) :- Y < 3.

%3. Rule corresponding to the move 'Empty 4-gallon jug onto the ground'
% Takes you from problem state [X,Y] to state [0,Y].  X will be empty.
move([X,Y],'Empty 4-gallon jug onto the ground', [0,Y]) :- X > 0.

%4. Rule corresponding to the move 'Empty 3-gallon jug onto the ground'
% Takes you from problem state [X,Y] to state [X,0].  Y will be empty.
move([X,Y],'Empty 3-gallon jug onto the ground',[X,0]) :- Y > 0.

% 5. Rule corresponding to the move 'Top off 4-gallon jug from 3-gallon
% jug'
% Takes you from [X,Y] to [X,NY]. Y cannot be empty, X cannot be
% overfilled. The variable "Diff" is used to store difference between 4
% and X.
move([X,Y],'Top off 4-gallon jug from 3-gallon jug', [4,NY]) :-
    Y > 0, X < 4, Diff is 4 - X, NY is Y - Diff, NY >= 0.

% 6. Rule corresponding to the move 'Top off 3-gallon jug from 4-gallon
% jug'
% Takes you from [X,Y] to [Z,3]. Combined, X and Y cannot contain less
% than 3. The Variable "Z" is used to store difference between 3 and Y
% and then X.
move([X,Y],'Top off 3-gallon jug from 4-gallon jug',[Z,3]) :-
X+Y >= 3, Z is X-(3-Y), Z >= 0, Z < X.

%7. Rule corresponding to the move 'Empty 3-gallon jug into 4-gallon jug'
% Takes you from [X,Y] to [Z,0]. Y cannot be empty. Z must contain both
% volumes of X and Y put together.
move([X,Y],'Empty 3-gallon jug into 4-gallon jug',[Z,0]) :- Y > 0, Z = X+Y.

%8. Rule corresponding to the move 'Empty 4-gallon jug into 3-gallon jug'
% Takes you from [X,Y] to [0,Z]. X cannot be emtpy. Z must contain both
% volumes of X and Y put together.
move([X,Y],'Empty 4-gallon jug into 3-gallon jug', [0,Z]) :- X > 0, Z = X+Y.

% Base case: If the desired state happens to also be the current state,
% and nothing is added to the list, the function has concluded.
go(ToState,ToState,[]).

% The predicate go(FromState, ToState, Steps) can be used to determine
% the steps required to go from FromState to ToState.
go(FromState, ToState, [Steps|Rest]) :- move(FromState, Steps, From1), (ToState = From1; go(From1, ToState, Rest)).

%
%
%%solution predicates
% To solve the problem try this: length(X, Y), Y < 10, solution([0,0], X).
%
% [2,0] is the goal state. No move required if you are in this state
solution([2,0],[]).
%
%The list of moves [Move|Rest] constitutes a solution from PresentState
%if Move takes you from PresentState to NextState
%and Rest represents a sequence of moves that will take
%you from NextState to the goal state.
solution(PresentState,[Move|Rest]) :- move(PresentState,Move,NextState),
    solution(NextState,Rest).
