<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.connections.*,java.sql.*,java.io.IOException,java.util.Calendar,java.util.GregorianCalendar" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<META Http-Equiv="Cache-Control" Content="no-cache">
<META Http-Equiv="Pragma" Content="no-cache">
<META Http-Equiv="Expires" Content="0">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="style.css">
<style>
* {
  box-sizing: border-box;
}

body{
  font-family: Arial, Helvetica, sans-serif;
}

.column {
  float: left;
  width: 100%;
  padding: 0 10px;
}

.row {float: left;margin: 10 -5px;cursor:pointer;width:50%}

.row:after {
  content: "";
  display: table;
  clear: both;
}


@media screen and (max-width: 600px) {
  .column {
    width: 100%;
    display: block;
    margin-bottom: 20px;
  }
}

.card { 
	
  padding: 16px;
  text-align: center;
  background-color: #f1f1f1;
}
.card:hover
{
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
	background-color: #C0C0C0;
}
#header {
	border:none;
 	width: 100%;
	margin-bottom: 20px;
	border-bottom: 1px solid #1f1209;
	box-shadow: 0 20px 20px -20px #333;
  	margin: 0px 2px 20px 2px; 

	
}
</style>
</head>
<body>
<%! int clgScore,marks;
	String ques,clgid,clg,pool;
	Statement st;
	ResultSet rs;
%>

<% 
	clgScore=0;marks=0;
	clg= (String) session.getAttribute("college");
	clgid=(String) session.getAttribute("id");
	pool=(String) session.getAttribute("pool");
%>
<br>
<div id="list" style="position:fixed;top:159px;right:30px;border-radius:3px;min-height:100px;text-align:center;width:400px;margin-right:30px;float:right">
	<div style="font-size:20px;font-weight:bold;text-align:center;">
		<h3 >Active Colleges in Pool <span style="color:white;text-shadow: 2px 2px 4px #000000;"><%=pool %></span> </h3><hr>
	</div>
	<div style="font-size:20px;font-weight:bold;background:transparent;">
	<%
	try{
		st=Connections.makeConnection();
		rs=st.executeQuery("select college from activeSessions where active=1 and pool='"+pool+"'");
		while(rs.next())
		{
			%>	
			<pre><i class="fa fa-circle" style="font-size:8px;color:green"></i> <%=rs.getString(1) %></pre>
			<%
		}
	%>
	</div>
</div>
<%
				try{
					rs = st.executeQuery("select questag,marks from questions,participants,activeSessions where activeSessions.pool='"+pool+"' and participants.id=activeSessions.id and questions.quesno=participants.ques and activeSessions.id <> '"+clgid+"'");
					while(rs.next())
					{
						ques = rs.getString(1);
						marks= rs.getInt(2);
%>
	
<div class="row" onclick="callCode('<%= ques %>')">
  <div class="column">
    <div class="card">
		<h3><%= ques %></h3>
		<p>Marks: <%= marks %></p>
    </div>
  </div>
</div>

<%
			 		 }
				}catch(java.sql.SQLException e)
				{
					System.out.println("code list1 : "+e);			
				}
			Connections.closeConnection();
		}
	catch(Exception e)
	{
		Connections.closeConnection();
		response.sendRedirect("index.jsp");
		System.out.println("code list "+e);
	}
%>
<script type="text/javascript">
	 function callCode(ques)
		{
			window.location="code.jsp?questag="+ques;
		}
	  
	  
    
 </script> 
		

</body>
</html>
