:- use_module(library(clpfd)).

%% A (6-sided) "letter dice" has on each side a different letter.
%% Find four of them, with the 24 letters abcdefghijklmnoprstuvwxy such
%% that you can make all the following words: bake, onyx, echo, oval,
%% gird, smug, jump, torn, luck, viny, lush, wrap.

%Some helpful predicates:

word( [b,a,k,e] ).
word( [o,n,y,x] ).
word( [e,c,h,o] ).
word( [o,v,a,l] ).
word( [g,i,r,d] ).
word( [s,m,u,g] ).
word( [j,u,m,p] ).
word( [t,o,r,n] ).
word( [l,u,c,k] ).
word( [v,i,n,y] ).
word( [l,u,s,h] ).
word( [w,r,a,p] ).

num(X,N):- nth1( N, [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,r,s,t,u,v,w,x,y], X ).

main:-
    % Create four dice with 6 variables each
    length(D1,6),
    length(D2,6),
    length(D3,6),
    length(D4,6),
    % Concatenate all dice into Vars to apply global constraints
    append([D1, D2, D3, D4], Vars),
    % Vars must be different letters, which are represented by numbers 1-24
    Vars ins 1..24,
    all_distinct(Vars),

    % Collect all pairs of letters (their number representation) which can't be on the same dice
    % because they are on the same word
    findall(N-M, notSameDice(N, M), L0), sort(L0, L),
    
    % Constrain each dice so no two forbidden letters appear on the same dice
    makeConstraints(D1, L),
    makeConstraints(D2, L),
    makeConstraints(D3, L),
    makeConstraints(D4, L),

    % Sort each die to exploit symmetry
    allSorted([D1, D2, D3, D4]),
    % WLOG, we can assume that the first elements are increasing
    % and that D1 starts with 1 and D2 starts with 2
    % We can know that 1 and 2 are in different dice due to "bake"
    % Normally, we'd have to do this:
    % D1 = [1|_],
    % D2 = [D21|_],
    % D3 = [D31|_],
    % D4 = [D41|_],
    % D21 #< D31, D31 #< D41
    D1 = [1|_],
    D2 = [2|_],
    D3 = [D31|_],
    D4 = [D41|_], D31 #< D41,

    % Assign values to variables. Use the first fail strategy.
    labeling([ff], Vars),

    % Write solution
    writeN(D1), 
    writeN(D2), 
    writeN(D3), 
    writeN(D4), halt.
    
writeN(D):- findall(X,(member(N,D),num(X,N)),L), write(L), nl, !.

allSorted([]):- !.
allSorted([X|L]):- sorted(X), allSorted(L).

sorted([A, B, C, D, E, F]):-
    A #< B, B #< C, C #< D, D #< E, E #< F, !.

notSameDice(N, M):-
    word(W), 
    member(A, W),
    member(B, W),
    num(A, N),
    num(B, M),
    N < M. 

makeConstraints(_, []).
makeConstraints([A, B, C, D, E, F], [N-M|L]):-
    makeConstraints([A, B, C, D, E, F], L),
    A #\= N #\/ B #\= M,  A #\= N #\/ C #\= M,  A #\= N #\/ D #\= M,  A #\= N #\/ E #\= M,  A #\= N #\/ F #\= M,
                          B #\= N #\/ C #\= M,  B #\= N #\/ D #\= M,  B #\= N #\/ E #\= M,  B #\= N #\/ F #\= M,
                                                C #\= N #\/ D #\= M,  C #\= N #\/ E #\= M,  C #\= N #\/ F #\= M,
                                                                      D #\= N #\/ E #\= M,  D #\= N #\/ F #\= M,
                                                                                            E #\= N #\/ F #\= M,!.