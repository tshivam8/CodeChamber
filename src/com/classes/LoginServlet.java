package com.classes;
import com.connections.*; 
import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        String id=req.getParameter("id");
        String pass=req.getParameter("pass");
        if(id.equals("") || pass.equals(""))
        {
        	resp.sendRedirect("index.jsp");
        }
        else
        {
        	  String clg,pool;
              try 
              {
                  Statement st = Connections.makeConnection();
                  ResultSet rs = st.executeQuery("select * from participants where id = '"+id+"' and pass= '"+pass+"'");
                  if(rs.next())
                  {
                	  clg = rs.getString(1);
                	  pool = rs.getString(4);
                	  HttpSession session=req.getSession();
                	  session.setAttribute("college", clg);
                	  session.setAttribute("id", id);
                	  session.setAttribute("pool", pool);
                	  st.executeUpdate("insert into activeSessions values('"+clg+"','"+id+"','"+pool+"',1)");
                	  System.out.println(clg+" logged in");
                	  Connections.closeConnection();
                  	  resp.sendRedirect("ajaxCode.jsp");
                  }
                  else
                  {
                	  Connections.closeConnection();
                	  resp.sendRedirect("error.jsp");
                  }
                  
              } 
              catch(SQLIntegrityConstraintViolationException e)
              {
            	  System.out.println(e);
            	  Connections.closeConnection();
            	  resp.sendRedirect("ajaxCode.jsp");
              }
              catch (Exception e) 
              {
            	  Connections.closeConnection();
            	  System.out.println("login");
                  System.out.println(e);
              }
        }
        
    }   


}
