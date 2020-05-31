<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.connections.*,java.sql.*,java.io.IOException,java.util.Calendar,java.util.GregorianCalendar" %>
<!DOCTYPE html>
<html>
<head>
<style>
table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}
td, th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {
  background-color: #dddddd;
}
</style>
</head>
<body>
<%! 
	Statement st;
	ResultSet rs;
%>
<div style="text-align:center;font-size:30px;font-weight:900">Leaderboard</div>
<br>
<br>

<table style="width:60%;position:absolute;left:20%">
<tr>
	<th>pool</th><th>college</th><th>score</th>
</tr>
  <%
	try{
		st=Connections.makeConnection();
		rs=st.executeQuery("select college,score,pool from participants order by score desc");
		while(rs.next())
		{
			%>	
				<tr>
					<td><%= rs.getString(3)%></td>
					<td><%= rs.getString(1)%></td>
					<td><%= rs.getString(2)%></td>
					
				</tr>
			<%
		}
	}catch(Exception e)
  {
		
  }
	%>
</table>

</body>
</html>
