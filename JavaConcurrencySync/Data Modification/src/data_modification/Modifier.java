package data_modification;

import java.io.IOException;

public class Modifier extends Thread{
	String label;
	String roll;
	int update;
	int marks;
	int sync;
	
	Modifier(String label,String roll,int update,int marks,int sync){
		this.label = label;
		this.roll = roll;
		this.update = update;
		this.marks = marks;
		this.sync = sync;
	}
	
	public void run()
	{
		Record r= DataModification.recordList.get(Integer.parseInt(roll)%100);
		if(!r.teacher.equals("CC") || label.equals("CC"))
		{
			System.out.println("Updating record for roll number : " + Integer.parseInt(roll)%100);
			r.modifyRecord(label, sync, update, marks);
			try {
				DataModification.updateFiles();
				System.out.println("Files updated");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
