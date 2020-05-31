package com.classes;
import java.sql.Statement;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import com.connections.Connections;

	@WebListener
	public class MyListener extends HttpServlet implements HttpSessionListener 
	{

		private static final long serialVersionUID = 1L;

		@Override
	    public void sessionDestroyed(HttpSessionEvent event) {
	    	HttpSession sess=event.getSession();
	    	String clg=(String)sess.getAttribute("college");
	    	System.out.println(clg+ " logged out");
	       try
	       {
	    	   Statement st = Connections.makeConnection();
               System.out.println(st.executeUpdate("delete from activeSessions where college='"+clg+"'"));
               //temporary code line 
               st.executeUpdate("delete from "+clg);
               
               Connections.closeConnection();
	       }
	       catch(Exception e)   
	       {
	    	   System.out.println(e);
	    	   Connections.closeConnection();
	       }
	    }

		@Override
		public void sessionCreated(HttpSessionEvent event) 
		{
		}


	}

