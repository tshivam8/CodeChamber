package com.classes;

import java.io.BufferedReader;
import java.io.InputStreamReader;

public class ProRun extends Thread {
	public String command;
	public boolean bo;
	public ProRun(String s)
	{
		command=s;
		bo=false;
	}
	@Override
	public void run(){
		try
		{
			String o="",line="";
		  	Process pro;
			pro = Runtime.getRuntime().exec(command);
	        BufferedReader inO = new BufferedReader(new InputStreamReader(pro.getInputStream()));
	        while ((line = inO.readLine()) != null) 
	        	o=o+line+"\n";
	        BufferedReader inE = new BufferedReader(new InputStreamReader(pro.getErrorStream()));
	        while ((line = inE.readLine()) != null) 
	        	o=o+line+"\n";
	        pro.waitFor();
	        bo=true;
		}
		catch(java.lang.InterruptedException e)
		{
			this.stop();
			System.out.println(e + " ~ProRun1");
		}
		catch(Exception exc)
		{
			System.out.println(exc + " ~ProRun");
		}
		
	}
}
