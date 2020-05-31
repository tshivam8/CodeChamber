<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.connections.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
            <%
				try{
					
                String pool =(String)request.getParameter("pool");
                Statement st = Connections.makeConnection();
                ResultSet rs = st.executeQuery("select qno from ques where qno not in (select ques from participants where pool = '"+pool+"') order by qno");
                while (rs.next()) {
            %>
            <option value="<%=rs.getInt(1)%>"><%=rs.getInt(1)%></option>
            <%
                }
                Connections.closeConnection();
				}catch(Exception e)
		            {
							Connections.closeConnection();					
							System.out.println(e+" pool.jsp");
		            }
            %>

    </body>
</html>