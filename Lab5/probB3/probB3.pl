main:- 
    EstadoInicial = [0, 0, 0, 0, 0],    
    EstadoFinal   = [1, 1, 1, 1, 1],
    between(1,1000,CosteMax),
    camino( CosteMax, EstadoInicial, EstadoFinal, [EstadoInicial], Camino ),
    reverse(Camino,Camino1), write(Camino1), write(' con coste '), write(CosteMax), nl, halt.

camino(0, E, E, C, C).
camino(
    CosteMax, 
    EstadoActual, 
    EstadoFinal, 
    CaminoHastaAhora, 
    CaminoTotal
):-
    CosteMax>0,
    unPaso(CostePaso, EstadoActual, EstadoSiguiente),
    \+member(EstadoSiguiente, CaminoHastaAhora),
    CosteMax1 is CosteMax-CostePaso,
    camino(
        CosteMax1,
        EstadoSiguiente,
        EstadoFinal, 
        [EstadoSiguiente|CaminoHastaAhora], 
        CaminoTotal
    ).

% Cost 1: Only 1 can move
unPaso(1, [0, B, C, D, 0], [1, B, C, D, 1]).
unPaso(1, [1, B, C, D, 1], [0, B, C, D, 0]).
% Cost 2: 1 and 2 can move
unPaso(2, [A, 0, C, D, 0], [A, 1, C, D, 1]).
unPaso(2, [A, 1, C, D, 1], [A, 0, C, D, 0]).
unPaso(2, [0, 0, C, D, 0], [1, 1, C, D, 1]).
unPaso(2, [1, 1, C, D, 1], [0, 0, C, D, 0]).
% Cost 5: 1, 2, 5 can move
unPaso(5, [0, B, 0, D, 0], [1, B, 1, D, 1]).
unPaso(5, [1, B, 1, D, 1], [0, B, 0, D, 0]).
unPaso(5, [A, 0, 0, D, 0], [A, 1, 1, D, 1]).
unPaso(5, [A, 1, 1, D, 1], [A, 0, 0, D, 0]).
unPaso(5, [A, B, 0, D, 0], [A, B, 1, D, 1]).
unPaso(5, [A, B, 1, D, 1], [A, B, 0, D, 0]).
% Cost 8: 1, 2, 5, 8 can move
unPaso(8, [0, B, C, 0, 0], [1, B, C, 1, 1]).
unPaso(8, [1, B, C, 1, 1], [0, B, C, 0, 0]).
unPaso(8, [A, 0, C, 0, 0], [A, 1, C, 1, 1]).
unPaso(8, [A, 1, C, 1, 1], [A, 0, C, 0, 0]).
unPaso(8, [A, B, 0, 0, 0], [A, B, 1, 1, 1]).
unPaso(8, [A, B, 1, 1, 1], [A, B, 0, 0, 0]).
unPaso(8, [A, B, C, 0, 0], [A, B, C, 1, 1]).
unPaso(8, [A, B, C, 1, 1], [A, B, C, 0, 0]).