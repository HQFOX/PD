/*********** 
*	Peça I 
***********/

% Rotaçao = 1
% C
% D
% E
% F
place_pent('I', C, Col, Board) :-
	arg(C, Board, 'I'),
	D is C+Col,
	arg(D, Board, 'I'),	
	E is D+Col,
	arg(E, Board, 'I'),
	F is E+Col,
	arg(F, Board, 'I').

% Rotação = 2
% C D E F
place_pent('I', C, _, Board) :-
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
place_pent('L', C, Col, Board) :-
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
place_pent('L', C, Col, Board) :-
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
place_pent('L', C, Col, Board) :-
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
place_pent('L', C, Col, Board) :-
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
place_pent('D', C, Col, Board) :-
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
place_pent('T', C, Col, Board) :-
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
place_pent('T', C, Col, Board) :-
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
place_pent('T', C, Col, Board) :-
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
place_pent('T', C, Col, Board) :-
	arg(C, Board, 'T'),
	D is C-(Col-1),
	arg(D, Board, 'T'),	
	E is C+1,
	arg(E, Board, 'T'),
	F is E+Col,
	arg(F, Board, 'T').