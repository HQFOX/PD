isort(I,S):-isort(I,[],S).

isort([],S, S).

isort([X|Xs], SI, SO) :-
	insord(X,SI,SX),
	isort(Xs, SX, SO).

insord(X, [], [X]).
insord(X, [A|As], [X,A|As]) :- X=<A.
insord(X, [A|As], [A|AAs]) :-
	X>A,
	insord(X,As, AAs).

rev(L, R) :- rev(L, [], R).

rev([], R, R).
rev([A|B],X,R) :- rev(B, [A|X], R).