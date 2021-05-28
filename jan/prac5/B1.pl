main:- EstadoInicial = [0, 0],    EstadoFinal   = [0, 4],
between(1,1000,CosteMax),               % Buscamos soluci on de coste 0; si no, de 1, etc.
camino( CosteMax, EstadoInicial, EstadoFinal, [EstadoInicial], Camino ),
reverse(Camino,Camino1), write(Camino1), write(' con coste '), write(CosteMax), nl, halt.

camino( 0, E,E, C,C ).
camino( CosteMax, EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
CosteMax>0,
unPaso( CostePaso, EstadoActual, EstadoSiguiente ),  % En B.1 y B.2, CostePaso es 1.
\+member( EstadoSiguiente, CaminoHastaAhora ),
CosteMax1 is CosteMax-CostePaso,
camino(CosteMax1,EstadoSiguiente,EstadoFinal, [EstadoSiguiente|CaminoHastaAhora], CaminoTotal).

unPaso(1, [_,B], [5,B]).
unPaso(1, [A,_], [A,8]).
unPaso(1, [_,B], [0,B]).
unPaso(1, [A,_], [A,0]).
unPaso(1, [A,B], [A1,0]):- A1 is A+B, A1 =< 5.
unPaso(1, [A,B], [0,B1]):- B1 is A+B, B1 =< 8.
unPaso(1, [A,B], [5,B1]):- B1 is A+B-5, B1 >= 0.
unPaso(1, [A,B], [A1,8]):- A1 is A+B-8, A1 >= 0.
