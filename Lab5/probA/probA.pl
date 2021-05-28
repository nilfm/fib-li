% Just apply all clues
solution(Sol):- 
    Sol = [ 
        [1,_,_,_,_,_], 
        [2,_,_,_,_,_], 
        [3,_,_,_,_,_], 
        [4,_,_,_,_,_], 
        [5,_,_,_,_,_] 
    ], 
    clue1(Sol), 
    clue2(Sol), 
    clue3(Sol), 
    clue4(Sol), 
    clue5(Sol), 
    clue6(Sol), 
    clue7(Sol), 
    clue8(Sol), 
    clue9(Sol), 
    clue10(Sol), 
    clue11(Sol), 
    clue12(Sol), 
    clue13(Sol), 
    clue14(Sol).

clue1(Sol):- 
    member([_,rojo,_,_,_,peru], Sol).
clue2(Sol):- 
    member([_,_,_,perro,_,francia], Sol).
clue3(Sol):- 
    member([_,_,pintor,_,_,japon], Sol).
clue4(Sol):- 
    member([_,_,_,_,ron,china], Sol).
clue5(Sol):- 
    member([1,_,_,_,_,hungria], Sol).
clue6(Sol):- 
    member([_,verde,_,_,conac,_], Sol).
clue7(Sol):- 
    member([A1,verde,_,_,_,_], Sol), 
    member([A,blanco,_,_,_,_], Sol), 
    A1 is A-1.
clue8(Sol):- 
    member([_,_,escultor,caracol,_,_], Sol).
clue9(Sol):- 
    member([_,amarillo,actor,_,_,_], Sol).
clue10(Sol):- 
    member([3,_,_,_,cava,_], Sol).
% We need to duplicate some predicates to check for both neighbors
clue11(Sol):- 
    member([B1,_,actor,_,_,_], Sol), 
    member([B,_,_,caballo,_,_], Sol), 
    B1 is B-1.
clue11(Sol):- 
    member([B1,_,actor,_,_,_], Sol), 
    member([B,_,_,caballo,_,_], Sol), 
    B1 is B+1.
clue12(Sol):- 
    member([C1,_,_,_,_,hungria], Sol), 
    member([C,azul,_,_,_,_], Sol), 
    C1 is C-1. 
clue12(Sol):- 
    member([C1,_,_,_,_,hungria], Sol), 
    member([C,azul,_,_,_,_], Sol), 
    C1 is C+1. 
clue13(Sol):- 
    member([_,_,notario,_,whisky,_], Sol).
clue14(Sol):- 
    member([D1,_,medico,_,_,_], Sol), 
    member([D,_,_,ardilla,_,_], Sol), 
    D1 is D-1.
clue14(Sol):- 
    member([D1,_,medico,_,_,_], Sol), 
    member([D,_,_,ardilla,_,_], Sol), 
    D1 is D+1.

main:-
    solution(Sol),
    writeSol(Sol),
    halt.

writeSol([]):- !.
writeSol([X|L]):- 
    write(X), nl, 
    writeSol(L).