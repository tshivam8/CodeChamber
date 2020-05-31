package com.classes;
import java.util.Timer;
import java.util.TimerTask;
public class Reminder {
    Timer timer;
    String path;
    String l;
    String q;
    public Reminder(Thread t,String s,String lang,String questag) {
        path=s;
        l=lang;
         q=questag;
        timer = new Timer();
        timer.schedule(new RemindTask(t), 3000);
	}

    class RemindTask extends TimerTask {
    	Thread thr;
    	public RemindTask(Thread t)
    	{
    		thr=t;
    	}
        public void run() {
        	try {
        	ProRun pr=(ProRun)thr;
        	if(pr.bo==false)
        	{
        		System.out.println("line 1");
        		thr.interrupt();
        		System.out.println("line 2");
        		String cmd="cmd /c TASKKILL /F /IM "+l+q+".exe";
        		System.out.println("command: "+cmd);
        		Runtime rt=Runtime.getRuntime();
        		Process pro=rt.exec("TASKKILL /F /IM cmd.exe");
        		pro.waitFor();
        		if(pro.exitValue()==0)
        			System.out.println("cMD Killed");
        		else
        			System.out.println("CMD not Killed");
        		pro=rt.exec(cmd);
        		pro.waitFor();
        		if(pro.exitValue()==0)
        			System.out.println("Process Killed");
        		else
        			System.out.println("Process not Killed");
        		
        		
        		System.out.println("line 3");
        	}
        	else
        	{
        		System.out.println("NO TLE");
        	}
            timer.cancel();
        }
        catch(Exception e)
        {
        	System.out.println("Reminder.java "+e);
        }
    }
    }
}