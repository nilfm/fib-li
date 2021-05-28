:- use_module(library(clpfd)).

ejemplo(0,   26, [1,2,5,10] ).  % Solution: [1,0,1,2]
ejemplo(1,  361, [1,2,5,13,17,35,157]).

main:- 
    % Capture input into variables
    ejemplo(1,Amount,Coins),
    nl, write('Paying amount '), write(Amount), write(' using the minimal number of coins of values '), write(Coins), nl,nl,
    % Get the length of the coins list
    length(Coins,N), 
    % Create a list of N prolog variables
    length(Vars,N),   
    
% 1: Domain:
    % Worst case: all ones
    Vars ins 0..Amount,

% 2: Constraints:
    % Create the linear combination expression
    expr(Vars, Coins, Expr),
    % Set a constraint that the linear combination must equal Amount
    Expr #= Amount,
    % Create the expression to minimize: the sum of the amounts of coins
    exprSuma(Vars, ExprSum),

% 3: Labeling:
    labeling([min(ExprSum)], Vars),

% 4: Write result:
    NumCoins is ExprSum, write('We need '), write(NumCoins), write(' coins: '), write(Vars), nl, nl, halt.

expr([], [], 0).
expr([X|Vars], [K|Coins], Expr + X*K):- expr(Vars, Coins, Expr).

exprSuma([X], X):- !.
exprSuma([X|Vars], X + Expr):- exprSuma(Vars, Expr).