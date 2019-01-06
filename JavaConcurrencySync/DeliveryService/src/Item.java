import java.util.*;

public class Item {
	
	String label;
	int price;
	int quantity;
	int thresholdQuantity;
	int time;
	
	ArrayList <Integer> orderList = new ArrayList<Integer>();
	
	Item(String s,int p,int q,int threshold,int t) {
		this.label = s;
		this.price = p;
		this.quantity = q;
		this.time = t;
		this.thresholdQuantity= threshold;
	}

	public void add(Integer order) {
		this.orderList.add(order);		
	}
	
	public boolean check() {
		if(label.equals("Tea") || label.equals("Coffee") )
			return true;
		int q=orderList.get(0);
		if(q <= quantity)
			return true;
		return false;
	}
	
	public void remove(boolean all) {
		if(label.equals("Tea") || label.equals("Coffee") )
			return;
		
		int q=orderList.get(0);
		if(q <= quantity && all)
		{
			quantity = quantity - q;
		}
		orderList.remove(0);
	}
	
	
}
