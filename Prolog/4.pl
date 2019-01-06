% This is to check equality of variables and assign them if possible.
eq(A,A).

% predicate for fibonacci series.
% if TF cannnot be equated with -1 then it means F is not a variable
% and we want to index for given fibonacci no.
fibonacci(N,F) :-
    TF = F, \+ eq(TF,-1), find_fib(N,0,F);
    TN = N, \+ eq(TN,-1), f(N,F).

% in find_fib predicate, sequentially check for inputs from 0 
% and check if current fibonacci at TNth index is less than F or not. 
find_fib(N,TN,F):-
    f(TN,Z), eq(Z,F), N is TN;
    f(TN,Z), Z < F, N1 is TN+1, find_fib(N,N1,F).

% similar to fibonacci for other series.
lucas(N,F) :-
    TF = F, \+ eq(TF,-1), find_lucas(N,0,F);
    TN = N, \+ eq(TN,-1), l(N,F).

find_lucas(N,TN,F):-
    l(TN,Z), eq(Z,F), N is TN;
    l(TN,Z), Z < F, N1 is TN+1, find_lucas(N,N1,F).

tribonacci(N,F) :-
    TF = F, \+ eq(TF,-1), find_trib(N,0,F);
    TN = N, \+ eq(TN,-1), t(N,F).

find_trib(N,TN,F):-
    t(TN,Z), eq(Z,F), N is TN;
    t(TN,Z), Z < F, N1 is TN+1, find_trib(N,N1,F).


% base casses for different series.
f(0,0).
f(1,1).
f(N, F) :- N>1, N1 is N-1, N2 is N-2, f(N1,F1), f(N2,F2), F is F1+F2.

l(0,2).
l(1,1).
l(N, L) :- N>1, N1 is N-1, N2 is N-2, l(N1, L1), l(N2, L2), L is L1+L2.


t(0,0).
t(1,1).
t(2,1).
t(N, T) :- N>2, N1 is N-1, N2 is N-2, N3 is N-3, t(N1, T1), t(N2, T2), t(N3, T3), T is T1+T2+T3.

% recursively finding fibonacci no. for a sequence.
% similarly for other series.
fib_sequence(B,[]):- B =< 0.
fib_sequence(B,[H|T]) :-
	B > 0,
    B1 is B - 1,              
    f(B1, H),          
    fib_sequence(B1, T). 

lucas_sequence(B,[]):- B =< 0.
lucas_sequence(B,[H|T]) :-
    B > 0,                   
    B1 is B - 1,              
    l(B1, H),         
    lucas_sequence(B1, T).  	  

trib_sequence(B,[]):- B =< 0.
trib_sequence(B,[H|T]) :-
    B > 0,                   
    B1 is B - 1,              
    t(B1, H),          
    trib_sequence(B1, T).  	  

% get input as query and give diff. sequence for different SequenceName
intNumSequence(SequenceName, N):-
    SequenceName = "Fibonacci", fib_sequence(N, Fib), reverse(Fib, Out), write(Out);
    SequenceName = "Lucas", lucas_sequence(N, Lucas), reverse(Lucas, Out), write(Out);
    SequenceName = "Tribonacci", trib_sequence(N, Trib), reverse(Trib, Out), write(Out).

% to get Nth series no.
nTerm(SequenceName, N, X):-
	SequenceName = "Fibonacci", fibonacci(N, X);
	SequenceName = "Lucas", lucas(N, X);
	SequenceName = "Tribonacci", tribonacci(N, X).

% Sameple Cases
% intNumSequence("Fibonacci", 6).
% intNumSequence("Lucas", 5).
% intNumSequence("Tribonacci", 6).

% nTerm("Fibonacci", 4, X).
% nTerm("Lucas", 6, X).
% nTerm("Tribonacci", 10, X).
% nTerm("Fibonacci", X, 8).
% nTerm("Lucas", X, 18).
% nTerm("Tribonacci", X, 81).