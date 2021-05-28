solution(A, B, C):-
    A = [A1, A2, A3],
    B = [B1, B2, B3],
    C = [C1, C2, C3],
    permutation(
        [1, 2, 3, 4, 5, 6, 7, 8, 9], 
        [A1, A2, A3, B1, B2, B3, C1, C2, C3]
    ),
    beats(A, B),
    beats(B, C),
    beats(C, A).

beats(A, B):-
    findall([X, Y], (member(X, A), member(Y, B), X > Y), L),
    length(L, S),
    S >= 5.

main:-
    solution(A, B, C),
    write("A = "), write(A), nl,
    write("B = "), write(B), nl,
    write("C = "), write(C), nl, 
    halt.