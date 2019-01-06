package assignment1;
import java.util.ArrayList;
import javafx.util.Pair;

public class ShelfManager {
	
	ArrayList<ArrayList<Pair<Sock,Sock>>> shelf = new ArrayList<ArrayList<Pair<Sock,Sock>>>(4);
	
	void getPair(Pair<Sock,Sock> sockPair)
	{
		int y=sockPair.getKey().c1.ordinal();
		shelf.get(y).add(sockPair);
	}
}
