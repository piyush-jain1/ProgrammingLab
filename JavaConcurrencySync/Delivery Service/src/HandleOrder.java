import java.io.BufferedWriter;
import java.io.DataOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

public class HandleOrder extends Thread{
	
	HandleOrder(String msg,DataOutputStream dos) throws IOException{
		
		String client = msg.split(":")[0];
        System.out.println("Customer : "+ client);
        String[] order = msg.replaceAll("\\s+","").split(":")[1].split(",");
        ArrayList<Integer> order_quantity = new ArrayList(4);
        for(String s : order) {
        	if(s.isEmpty()) {
        		s = "0";
        	}
        	order_quantity.add(Integer.parseInt(s));	
        }
        while(order_quantity.size() < 4) {
        	order_quantity.add(0);
        }
        
     // read the message to deliver. 
        String response = "";
        String[] available = {"available", "available", "available", "available"};
        boolean all = true;
        
        while(Canteen.listLock) {
			continue;
		}
		Canteen.listLock = true;
		
		for(int k=0;k<4;k++)
		{
			Item i = Canteen.itemList.get(k);
			i.add(order_quantity.get(k));
		}
		int price=0;
		int time=0;
//		String sales_list = "date, name of the customer, item, rate, quantity, price";
		String sales_list = "";
		String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(Calendar.getInstance().getTime());
		for(int k=0;k<4;k++) {
        	Item i = Canteen.itemList.get(k);
        	price = price + i.price*i.orderList.get(0);
        	time = time + i.time;
        	
        	if(!i.check()) {
        		available[k] = "not available";
        		all = false;
        	}
        	response += i.label+" : "+" : " + i.price*i.orderList.get(0) + "\n";
        	sales_list += timeStamp+","+client+","+i.label+","+i.price+","+i.orderList.get(0)+","+i.price*i.orderList.get(0)+"\n";
        }
		response += "Total Amount : " + price;
		
		// use price here
		for(Item i:Canteen.itemList){
    		i.remove(all);
    	}
		
		FileWriter writer = new FileWriter("PurchaseList.txt"); 
		for(Item i:Canteen.itemList) {
			if(i.quantity < i.thresholdQuantity)
				writer.write(i.label+"\n");
		}
		writer.close();
		
		
        if(all) {
        	
        	response += "\nOrder will be processed in " + time + " minutes";
        	appendStrToFile("orderList",sales_list); 
        	
        } else {
        	response = "Order can't be processed.";
        	sales_list = "";
        }
        response += "#"+client;
        Canteen.listLock = false;
        
        try { 
            // write on the output stream 
            dos.writeUTF(response); 
            System.out.println("Response to " + client + " : \n"+ response);
        } catch (IOException e) { 
            e.printStackTrace(); 
        } 
	}
	
	static void appendStrToFile(String fileName, String str) 
	{ 
		try { 
			// Open given file in append mode. 
			BufferedWriter out = new BufferedWriter( 
			new FileWriter(fileName, true)); 
			out.write(str); 
			out.close(); 
		} 
		catch (IOException e) { 
			System.out.println("exception occoured" + e); 
		}
	}

}
