main :-
	write('Pentomino Puzzle '), nl,
	write('    Please select a board size.'), nl,
	write('Numero de peças I = '), 
	current_output(Out),
	flush_output(Out),
	read(I),
	write('Numero de peças J = '), 
	current_output(Out),
	flush_output(Out),
	read(J),
	write('Numero de peças D = '), 
	current_output(Out),
	flush_output(Out),
	read(D),
	write('Numero de peças T = '), 
	current_output(Out),
	flush_output(Out),
	read(T),
	numero_pecas(I,J,D,T,Lista),
	write('CPU time = '), write(T), write(' msec'), nl.

numero_pecas(I,J,D,T,Lista) :-
	adicionaI(I,J,D,T,Lista1),
	write('cona').

adicionaI(0,J,D,T,Lista):-
	adicionaJ(J,D,T,Lista).

adicionaI(I,J,D,T,Lista) :-
	I > 0,
	I1 is I-1,
	add(['I'],Lista,Ls),
	adicionaI(I1,J,D,T,Ls).


adicionaJ(0,D,T,Lista):-
	adicionaD(D,T,Lista).

adicionaJ(J,D,T,Lista) :-
	J > 0,
	J1 is J-1,
	add(['L'],Lista,Ls),
	adicionaJ(J1,D,T,Ls).

adicionaD(0,T,Lista):-
	print_lista(Lista),
	adicionaT(T,Lista).

adicionaD(D,T,Lista) :-
	D > 0,
	D1 is D-1,
	add(['D'],Lista,Ls),
	adicionaD(D1,T,Ls).

adicionaT(0,Lista):-
	print_lista(Lista).

adicionaT(T,Lista) :-
	T > 0,
	T1 is T-1,
	add(['T'],Lista,Ls),
	adicionaT(T1,Ls).


add(X,List,[X|List]).

print_lista([]):-nl.
print_lista([A|B]):-
	write(A),
	print_lista(B),
	!.
