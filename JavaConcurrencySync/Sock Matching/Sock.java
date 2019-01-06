package assignment1;

enum Color
{
    WHITE, BLACK, BLUE,GREY;
}

public class Sock {
	int label;
	Color c1;
	boolean picked = false;
	
	Sock(int label,int c)
	{
		this.label=label;
		this.c1 = Color.values()[c];
	}
		
}
