package data_modification;

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class Record {
	String roll;
	String name;
	String mail;
	int marks;
	String teacher = "NYM";		// initialized as NYM
	
	Lock recordLock = new ReentrantLock();
	
	Record(String roll, String name, String mail, int marks){
		this.roll = roll;
		this.name = name;
		this.mail = mail;
		this.marks = marks;
	}
	
	public String toString() {
		return roll+" "+name+" "+mail+" "+marks+" "+teacher+"\n";
	}
	public void modifyRecord(String label, int sync, int update, int marks) {
		if(sync == 2) {
			recordLock.lock();
		}
		if(update == 2) {
			marks = -1*marks;
		}
		this.marks += marks;
		this.teacher = label;
		System.out.println("Updating record with " + marks + " label : "+ label);
		DataModification.recordList.set(Integer.parseInt(this.roll)%100, this);
		if(sync == 2) {
			recordLock.unlock();
		}

	}
	
	
	
}
