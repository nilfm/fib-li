solution(A, B, C) :- A = [A1, A2, A3], B = [B1, B2, B3], C = [C1, C2, C3], permutation([1, 2, 3, 4, 5, 6, 7, 8, 9], [A1, A2, A3, B1, B2, B3, C1, C2, C3]), gana(A, B), gana(B, C), gana(C, A).

gana(A, B) :- findall([X, Y], (member(X, A), member(Y, B), X > Y), L), length(L, S), S >= 5.
