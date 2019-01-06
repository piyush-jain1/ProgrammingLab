% read from file
run():- 
	open("sample_input.txt", read, File),
	get_char(File, Chr),
	eq(Current_Char, Chr),
	eq(Current_Count, 1),
	file_input(Chr, File, Current_Char, Current_Count),
	close(File).

eq(C,C).

% write encoded text in encoded_output.txt file if its count is 1 then only character is printed 
% without any brackets
write_encoded(Current_Char, Print_Count) :-
	Print_Count == 1,
	open('encoded_output.txt', append, File),
	write(File,Current_Char),
	write(File,','),
	close(File).



% write encoded text in encoded_output.txt file logic for the case when count >1
write_encoded(Current_Char, Print_Count) :-
	Print_Count \== 1,
	open('encoded_output.txt', append, File),
	write(File,'['),
	write(File,Print_Count),
	write(File,','),
	write(File,Current_Char),
	write(File,'],'),
	close(File).


% if now end_of_file has reached then write encoded and close the file handler in that predicate 
file_input(end_of_file, _, Current_Char, Current_Count) :- 
	Encoded_count is Current_Count-1,
	write_encoded_end_file(Current_Char, Encoded_count),
	!.

% if current char is not equal to previous character then print the previous character with its count.
file_input(Chr, File, Current_Char, Current_Count):-
	Chr \== Current_Char,
	Encoded_count is Current_Count-1,
	write_encoded(Current_Char, Encoded_count),
	get_char(File, Char1),
	eq(NEWCurrent_Count, 2),
	eq(NEWCurrent_Char, Chr),
	file_input(Char1, File, NEWCurrent_Char, NEWCurrent_Count).

% if cur char is same as previous one then just increment the count and proceed.
file_input(Chr, File, Current_Char, Current_Count):-
	Chr == Current_Char,
	NEWCurrent_Count is Current_Count+1,
	get_char(File, Char1),
	file_input(Char1, File, Current_Char, NEWCurrent_Count).


write_encoded_end_file(Current_Char,Print_Count) :-
	Print_Count \== 1,
	open('encoded_output.txt', append, File),
	write(File,'['),
	write(File,Print_Count),
	write(File,','),
	write(File,Current_Char),
	write(File,']'),
	close(File).

write_encoded_end_file(Current_Char,Print_Count) :-
	Print_Count == 1,
	open('encoded_output.txt', append, File),
	write(File,Current_Char),
	close(File).