package com.classes;
import java.io.*;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.connections.Connections;

@WebServlet("/compiler")
public class Compiler extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	static String questag="";
	static String pool="";
	static String lang="";
	public Bean bn;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		try
		{
			File file=null;
			HttpSession sess=req.getSession();
			String clg= (String)sess.getAttribute("college");
			pool = (String)sess.getAttribute("pool");
			String code=req.getParameter("code");
			questag=req.getParameter("questag");
			String btn=req.getParameter("sbt");
			lang=req.getParameter("opt");
			if(clg!=null)
			{
				file = new File("C:\\Users\\Shibbu\\eclipse-workspace\\CodeChamber\\codes\\"+clg+"\\"+questag+"\\"+questag+"."+lang);
			    FileWriter writer1 = new FileWriter(file);
			    writer1.write(code);
			    writer1.close();
			    file = new File("C:\\Users\\Shibbu\\eclipse-workspace\\CodeChamber\\codes\\"+clg+"\\"+questag+"\\"+lang+"out.txt");
			    FileWriter writer2 = new FileWriter(file);
			    writer2.close();
			    //bn=runFile("C:\\Users\\Shibbu\\eclipse-workspace\\CodeChamber\\codes\\"+clg+"\\"+questag,questag,clg,btn,req,resp);
			    req.setAttribute("Result", runFile("C:\\Users\\Shibbu\\eclipse-workspace\\CodeChamber\\codes\\"+clg+"\\"+questag,questag,clg,btn,req,resp));
			    req.getRequestDispatcher("code.jsp").forward(req,resp);
			}
			else
			{
				resp.sendRedirect("index.jsp");
			}
			
		}
		catch(Exception e)
		{
			System.out.println(e);
			System.out.println("compiler");
		}
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		doGet(req,resp);
	}
	private static String runProcess(String command) throws Exception
	{
			String o="",e="",line="";
		  	Process pro = Runtime.getRuntime().exec(command);
	        BufferedReader inO = new BufferedReader(new InputStreamReader(pro.getInputStream()));
	        while ((line = inO.readLine()) != null) 
	        	o=o+line+"\n";
	        BufferedReader inE = new BufferedReader(new InputStreamReader(pro.getErrorStream()));
	        while ((line = inE.readLine()) != null) 
	        	e=e+line+"\n";
	        pro.waitFor();
	        return o+e;
	}
	private static Bean runFile(String path,String file,String clg,String btn,HttpServletRequest req, HttpServletResponse resp) throws Exception
	{
		try
		{
	        if(btn.equals("compile")) 
	        {
	        	Thread t=null;
	        	String er="",line="",command="";
				Bean b=new Bean();
				if(lang.equals("c"))
					command="gcc "+path+"\\"+file+".c -o "+path+"\\c"+file;
				else if(lang.equals("cpp"))
					command="g++ "+path+"\\"+file+".cpp -o "+path+"\\cpp"+file;
				else if(lang.equals("py"))
					command="python "+path+"\\"+file+".py";
				
			  	Process pro = Runtime.getRuntime().exec(command);
		        BufferedReader inE = new BufferedReader(new InputStreamReader(pro.getErrorStream()));
		        while ((line = inE.readLine()) != null) 
		        	er=er+line+"\n";
	        	if(pro.exitValue()==0 && !lang.equals("py"))
			        {    
			        	String out="cmd /c "+path+"\\"+lang+file+" < C:\\Users\\Shibbu\\eclipse-workspace\\CodeChamber\\testcases\\"+file+"\\t1.txt > "+path+"\\"+lang+"out.txt";
			        	t=new ProRun(out);
			        	try {
			        	t.start();
			        	new Reminder(t,path+"\\"+lang+"out.txt",lang,file);
			        	Thread.sleep(3000);
			        	}catch(Exception e)
			        	{}
			        	//runProcess(out);
			        }
	        	if(t==null)
	        	{
	        		er=er.replace(path+"\\"+file,"Your Code");
				    b.setError(er);
	        	}
	        	else if(((ProRun)t).bo==false)
	        	{
	        		System.out.println("cj");
	        		b.setError("infinite loop found");
	        		System.out.println("error aayi "+b.getError());
	        	}
				    System.out.println("er : "+er+"123");
			        if(b.getError()=="")
			        {
			        	System.out.println("yha pr hai");
			        	File yourOut = new File(path+"\\"+lang+"out.txt");
			        	System.out.println("yha pr hai2");
			        	Scanner sc = new Scanner(yourOut);
			        	System.out.println("yha pr hai3");
			            sc.useDelimiter("\\Z");
			            System.out.println("yha pr hai4");
			            b.setMyOut(sc.next());
			            System.out.println("yha pr hai5");
			            System.out.println("MyOut : " + b.getMyOut());
			            System.out.println("yha pr hai6");
			            sc.close();
			            System.out.println("yha pr hai7");
			        }
			        else
			        	System.out.println("yha pr nhi hai "+er);
			        System.out.println("er "+b.getError());
			        System.out.println("eo "+b.getExpOut());
			        System.out.println("mo "+b.getMyOut());
			        return b;
		       }
	        else if(btn.equals("submit"))
		       {
	        	Thread t=null;
		    	   String er="",line="",command="";
					Bean b=new Bean();
					if(lang.equals("c"))
						command="gcc "+path+"\\"+file+".c -o "+path+"\\c"+file;
					else if(lang.equals("cpp"))
						command="g++ "+path+"\\"+file+".cpp -o "+path+"\\cpp"+file;
					else if(lang.equals("py"))
						command="python "+path+"\\"+file+".py";
				  	Process pro = Runtime.getRuntime().exec(command);
			        BufferedReader inE = new BufferedReader(new InputStreamReader(pro.getErrorStream()));
			        while ((line = inE.readLine()) != null) 
			        	er=er+line+"\n";
			        if(pro.exitValue()!=0)
			        {
			        	b.setError(er.replace(path+"\\"+file,"Your Code"));
			        	return b;
			        }else
			        {
			        	if(pro.exitValue()==0 && !lang.equals("py"))
				        {    
				        	String out="cmd /c "+path+"\\"+lang+file+" < C:\\Users\\Shibbu\\eclipse-workspace\\CodeChamber\\testcases\\"+file+"\\t1.txt > "+path+"\\"+lang+"out.txt";
				        	t=new ProRun(out);
				        	try {
				        	t.start();
				        	new Reminder(t,path+"\\"+lang+"out.txt",lang,file);
				        	Thread.sleep(3000);
				        	}catch(Exception e)
				        	{}
				        	//runProcess(out);
				        }
			        }
		    	   try
		    	   {
		    		   	Statement st = Connections.makeConnection();
			        	ResultSet rs=st.executeQuery("select marks from questions where questag='"+file+"'" );
			        	rs.next();
			        	int marks=rs.getInt(1);
			        	b.setMark(marks/3);
			        	for(int i=1;i<4;i++)
			        	{	
			        		String out="cmd /c "+path+"\\"+lang+file+" < C:\\Users\\Shibbu\\eclipse-workspace\\CodeChamber\\testcases\\"+file+"\\t"+i+".txt > "+path+"\\"+lang+"out.txt";
							runProcess(out);
					        File expOut = new File("C:\\Users\\Shibbu\\eclipse-workspace\\CodeChamber\\testcases\\"+file+"\\a"+i+".txt");
					        Scanner sc=new Scanner(expOut);
					        sc.useDelimiter("\\Z"); 
					        b.setExpOut(sc.next());
					        sc.close();
					        File yourOut = new File(path+"\\"+lang+"out.txt");
					       	Scanner sc1 = new Scanner(yourOut); 
					        sc1.useDelimiter("\\Z");
					        b.setMyOut(sc1.next());
					        sc1.close();
					        if(b.getExpOut().equals(b.getMyOut()))
					        {
					        	b.setQ(i, true);
					        	b.setTstpsd(b.getTstpsd()+1);
					        }
			        	}
			        	try 
			        	{
			        		st.executeQuery("insert into "+clg+" values('"+file+"',"+(marks/3)*b.getTstpsd()+")");
			        		if(b.getTstpsd()==3)
			        		{
			        			st.executeUpdate("update questions set marks=marks/2 where questag='"+questag+"'");
			        			st.executeUpdate("update activeSessions set active=0 where id = (select participants.id from questions,participants where participants.ques=questions.quesno and questag='"+questag+"' and pool='"+pool+"')");
			        			
			        		}
			        	}
			        	catch(Exception e)
			        	{
			        		rs=st.executeQuery("select marks from "+clg+" where questag='"+file+"'");
			        		rs.next();
			        		if((marks/3)*b.getTstpsd() > rs.getInt(1))
			        		{
			        			st.executeUpdate("update "+clg+" set marks="+(marks/3)*b.getTstpsd()+"where questag='"+file+"'" );
			        		}
			        		System.out.println("compiler aa "+e);
			        	}
					    Connections.closeConnection();
			        }
			        catch(Exception e)
			        {
			        	System.out.println("marks allot "+e);
			        	Connections.closeConnection();
				    }
		    	   	return b;
		    	 }
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return new Bean();
	}

	
	private static String runJavaFile(String path,String file)
	{
		String s="";
		try
		{
           s=s+runProcess("javac "+path+file+".java");
           s=s+runProcess("java -cp "+path+file);
       } 
		catch (Exception e) 
		{
           e.printStackTrace();
       }
		return s.replace(file,"Your Code");
	}
	
	
}
