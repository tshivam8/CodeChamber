package com.classes;

import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.connections.Connections;

@WebServlet("/register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
		
        String id=req.getParameter("id");
        String pass=req.getParameter("pass");
        String cnfpass=req.getParameter("cnfpass");
        String clg=req.getParameter("clg").replaceAll(" ", "_");
        System.out.println(clg);
        String pool=req.getParameter("pool");
        int quesno=Integer.parseInt(req.getParameter("quesno"));
        if(id=="" || pass=="" || cnfpass=="" || clg=="" )
        {
        	resp.sendRedirect("index.jsp");
        }
        else
        {
        	 if(pass.equals(cnfpass)) 
        	 {
                 try 
                 {
                     Statement st = Connections.makeConnection();
                     try 
                     {
                    	 st.executeUpdate("insert into participants values('"+clg+"','"+id+"','"+pass+"','"+pool+"',"+quesno+",0)");
                     }
                     catch(java.sql.SQLIntegrityConstraintViolationException e)
                     {
                    	 throw e;
                     }
                     st.executeUpdate("create table "+clg+ "(questag varchar2(50),marks int)");
                     st.execute("alter table "+clg+" add constraint "+clg+"pk PRIMARY KEY (questag)");
                     
                   	 File dir = new File("C:\\Users\\Shibbu\\eclipse-workspace\\CodeChamber\\codes\\"+clg);
                   	 dir.mkdirs();
                   	 ResultSet rs=st.executeQuery("select questag from questions");
                   	 while(rs.next())
                   		 new File("C:\\Users\\Shibbu\\eclipse-workspace\\CodeChamber\\codes\\"+clg+"\\"+rs.getString(1)).mkdirs();
                   	 resp.getWriter().print("true");
                    //resp.sendRedirect("index.jsp");
                 }
                 catch(java.sql.SQLIntegrityConstraintViolationException e)
                 {
                	 resp.getWriter().print("rep");
                 }
                 catch (Exception e) 
                 {
    	           	  System.out.println("register");
    	           	  resp.getWriter().print("false");
    	              System.out.println(e);
                 }
                 finally
                 {
                	 Connections.closeConnection(); 
                 }
            	 
             }
             else
             {
            	 //resp.sendRedirect("index.jsp");
             }
        }
        
        
    }  
	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
		doGet(req,resp);
    }

}
