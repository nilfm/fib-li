main:- EstadoInicial = [0, 0, 0, 0, 0],    EstadoFinal   = [1, 1, 1, 1, 1],
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

unPaso(1, [0, B, C, D, 0], [1, B, C, D, 1]).
unPaso(1, [1, B, C, D, 1], [0, B, C, D, 0]).
unPaso(2, [A, 0, C, D, 0], [A, 1, C, D, 1]).
unPaso(2, [A, 1, C, D, 1], [A, 0, C, D, 0]).
unPaso(2, [0, 0, C, D, 0], [1, 1, C, D, 1]).
unPaso(2, [1, 1, C, D, 1], [0, 0, C, D, 0]).
unPaso(5, [0, B, 0, D, 0], [1, B, 1, D, 1]).
unPaso(5, [1, B, 1, D, 1], [0, B, 0, D, 0]).
unPaso(5, [A, 0, 0, D, 0], [A, 1, 1, D, 1]).
unPaso(5, [A, 1, 1, D, 1], [A, 0, 0, D, 0]).
unPaso(5, [A, B, 0, D, 0], [A, B, 1, D, 1]).
unPaso(5, [A, B, 1, D, 1], [A, B, 0, D, 0]).
unPaso(8, [0, B, C, 0, 0], [1, B, C, 1, 1]).
unPaso(8, [1, B, C, 1, 1], [0, B, C, 0, 0]).
unPaso(8, [A, 0, C, 0, 0], [A, 1, C, 1, 1]).
unPaso(8, [A, 1, C, 1, 1], [A, 0, C, 0, 0]).
unPaso(8, [A, B, 0, 0, 0], [A, B, 1, 1, 1]).
unPaso(8, [A, B, 1, 1, 1], [A, B, 0, 0, 0]).
unPaso(8, [A, B, C, 0, 0], [A, B, C, 1, 1]).
unPaso(8, [A, B, C, 1, 1], [A, B, C, 0, 0]).
