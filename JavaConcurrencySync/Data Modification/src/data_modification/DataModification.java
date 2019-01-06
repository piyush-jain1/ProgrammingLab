package data_modification;

import java.io.FileWriter;
import java.io.IOException;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Random;
import java.util.Scanner;
//import java.util.concurrent.locks.Lock;
//import java.util.concurrent.locks.ReentrantLock;

public class DataModification {

	static ArrayList<Record> recordList = new ArrayList<Record>();
	static final String AB = "abcdefghijklmnopqrstuvwxyz";
	static SecureRandom rnd = new SecureRandom();
	
	static int sync=2;
	private static boolean fileLock = false;
	
	static String randomString( int len ){
	   StringBuilder sb = new StringBuilder( len );
	   for( int i = 0; i < len; i++ ) 
	      sb.append( AB.charAt( rnd.nextInt(AB.length()) ) );
	   return sb.toString();
	}
	
	public static void main(String[] args) throws IOException, InterruptedException {
		// TODO Auto-generated method stub
		
		initialiseRecords();
		
		while(true) {
			Scanner in = new Scanner(System.in);
			
			System.out.println("Enter Teacher’s Name: ");
			String teacher1 = in.next();
			
			System.out.println("Enter Student Roll number: ");
			String student1 = in.next();
			
			System.out.println("Update Mark : " + "\n" + "1. Increase" + "\n" + "2. Decrease");
			int update1 = in.nextInt();
			
			System.out.println("Mark to add: ");
			int marks1 = in.nextInt();
			
			System.out.println("Enter Teacher’s Name: ");
			String teacher2 = in.next();
			
			System.out.println("Enter Student Roll number: ");
			String student2 = in.next();
			
			System.out.println("Update Mark : \n" +  "1. Increase\n" + "2. Decrease");
			int update2 = in.nextInt();
			
			System.out.println("Mark to add: ");
			int marks2 = in.nextInt();
			
			System.out.println("Choose one:\n" + 
					"1. Without Synchronization\n" + 
					"2. With Synchronization");
			sync = in.nextInt();
			
			Thread t1 = new Thread(new Modifier(teacher1,student1,update1,marks1,sync));
			t1.start();
			Thread t2 = new Thread(new Modifier(teacher2,student2,update2,marks2,sync));
			t2.start();
			
			t1.join();
			t2.join();
			
			String cont;
			do {
				System.out.println("Do you want to continue? yes/no");
				cont = in.next();
			}while(!cont.toLowerCase().equals("yes") && !cont.toLowerCase().equals("no"));
			
			if(cont.toLowerCase().equals("no"))
				break;
		}
	}


	private static void initialiseRecords() throws IOException {
		// TODO Auto-generated method stub
		Random rand=new Random();
		String roll = "150101000";
		for(int i=0;i<10;i++)
		{
			Record r = new Record(String.valueOf(Integer.parseInt(roll)+i),randomString(10),randomString(5)+"@iitg.ac.in",40+rand.nextInt(40));
			recordList.add(r);
		}
		Collections.sort(recordList, new Comparator<Record>() {
			  public int compare(Record c1, Record c2) {
			    if (c1.roll.compareToIgnoreCase(c2.roll) <0) return -1;
			    if (c1.roll.compareToIgnoreCase(c2.roll) >0) return 1;
			    return 0;
			  }});
		updateFiles();
	}
	static void updateFiles() throws IOException
	{
		if(sync==2)
		{
			while(fileLock) {
				continue;
			}
			fileLock = true;
		}
		ArrayList<Record> recordListCopy = new ArrayList<Record>();
		for (Record record: recordList) {
			recordListCopy.add(record);
		}
		writeSorted_Name(recordListCopy);
		writeSorted_Roll(recordListCopy);
		writeStud_Info(recordListCopy);
		if(sync==2)
		{
			fileLock = false;
		}
		
	}
	static void writeSorted_Name(ArrayList<Record> recordListCopy) throws IOException
	{
		Collections.sort(recordListCopy, new Comparator<Record>() {
			  public int compare(Record c1, Record c2) {
			    if (c1.name.compareToIgnoreCase(c2.name) <0) return -1;
			    if (c1.name.compareToIgnoreCase(c2.name) >0) return 1;
			    return 0;
			  }});
		FileWriter writer = new FileWriter("Sorted_Name.txt"); 
		for(Record r: recordListCopy) {
		  writer.write(r.toString());
		}
		writer.close();
		System.out.println("Sorted_Name updated");
	}
	
	static void writeSorted_Roll(ArrayList<Record> recordListCopy) throws IOException
	{
		Collections.sort(recordListCopy, new Comparator<Record>() {
			  public int compare(Record c1, Record c2) {
			    if (c1.roll.compareToIgnoreCase(c2.roll) <0) return -1;
			    if (c1.roll.compareToIgnoreCase(c2.roll) >0) return 1;
			    return 0;
			  }});
		FileWriter writer = new FileWriter("Sorted_Roll.txt"); 
		for(Record r: recordListCopy) {
		  writer.write(r.toString());
		}
		writer.close();
		System.out.println("Sorted_Roll updated");
	}
	
	static void writeStud_Info(ArrayList<Record> recordListCopy) throws IOException
	{
		Collections.sort(recordListCopy, new Comparator<Record>() {
			  public int compare(Record c1, Record c2) {
			    if (c1.mail.compareToIgnoreCase(c2.mail) <0) return -1;
			    if (c1.mail.compareToIgnoreCase(c2.mail) >0) return 1;
			    return 0;
			  }});
		FileWriter writer = new FileWriter("Stud_Info.txt"); 
		for(Record r: recordListCopy) {
		  writer.write(r.toString());
		}
		writer.close();
		System.out.println("Stud_Info updated");
	}
	
}
