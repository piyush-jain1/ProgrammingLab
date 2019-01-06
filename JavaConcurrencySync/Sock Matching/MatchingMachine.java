package assignment1;

import java.util.ArrayList;

import javafx.util.Pair;

public class MatchingMachine {
	
	static ArrayList<Sock> sock;
	
	MatchingMachine()
	{
		for(int i=0;i<4;i++)
		{
			Sock s=new Sock(-1,0);
			sock.add(s);
		}
	}
	void takeSocks(Sock a)
	{
		int y=a.c1.ordinal();
		if(sock.get(y).label ==-1)
		{
			sock.set(y, a);
		}
		else
		{
			Pair<Sock,Sock> p = new Pair(a,sock.get(y));
			SockMatching.getShelfManager().getPair(p);
		}
	}
}
