// Java implementation for multithreaded chat client 
// Save file as Client.java 
  
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.*; 
import java.net.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextField; 
  
public class Customer  
{ 
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
  
        // sendMessage thread 
        Thread customer = new Thread(new Runnable()  
        { 
            @Override
            public void run() { 
            		List<JTextField> allTextFields = new ArrayList<JTextField>();
                    JFrame f=new JFrame();
                    f.setSize(600,900);
                    int cury = 50;
                    for (String s: Canteen.items) {           
                        // curItem = allItems.get(i);
                        JLabel label = new JLabel(s);
                        label.setBounds(50,cury, 200,50);
                        f.add(label);
                        JTextField textfield = new JTextField();
                        allTextFields.add(textfield);
                        textfield.setBounds(300,cury, 200,50);
                        f.add(textfield);
                        cury = cury + 100;
                    }
                    
                    JButton btn = new JButton("Submit");    
                    btn.setBounds(225,550,100, 50);   
                    f.add(btn);

                    //close on closing the jframe
                     f.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
//                    f.addWindowListener(new MyWindowAdapter()); 
                    f.setLayout(null);//using no layout managers  
                    f.setVisible(true);//making the frame visible 
                    
//                    ArrayList<Integer> order_quantity = new ArrayList(4);
                    
                    btn.addActionListener(new ActionListener() {
                    	@Override
              			public void actionPerformed(ActionEvent e) {
              				// TODO Auto-generated method stub
                            System.out.println("in result submit");
                            String order_quantity = "";
                            for(int i = 0; i<allTextFields.size(); ++i){
//                          	  	order_quantity.add(Integer.parseInt(allTextFields.get(i).getText()));
                            	order_quantity += (String)allTextFields.get(i).getText();
                            	order_quantity += ",";
                                // allTextFields.set(i, allTextFields.get(i).getText());
                            }
                            System.out.println("Order sent : " + order_quantity); 
                         // message to deliver. 
//                        	String msg = scn.nextLine();
                            String msg = order_quantity+"#client 0";
                              
                            try { 
                                // write on the output stream 
                                dos.writeUTF(msg); 
                            } catch (IOException e1) { 
                                e1.printStackTrace(); 
                            }    
                    	}
              		});
            	}
        }); 
        
        // readResponse thread 
        Thread readResponse = new Thread(new Runnable()  
        { 
            @Override
            public void run() { 
                while (true) {
                	System.out.println("Waiting for response");
                    try { 
                        // read the message sent to this client 
                        String response = dis.readUTF(); 
                        System.out.println("Response received : " + response); 
                        response = response.split(":",2)[1];
                        if (response.length() > 0) {
                        	int result = JOptionPane.showConfirmDialog(null, response+"\n"
                                    ,"Invoice", JOptionPane.PLAIN_MESSAGE,JOptionPane.WARNING_MESSAGE);
                        }   
                    } catch (IOException e) { 
                        e.printStackTrace(); 
                    } 
                }
            } 
        }); 
        
        customer.start();
        readResponse.start();
  
    } 
} 