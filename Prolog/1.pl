% Ques 1 part A
% atom_chars predicates converts a given string to List of characters.
% string1 will be a substring of string2 if L2 is form of _ + L1 _ ,where _ denotes unnammed variable strings.
% To check: if String is a prefix of some suffix of String2
isSub(String1,String2) :-
	atom_chars(String1,L1),
	atom_chars(String2,L2),	 
	append(_,X,L2), append(L1,_,X), X\=[].



% Ques 2 part B
% get decreasing subsequence
get_subsequence([], Cur_Seq, Cur_Seq).


% Two possibilities:
% add HEAD (H) to subsequence and check next whether next (H1) is lesser than HEAD (H).
% do not add HEAD, move to next.
get_subsequence([H | T], Cur_Seq, Final_Seq) :-
	(Cur_Seq = [], get_subsequence(T, [H], Final_Seq));
	(Cur_Seq = [H1 | _], H1 < H,   get_subsequence(T, [H | Cur_Seq], Final_Seq));
	get_subsequence(T, Cur_Seq, Final_Seq).


% Find all subsequences, check their lengths and get the max length subsequence
% Reverse it to make it longest increasing subsequence
sub_seq(Seq) :-
	aggregate(max(N,Decr_Seq), (get_subsequence(Seq, [], Decr_Seq), length(Decr_Seq, N)), max(_, Result)),
	reverse(Result, Lis),
	write(Lis).

% Sample cases
% isSub("hati", "IIT Guwahati").
% isSub("abc", "bcde").

% sub_seq([4,1,3,8,9,5,6,7]).
% sub_seq([2,2,2,2,2,2]).