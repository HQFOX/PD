gays(fox).
gays(talisca).
gays(monginho).

%homem(fox).



heteros(reis).

%traveca(X):- homem(X), gays(X).

homem(paulo).
homem(joao).
mulher(paula).
mulher(judite).
mulher(talisca).

filho(joao,paulo).

pai(X,Y):- homem(X), filho(Y,X).



%filho(joao,paulo).
%filho(joao,paula).

