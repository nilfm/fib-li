main:- 
    EstadoInicial = [0, 0],    
    EstadoFinal   = [0, 4],
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

% Podemos llenar el cubo A con 5L
unPaso(1, [_,B], [5,B]).
% Podemos llenar el cubo B con 8L
unPaso(1, [A,_], [A,8]).
% Podemos vaciar el cubo A
unPaso(1, [_,B], [0,B]).
% Podemos vaciar el cubo B
unPaso(1, [A,_], [A,0]).
% Podemos pasar el cubo B al A
unPaso(1, [A,B], [A1,0]):- A1 is A+B, A1 =< 5.
% Podemos pasar el cubo A al B
unPaso(1, [A,B], [0,B1]):- B1 is A+B, B1 =< 8.
% Podemos llenar el cubo A del todo, con el B
unPaso(1, [A,B], [5,B1]):- B1 is A+B-5, B1 >= 0.
% Podemos llenar el cubo B del todo, con el A
unPaso(1, [A,B], [A1,8]):- A1 is A+B-8, A1 >= 0.
