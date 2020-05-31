<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.connections.*,java.sql.*,java.io.IOException,java.util.Calendar,java.util.GregorianCalendar" %>
<!DOCTYPE html>
<html>
<head>
 <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.0/jquery.min.js"></script>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<META Http-Equiv="Cache-Control" Content="no-cache">
<META Http-Equiv="Pragma" Content="no-cache">
<META Http-Equiv="Expires" Content="0">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<script type="text/javascript">
     var auto = setInterval(    function ()
     {
          $('#mydiv').load('codeList.jsp').fadeIn("slow");
     }, 1000); // refresh every 5000 milliseconds
</script>
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
<meta charset="ISO-8859-1">

<body>
<%!
	int clgScore,marks;
	String ques,clgid,clg,pool;
	Statement st;
	ResultSet rs;
%>

<% 
	clgScore=0;marks=0;
	clg= (String) session.getAttribute("college");
	clgid=(String) session.getAttribute("id");
	pool=(String) session.getAttribute("pool");
	try 
	{
		st = Connections.makeConnection();
		rs=st.executeQuery("select active from activeSessions where college='"+clg+"'");
		rs.next();
		if(rs.getInt(1)==0)
		{
			Connections.closeConnection();
			//session.invalidate();
			response.sendRedirect("loggedOut.html");
		}
		else
		{
			//rs = st.executeQuery("select count(*) from activeSessions");
			//rs.next();
			//total=rs.getInt(1)+1;
			rs = st.executeQuery("select questag,marks from questions where quesno = 0 ");
			rs.next();
			ques = rs.getString(1);
			marks=rs.getInt(2);
			clgScore=0;
			if(clg!=null)
			{
				rs=st.executeQuery("select sum(marks) from "+clg);
				rs.next();
				clgScore=rs.getInt(1);
			}
			else
			{
				Connections.closeConnection();
				response.sendRedirect("index.jsp");
			}
%>
<div id="header">
	<div style="font-size:40px;width:100%;font-weight:bold">Code Chamber</div>
	<div style="height:40px ;width:100%">
		<div style="font-size:20px;text-align:left;float:left;width:45%">Welcome <%=clg %></div>
		<div id="timer" style="width:10%;color:white;border-radius:2px;text-align:center;float:left;font-size:20px;background:green"></div>
		<div style="font-size:20px;text-align:center;float:right;width:20%;">Points: <%=clgScore %></div>
	</div>
</div>

<br>


<div class="row" onclick="callCode('<%= ques %>')">
  <div class="column">
    <div class="card">
      <h3><%= ques %></h3>
      <p>Marks: <%= marks %></p>
    </div>
  </div>
</div>

	<div id="mydiv"></div>
	<%
		}
	}catch(Exception e)
		{
			System.out.println(e+" ajax");
		}
	%>
	<script>
	var countDownDate = new Date("Jan 5, 2021 15:37:25").getTime();
	  var x = setInterval(function() {	
	  var now = new Date().getTime();
	  var distance = countDownDate - now;
	  var days = Math.floor(distance / (1000 * 60 * 60 * 24));
	  var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
	  if(hours<10)
		  hours = "0" + hours;
	  var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
	  if(minutes<10)
		  minutes = "0" + minutes;
	  var seconds = Math.floor((distance % (1000 * 60)) / 1000);
	  if(seconds<10)
		  seconds = "0" + seconds;
	  document.getElementById("timer").innerHTML ="Timer <br>"+hours + "h "+ minutes + "m " + seconds + "s ";
	  if (distance < 0) {
	    clearInterval(x);
	    document.getElementById("timer").innerHTML = "EXPIRED";
	    window.location.assign("timeover.html");
	  }
	}, 1000);
	  </script>
</body>
</html>
