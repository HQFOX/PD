
/****************************************************************
  Conta Solucoes
****************************************************************/
conta_solucoes(N) :-
        findall(B, resolve_tabuleiro(N, B), L),
        length(L, C),
        write(C), write(' soluções'), nl.

/****************************************************************
  Main
****************************************************************/
main :-
	write('Tetris Puzzle '), nl,
	write('    Seleccione um tamanho para o tabuleiro.'), nl,
	write('Number = '), 
	current_output(Out),
	flush_output(Out),
	read(X),
	read_yn('fazer print de todas as soluções? (y/n)? ', All),
	read_yn('Output (y/n)? ', Output),
	statistics(runtime, _),
	resolve(X, all(All), output(Output)),
	statistics(runtime, [_,T]),
	write('CPU time = '), write(T), write(' msec'), nl.

read_yn(Message, YN) :-
	write(Message),
	flush_output,
	read(X),
	(X == 'y' -> YN = yes; YN = no).

resolve(X, all(All), output(Output)) :-
	resolve_tabuleiro(X, Board),
	(Output == yes -> show_result(Board),nl; true),
	All == no,
	!.
resolve(_, _, _).
/********************************************************************************************************/
resolve_tabuleiro(X, Board) :-
	tetris_board(X, Y, Board),
	Col is Y+2, 
	resolve(X, Y, Col, Board).


resolve(X, Y, Col, Board) :-
	pesquisa_list(List, 1, 1, X, Y, Col, Board),
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
	Pts = [],
	numero_pecas(I,J,D,T,Pts, List, Col, Board).
	/**
	Pts = ['I','I','I','I'],
	resolve0(Pts, List, Col, Board).
	**/

resolve0([], _, _, _) :- !.
resolve0(Pts, [(N, E)|Ls], Col, Board) :-
	var(E),
	!,
	not_one_space(N, Col, Board),
	select_peca(P, Pts, Pts1),
	insere_peca(P, N, Col, Board),
	resolve0(Pts1, Ls, Col, Board).

resolve0(Pts, [_|Ls], Col, Board) :-
	resolve0(Pts, Ls, Col, Board).

not_one_space(N, Col, B) :-
	(
	    N1 is N+1, arg(N1, B, X1), var(X1)
	;
	    N2 is N+Col, arg(N2, B, X2), var(X2)
	),
	!.

pesquisa_list([], I, J, X, Y, _, _) :-
	J =:= Y+1, I =:= X-1, 
	!.
pesquisa_list(L, I, J, X, Y, Col, B) :-
	I =:= 0, J =< X,
	!,
	pesquisa_list(L, J, 1, X, Y, Col, B).
pesquisa_list(L, I, J, X, Y, Col, B) :-
	I =:= 0, J > X,
	!,
	J1 is J-X+1,
	pesquisa_list(L, X, J1, X, Y, Col, B).
pesquisa_list(L, I, J, X, Y, Col, B) :-
	J =:= Y+1,
	!,
	J1 is I+2+Y-X,
	pesquisa_list(L, X, J1, X, Y, Col, B).
pesquisa_list([(N,Z)|Ls], I, J, X, Y, Col, B) :-
	N is Col*I+J+1,
	arg(N, B, Z),
        var(Z),
        !,
        I1 is I-1,
        J1 is J+1,
	pesquisa_list(Ls, I1, J1, X, Y, Col, B).
pesquisa_list(L, I, J, X, Y, Col, B) :-
        I1 is I-1,
        J1 is J+1,
	pesquisa_list(L, I1, J1, X, Y, Col, B).

/****************************************************************/ 
look_up_board(I, J, Col, B, X) :-
	P is Col*I+J+1,
	arg(P, B, X).
/*********************************************************/

tetris_board(I, I, Board) :- 
	J is I,
	make_board(I, J, Board).

make_board(I, J, Board) :-
	M is I+2, N is J+2,
	Total is M*N,
	functor(Board, b, Total), 
	frame(1, 1, M, N, Board).

frame(_, J, _, N, _) :- J > N, !.
frame(I, J, M, N, Board) :- I > M, !,
	J1 is J+1,
	frame(1, J1, M, N, Board).
frame(I, J, M, N, Board) :- 
	(I =:= 1 ; I =:= M ; J =:= 1 ; J =:= N),
	 !,
	 L is (I-1)*N+J,
	 arg(L, Board, '*'),
	 I1 is I+1,
	 J1 is J,
	 frame(I1, J1, M, N, Board).
frame(I, J, M, N, Board) :- 
	I1 is I+1,
	J1 is J,
	frame(I1, J1, M, N, Board).
/******************************************************************/
show_result(B) :-
	board_size(B, H, W),
	Col is W+2, 
	for(I, 1, H),
	nl,
	   for(J, 1, W),
	   look_up_board(I, J, Col, B, P),
	   write_tetris(P),
        fail.
show_result(_) :- nl.

write_tetris(P) :- var(P), !, write('_ ').
write_tetris(P) :- write(P), write(' ').

/****************************************************************/
board_size(B, H, W) :- 
	board_width(B, W),
	board_height(W, H).

board_width(B, W) :- 
	count_flame(B, 1, W).

count_flame(B, N, W) :- 
	arg(N, B, P), P == '*',
	!,
	N1 is N+1,
	count_flame(B, N1, W).
count_flame(_, N, W) :-
	W is N-4.

board_height(W,H) :-
	H is W.

/****************************************************************
  Peças
****************************************************************/	
insere_peca(P, I, J, Col, B) :-
	C is Col*I+J+1,
	!,
	insere_peca(P, C, Col, B).

/*********** 
*	Peça I 
***********/

% Rotaçao = 1
% C
% D
% E
% F
insere_peca('I', C, Col, Board) :-
	arg(C, Board, 'I'),
	D is C+Col,
	arg(D, Board, 'I'),	
	E is D+Col,
	arg(E, Board, 'I'),
	F is E+Col,
	arg(F, Board, 'I').

% Rotação = 2
% C D E F
insere_peca('I', C, _, Board) :-
	arg(C, Board, 'I'),
	D is C+1,
	arg(D, Board, 'I'),	
	E is D+1,
	arg(E, Board, 'I'),
	F is E+1,
	arg(F, Board, 'I').


/*********** 
*	Peça L 
***********/

% Rotação = 1
% C D E 
%     F
insere_peca('L', C, Col, Board) :-
	arg(C, Board, 'L'),
	D is C+1,
	arg(D, Board, 'L'),	
	E is D+1,
	arg(E, Board, 'L'),
	F is E+Col,
	arg(F, Board, 'L').

% Rotação = 2
%   C
%   D
% E F   
insere_peca('L', C, Col, Board) :-
	arg(C, Board, 'L'),
	D is C+Col,
	arg(D, Board, 'L'),	
	E is C+(2*Col)-1,
	arg(E, Board, 'L'),
	F is D+Col,
	arg(F, Board, 'L').

% Rotação = 3
% C
% D E F
insere_peca('L', C, Col, Board) :-
	arg(C, Board, 'L'),
	D is C+Col,
	arg(D, Board, 'L'),	
	E is D+1,
	arg(E, Board, 'L'),
	F is E+1,
	arg(F, Board, 'L').

% Rotação = 4
% C E
% D
% F 
insere_peca('L', C, Col, Board) :-
	arg(C, Board, 'L'),
	D is C+Col,
	arg(D, Board, 'L'),	
	E is C+1,
	arg(E, Board, 'L'),
	F is D+Col,
	arg(F, Board, 'L').

/*********** 
*	Peça D
***********/
% Rotação = 1
% C E
% D F
insere_peca('D', C, Col, Board) :-
	arg(C, Board, 'D'),
	D is C+Col,
	arg(D, Board, 'D'),	
	E is C+1,
	arg(E, Board, 'D'),
	F is D+1,
	arg(F, Board, 'D').

/*********** 
*	Peça T
***********/

% Rotação = 1
%   E
% C D F 
insere_peca('T', C, Col, Board) :-
	arg(C, Board, 'T'),
	D is C+1,
	arg(D, Board, 'T'),	
	E is C-(Col-1),
	arg(E, Board, 'T'),
	F is D+1,
	arg(F, Board, 'T').

% Rotação = 2
% C
% D F
% E 
insere_peca('T', C, Col, Board) :-
	arg(C, Board, 'T'),
	D is C+Col,
	arg(D, Board, 'T'),	
	E is D+Col,
	arg(E, Board, 'T'),
	F is D+1,
	arg(F, Board, 'T').

% Rotação = 3
% C D F 
%   E 
insere_peca('T', C, Col, Board) :-
	arg(C, Board, 'T'),
	D is C+1,
	arg(D, Board, 'T'),	
	E is D+Col,
	arg(E, Board, 'T'),
	F is D+1,
	arg(F, Board, 'T').

% Rotação = 4
%   D
% C E
%   F
insere_peca('T', C, Col, Board) :-
	arg(C, Board, 'T'),
	D is C-(Col-1),
	arg(D, Board, 'T'),	
	E is C+1,
	arg(E, Board, 'T'),
	F is E+Col,
	arg(F, Board, 'T').

/****************************************************************
	Utilities
****************************************************************/
for(M, M, N) :- M =< N.
for(I, M, N) :- M =< N, M1 is M + 1, for(I, M1, N).

select_peca(X, [X|Xs], Xs).
select_peca(X, [Y|Ys], [Y|Zs]) :- select_peca(X, Ys, Zs).

add(X,List,[X|List]).

print_lista([]):-nl.
print_lista([A|B]):-
	write(A),
	print_lista(B),
	!.

numero_pecas(I,J,D,T,Pts, List, Col, Board) :-
	adicionaI(I,J,D,T,Pts, List, Col, Board).

adicionaI(0,J,D,T,Pts, List, Col, Board):-
	adicionaJ(J,D,T,Pts, List, Col, Board).

adicionaI(I,J,D,T,Pts, List, Col, Board) :-
	I > 0,
	I1 is I-1,
	add('I',Pts,Ls),
	adicionaI(I1,J,D,T,Ls, List, Col, Board).


adicionaJ(0,D,T,Pts, List, Col, Board):-
	adicionaD(D,T,Pts, List, Col, Board).

adicionaJ(J,D,T,Pts, List, Col, Board) :-
	J > 0,
	J1 is J-1,
	add('L',Pts,Ls),
	adicionaJ(J1,D,T,Ls, List, Col, Board).

adicionaD(0,T,Pts, List, Col, Board):-
	adicionaT(T,Pts, List, Col, Board).

adicionaD(D,T,Pts, List, Col, Board) :-
	D > 0,
	D1 is D-1,
	add('D',Pts,Ls),
	adicionaD(D1,T,Ls, List, Col, Board).

adicionaT(0,Pts, List, Col, Board):-
	resolve0(Pts, List, Col, Board).

adicionaT(T,Pts, List, Col, Board) :-
	T > 0,
	T1 is T-1,
	add('T',Pts,Ls),
	adicionaT(T1,Ls, List, Col, Board).
