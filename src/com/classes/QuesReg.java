package com.classes;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.connections.Connections;

@WebServlet("/quesreg")
public class QuesReg extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        int quesno=Integer.parseInt(req.getParameter("quesno"));
        String question=req.getParameter("question").replace("'","");
        String questag=req.getParameter("questag").replace(" ", "_");
        String inf=req.getParameter("inf");
        String opf=req.getParameter("opf");
        String cons=req.getParameter("cons");
        int marks=Integer.parseInt(req.getParameter("marks"));
        
        String t1=req.getParameter("t1");
        String t2=req.getParameter("t2");
        String t3=req.getParameter("t3");
        String a1=req.getParameter("a1");
        String a2=req.getParameter("a2");
        String a3=req.getParameter("a3");
        
              try 
              {
                  Statement st = Connections.makeConnection();
                  st.executeUpdate("insert into questions values('"+quesno+"','"+questag+"','"+question+"','"+inf+"','"+opf+"','"+cons+"',"+marks+",'"+t1+"','"+a1+"','"+t2+"','"+a2+"','"+t3+"','"+a3+"')");
                  File dir = new File("C:\\Users\\Shibbu\\eclipse-workspace\\CodeChamber\\testcases\\"+questag);
                  dir.mkdirs();
                  Files.write(Paths.get("C:\\Users\\Shibbu\\eclipse-workspace\\CodeChamber\\testcases\\"+questag+"\\t1.txt"), t1.getBytes());
                  Files.write(Paths.get("C:\\Users\\Shibbu\\eclipse-workspace\\CodeChamber\\testcases\\"+questag+"\\a1.txt"), a1.getBytes());
                  Files.write(Paths.get("C:\\Users\\Shibbu\\eclipse-workspace\\CodeChamber\\testcases\\"+questag+"\\t2.txt"), t2.getBytes());
                  Files.write(Paths.get("C:\\Users\\Shibbu\\eclipse-workspace\\CodeChamber\\testcases\\"+questag+"\\a2.txt"), a2.getBytes());
                  Files.write(Paths.get("C:\\Users\\Shibbu\\eclipse-workspace\\CodeChamber\\testcases\\"+questag+"\\t3.txt"), t3.getBytes());
                  Files.write(Paths.get("C:\\Users\\Shibbu\\eclipse-workspace\\CodeChamber\\testcases\\"+questag+"\\a3.txt"), a3.getBytes());
                  System.out.println("Done");
                  Connections.closeConnection();
              } 

              catch (Exception e) 
              {
            	  Connections.closeConnection();
            	  System.out.println("quesregs");
                  System.out.println(e);
              }
        
        
    }   



}
