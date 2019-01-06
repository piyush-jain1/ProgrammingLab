package assignment1;

import javafx.util.Pair;

public class RoboticArm extends Thread{
	
	// this will pick any sock and deliver it to Matching Machine
	public void run()
	{
		while(true)
		{
			Pair<Sock,Boolean> sockPicked = SockMatching.pickHeap();
			if(!sockPicked.getValue())
				break;
			if(sockPicked.getKey().label==-1)
				continue;
			SockMatching.getMatchingMachine().takeSocks(sockPicked.getKey());
		}
	}
	
}
