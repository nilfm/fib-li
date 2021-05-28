% A matrix which contains zeroes and ones gets "x-rayed" vertically and
% horizontally, giving the total number of ones in each row and column.
% The problem is to reconstruct the contents of the matrix from this
% information. Sample run:
%
%	?- p.
%	    0 0 7 1 6 3 4 5 2 7 0 0
%	 0                         
%	 0                         
%	 8      * * * * * * * *    
%	 2      *             *    
%	 6      *   * * * *   *    
%	 4      *   *     *   *    
%	 5      *   *   * *   *    
%	 3      *   *         *    
%	 7      *   * * * * * *    
%	 0                         
%	 0                         
%	

:- use_module(library(clpfd)).

ejemplo1( [0,0,8,2,6,4,5,3,7,0,0], [0,0,7,1,6,3,4,5,2,7,0,0] ).
ejemplo2( [10,4,8,5,6], [5,3,4,0,5,0,5,2,2,0,1,5,1] ).
ejemplo3( [11,5,4], [3,2,3,1,1,1,1,2,3,2,1] ).


main:-	
    % Capture input into variables
    ejemplo1(RowSums,ColSums),
    % Get the number of rows and columns
	length(RowSums,NumRows),
	length(ColSums,NumCols),
    % Get the number of total cells: each one will be a boolean variable
	NVars is NumRows*NumCols,
    % Generate a list of variables with size NVars
	listVars(NVars,L),
	% Create a matrix of variables with NumRows and NumCols
    matrixByRows(L,NumCols,MatrixByRows),
    % Transpose the matrix to facilitate checking for column sums
	transpose(MatrixByRows, TransposedMatrix),
	declareConstraints(MatrixByRows, TransposedMatrix, RowSums, ColSums, L),
	pretty_print(RowSums,ColSums,MatrixByRows).

% Convencient predicates
listVars(NVars, L):- length(L, NVars).
checkLength(Length, List):- length(List, Length).

% Creates a matrix with NumCols columns and the elements of L
% Stores it in MatrixByRows
matrixByRows(L, NumCols, MatrixByRows):-
    % Get the number of cells
    length(L, LSize),
    % Get the number of rows
    NumRows is LSize div NumCols,
    % The length of the matrix must be NumRows
    length(MatrixByRows, NumRows),
    % The lenght of each row in the matrix must be NumCols
    maplist(checkLength(NumCols), MatrixByRows),
    % The concatenation of the rows of the matrix must be L
    append(MatrixByRows, L).

declareConstraints(MRows, MCols, RSums, CSums, L):-
    % L contains boolean variables
    L ins 0..1,
    % Their row sums must be Rsums
    checkSum(MRows, RSums),
    % Their column sums must be Csums
    checkSum(MCols, CSums),
    % Assign values to the variables
    label(L).

% Recursive function to check if the rows add to their corresponding sums
checkSum([], []):- !.
checkSum([R|Matrix], [S|Sum]):- 
    sum(R, #=, S), 
    checkSum(Matrix, Sum).

pretty_print(_,ColSums,_):- write('     '), member(S,ColSums), writef('%2r ',[S]), fail.
pretty_print(RowSums,_,M):- nl,nth1(N,M,Row), nth1(N,RowSums,S), nl, writef('%3r   ',[S]), member(B,Row), wbit(B), fail.
pretty_print(_,_,_).
wbit(1):- write('*  '),!.
wbit(0):- write('   '),!.
