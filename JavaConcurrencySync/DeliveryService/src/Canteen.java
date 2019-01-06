import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.*; 
import java.net.*;
import java.util.ArrayList;
import java.util.Scanner;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextField;

  
public class Canteen  
{ 
	static ArrayList<Item> itemList = new ArrayList<Item>();
	static String[] items= {"Tea", "Coffee", "Biscuits", "Cookies"};
	static int[] itemPrice= {6,7 ,10 ,20 };
	static int[] itemQuantity= {20,20 ,30 ,40 };
	static int[] itemThresholdQuantity= {5,5 ,5 ,5 };
	static int[] itemTime= {1,2,5,10};
	
	static boolean listLock = false;

	static {
		
		for(int i=0;i<4;i++)
		{
			Item e = new Item(items[i],itemPrice[i],itemQuantity[i],itemThresholdQuantity[i],itemTime[i]);
			itemList.add(e);
        }
		
	} 
    final static int ServerPort = 9000;
    public static void main(String args[]) throws UnknownHostException, IOException  
    { 
        Scanner scn = new Scanner(System.in); 
          
        // getting localhost ip 
        InetAddress ip = InetAddress.getByName("localhost"); 
          
        // establish the connection 
        Socket s = new Socket(ip, ServerPort); 
          
        // obtaining input and out streams 
        DataInputStream dis = new DataInputStream(s.getInputStream()); 
        DataOutputStream dos = new DataOutputStream(s.getOutputStream()); 
        
        // readMessage thread 
        Thread takeOrder = new Thread(new Runnable()  
        { 
            @Override
            public void run() { 
  
                while (true) { 
                    try { 
                        // read the message sent to this client 
                        String msg = dis.readUTF(); 
                        System.out.println("Message received : " + msg);
                        HandleOrder handleOrder = new HandleOrder(msg,dos);
                        
                    } catch (IOException e) { 
                        e.printStackTrace(); 
                    } 
                } 
            } 
        }); 
         
//        System.out.println("i :"+ Server.i);
        takeOrder.start(); 
    }
    
	
} 