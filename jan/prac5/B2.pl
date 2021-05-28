main:- EstadoInicial = [0, 0, 0],    EstadoFinal   = [3, 3, 1],
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

safe(C, M):- C1 is 3-C, M1 is 3-M, M = 0, M1 >= C1. 
safe(C, M):- M1 is 3-M, M1 = 0, M >= C. 
safe(C, M):- C1 is 3-C, M1 is 3-M, M >= C, M1 >= C1.

pasan(C, M):- member([C, M], [[0,1],[0,2],[1,1],[1,0],[2,0]]).

unPaso(1, [C, M, 0], [C1, M1, 1]):- pasan(DC, DM), C1 is C+DC, M1 is M+DM, C1 >= 0, C1 =< 3, M1 >= 0, M1 =< 3, safe(C1, M1).
unPaso(1, [C, M, 1], [C1, M1, 0]):- pasan(DC, DM), C1 is C-DC, M1 is M-DM, C1 >= 0, C1 =< 3, M1 >= 0, M1 =< 3, safe(C1, M1). 
