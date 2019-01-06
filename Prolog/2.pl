% lover facts as given in ques 
lover('lucky','payal').
lover('payal', 'pawan').
lover('jatin', 'priya').
lover('suchi', 'pawan').
lover('amit', 'payal').


% marriage facts as given in ques 
marriage('priya', 'lucky').
marriage('lucky', 'priya').

marriage('sheetal', 'pawan').
marriage('pawan', 'sheetal').

marriage('suchi', 'amit').
marriage('amit', 'suchi').

marriage('jatin', 'payal').
marriage('payal', 'jatin').


% true when x and Y both love each other.
bothlover(X,Y) :- lover(X,Y), lover(Y,X), not(X=Y).

% A marriage is on the rocks if both its participants are in love with other people 
% and not with each other. 
rocks(X,Y) :- marriage(X,Y), lover(X,_), lover(Y,_), not(bothlover(X,Y)), not(X=Y),@<(X,Y).

% A person has jealousy if his/her lover or spouse is loved by someone else 
jealousy(X) :- lover(X,A) , lover(_,A).
jealousy(X) :- marriage(X,A) , lover(_,A).

