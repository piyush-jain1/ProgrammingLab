package assignment1;
import java.util.*;

import javafx.util.Pair;

public class SockMatching {
	
	// In this Class, I have to make everything as static,I want to implement in a diff manner.
	// One object of SockMatching means our one instance of game.. 
	// In its constructor, initiate all these parameters.
	// and to call these functions,pass this Object of SockMatching,as we pass Sock object.
	
	static ArrayList<Sock> sockHeap;
	private static int pickedCount=0;
	private static ShelfManager shelfManager = new ShelfManager();
	private static MatchingMachine matchingMachine = new MatchingMachine();
	
	public static void main() {
		
		Scanner in = new Scanner(System.in);
		
		matchingMachine = new MatchingMachine();
		shelfManager = new ShelfManager();

		System.out.println("Enter the no of socks in heap");
        int sockCount = in.nextInt();
        initialiseSocks(sockCount);
        
        System.out.println("Enter the no of RoboticArms");
        int RobotArmCount = in.nextInt();
        initialiseRoboticArm(RobotArmCount);
        // TODO Auto-generated method stub
	}

	private static void initialiseRoboticArm(int robotArmCount) {
		for(int i=0;i<robotArmCount;i++)
		{
			RoboticArm r= new RoboticArm();
			r.start();
		}
	}
	
	public static Pair<Sock,Boolean> pickHeap()
	{
		Random rand=new Random();
		int index = rand.nextInt(sockHeap.size());
		synchronized(sockHeap.get(index)) {
			Sock s = sockHeap.get(index);
			
			boolean sockLeft=true; 
			if(pickedCount==sockHeap.size())
				sockLeft = false;
			if(s.picked)	return new Pair<Sock, Boolean>(new Sock(-1, 0),sockLeft);			// NULL sock
			s.picked = true;
			pickedCount++;
			return new Pair<Sock, Boolean>(s,sockLeft);
		}
	}
	private static void initialiseSocks(int a) {
		Random rand=new Random();
		for(int i=0;i<a;i++)
		{
			Sock s= new Sock(i,rand.nextInt(4));
			sockHeap.add(s);
		}	
	}

	 	
	public static MatchingMachine getMatchingMachine() {
		return matchingMachine;
	}
	public static ShelfManager getShelfManager() {
		return shelfManager;
	}

}
