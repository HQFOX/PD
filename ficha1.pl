%z(zero).

num(z).

num(s(X)):- num(X).

le(z, X) :- num(X).
le(s(A), s(B)) :- le(A, B).

mais1(A,B):- B is s(A).

soma(z,X,X).
soma(s(X),Y,s(Z)) :- soma(X,Y,Z).

mult(z,A,z).
mult(s(A),B,X) :- mult(A,B,Y), soma(B,Y,X).