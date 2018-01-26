

main :-
	write('Pentomino Puzzle '), nl,
	write('    Please select a board size.'), nl,
	write('Numero de peças I = '), 
	current_output(Out),
	flush_output(Out),
	read(I),
	write('Numero de peças L = '), 
	current_output(Out),
	flush_output(Out),
	read(L),
	numero_pecas(I,L,Lista),
	write('CPU time = '), write(T), write(' msec'), nl.

numero_pecas(I,L,Lista) :-
	adicionaI(I,Lista1),
	adicionaL(L,Lista2),
	append(Lista1,Lista2,Lista),
	write('cona').

adicionaL(0,Lista):-
	print_lista(Lista).

adicionaL(L,Lista) :-
	L > 0,
	J is L-1,
	add(['L'],Lista,Ls),
	adicionaL(J,Ls).


adicionaI(0,Lista):-
	print_lista(Lista).

adicionaI(I,Lista) :-
	I > 0,
	J is I-1,
	add(['I'],Lista,L),
	adicionaI(J,L).


add(X,List,[X|List]).

print_lista([]):-nl.
print_lista([A|B]):-
	write(A),
	print_lista(B),
	!.



main:-
	I = 'L', 
	N = 3, 
	findall(I, between(1,N,_), L).
