% knowledge base
bus(123,'A','B',14,14.5,110,10).
bus(123,'B','C',14.5,15,110,10).
bus(123,'C','D',15,15.5,110,10).
bus(123,'D','G',15.5,16,110,10).

bus(756,'A','B',14.5,14.6,10,110).
bus(756,'A','E',14.5,14.6,10,110).
bus(756,'E','C',14.7,14.8,10,110).
bus(756,'C','F',14.9,15.0,10,110).
bus(756,'F','G',15.1,15.2,10,110).

bus(900,'A','C',14,14.2,100,100).
bus(900,'C','G',14.2,14.5,100,100).

% checks if a variable is instantiated or not
not_inst(Var):-
  \+(\+(Var=0)),
  \+(\+(Var=1)).


% given city X and city Y, find distance, time, cost, bus number to travel between them
dtcb(X,Y,Dep,Arr,D,T,C,B):- bus(B,X,Y,Dep,Arr,D,C), T is Arr-Dep.


% find path between two cities, correspoding distance, time and cost, and the bus numbers
path(X,Y,[X,Y],Prev,D,T,C,[B]):- 
    not_inst(Prev),
    dtcb(X,Y,_,_,D,T,C,B);
    \+(not_inst(Prev)),
    dtcb(X,Y,Dep,_,D,T,C,B),
    Dep >= Prev.

% to find path between two cities which are not directly connected 
% recursively call on all possible intermediate cities till it reaches destination
path(X,Y,[X|W],_,D,T,C,[B1|Bus]):- 
    dtcb(X,Z,_,Arr1,D1,T1,C1,B1),
    path(Z,Y,W,Arr1,D2,T2,C2,Bus), 
    D is D1 + D2,
    T is T1 + T2,
    C is C1 + C2.


% find all possible paths between given pair of cities and get the optimum w.r.t. distance, time and cost
% To find optimum:
%   find all [Parameter,Path,Bus] tuples
%   Sort the list of tuples by Parameter
%   Get the first tuple of sorted list
%   Here Parameter can be Distance, Time and Cost
optDisTimeCostPath(X,X,[X],0,[],0,0,[X],0,[],0,0,[X],0,[],0,0):- !.
optDisTimeCostPath(X,Y,Pd,MinD,Bd,Td,Cd,Pt,MinT,Bt,Dt,Ct,Pc,MinC,Bc,Dc,Tc):-
    findall([D,P,B,T,C],path(X,Y,P,_,D,T,C,B),SetD),
    sort(SetD,SortedD),
    SortedD = [[MinD,Pd,Bd,Td,Cd]|_],
    findall([T,P,B,D,C],path(X,Y,P,_,D,T,C,B),SetT),
    sort(SetT,SortedT),
    SortedT = [[MinT,Pt,Bt,Dt,Ct]|_],
    findall([C,P,B,D,C],path(X,Y,P,_,D,T,C,B),SetC),
    sort(SetC,SortedC),
    SortedC = [[MinC,Pc,Bc,Dc,Tc]|_].


% print all optimum paths with corresponding distacne, time and cost values and also the bus numbers
optPath(X,Y):-
    optDisTimeCostPath(X,Y,OptDisPath,Distance,Bd,Td,Cd,OptTimePath,Time,Bt,Dt,Ct,OptCostPath,Cost,Bc,Dc,Tc),
    write("Optimum Path Based on Distance:"),nl,
    write("OptDisPath: "),write(OptDisPath),nl,
    write("OptDisBus: "),write(Bd),nl,
    write("Distance: "),write(Distance),
    write(", Time: "),write(Td),
    write(", Cost: "),write(Cd),nl,nl,
    write("Optimum Path Based on Time:"),nl,
    write("OptTimePath: "),write(OptTimePath),nl,
    write("OptTimeBus: "),write(Bt),nl,
    write("Distance: "),write(Dt),
    write(", Time: "),write(Time),
    write(", Cost: "),write(Ct),nl,nl,
    write("Optimum Path Based on Cost:"),nl,
    write("OptCostPath: "),write(OptCostPath),nl,
    write("OptCostBus: "),write(Bc),nl,
    write("Distance: "),write(Dc),
    write(", Time: "),write(Tc),
    write(", Cost: "),write(Cost);
    write("No Path Exists!").


% Sample cases:
% optPath('A','F').
% optPath('B','G').
% optPath('A','G').
% optPath('A','B').
% optPath('B','F').
% optPath('G','G').
