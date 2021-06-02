main:- 
    EstadoInicial = [0, 0, 0],    
    EstadoFinal   = [3, 3, 1],
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

% It's safe if either group has 0 missionaries and the other has M majority (or equality)
% It's also safe if both groups have M majority (or equality)
safe(C, M):-
    C1 is 3-C, M1 is 3-M,
    M = 0,
    M1 >= C1.
safe(C, M):-
    M1 is 3-M,
    M >= C,
    M1 = 0.
safe(C, M):-
    C1 is 3-C, M1 is 3-M,
    M >= C,
    M1 >= C1.

canPass(C, M):-
    member(
        [C, M], 
        [
            [1, 1],
            [2, 0],
            [0, 2],
            [1, 0],
            [0, 1]
        ]
    ).

% [C, M, B] means:
%   * C cannibals on the right side
%   * M missionaries on the right side
%   * If B is 0 the boat is on the left side, otherwise it's on the right side
unPaso(1, [C0, M0, 0], [C1, M1, 1]):-
    canPass(DC, DM),
    C1 is C0 + DC,
    M1 is M0 + DM,
    C1 >= 0, C1 =< 3,
    M1 >= 0, M1 =< 3,
    safe(C1, M1).
unPaso(1, [C0, M0, 1], [C1, M1, 0]):-
    canPass(DC, DM),
    M1 is M0 - DM,
    C1 is C0 - DC,
    C1 >= 0, C1 =< 3,
    M1 >= 0, M1 =< 3,
    safe(C1, M1).
