<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.connections.*,java.sql.*,java.io.IOException,com.classes.Bean" %>

<!DOCTYPE html>
<html style="scroll-behavior:smooth">
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="codemirror-5.48.0/lib/codemirror.css">
<script src="codemirror-5.48.0/lib/codemirror.js"></script>
<script src="codemirror-5.48.0/mode/javascript/javascript.js"></script>
<script src="codemirror-5.48.0/addon/hint/show-hint.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="codemirror-5.48.0/addon/hint/css-hint.js"></script>
<link rel="stylesheet" href="codemirror-5.48.0/addon/hint/show-hint.css">
<script src="codemirror-5.48.0/mode/clike/clike.js"></script>
<script src="codemirror-5.48.0/mode/python/python.js"></script>


<title><%=request.getParameter("questag") %></title>
<style>
	td
	{
		width:30%;
		padding-left:15px;
		border-left: 2px solid gray;
	}

	.sbt
	{
		color:white;
		font-weight:bold;
	}
	.sbt:hover
	{
		cursor:pointer;
	}
	#slct
	{
		background-color:#228B22;
		border:none;
		border-radius:2px;
		height:23px;
		width:100%
	}
#head {
	position:fixed;
	top:0px;
	left:0px;
    border: none;
    background: white;
    width: 100%;
    height: 73px;
    margin: 0 2px 2px 2px;
    padding: 10px 2px 20px 10px;
    border-bottom: 1px solid #1f1209;
    box-shadow: 0 20px 20px -20px #333;
}
</style>
</head>
<body style="font-family: Arial, Helvetica, sans-serif;background-color:#f1f1f1;">
<%! int clgScore; 
	String clgid,clg,pool;
%>

<% 
clg= (String) session.getAttribute("college");
clgid=(String) session.getAttribute("id");
pool=(String) session.getAttribute("pool");
if(clg==null)
{
	response.sendRedirect("index.jsp");
}
%>

<%
	try 
	{
		Statement st = Connections.makeConnection();
		ResultSet rs=null;
		
		clgScore=0;
		if(clg!=null)
		{
			rs=st.executeQuery("select active from activeSessions where college='"+clg+"'");
			rs.next();
			if(rs.getInt(1)==1)
			{
				rs=st.executeQuery("select sum(marks) from "+clg);
				rs.next();
				clgScore=rs.getInt(1);
			}
			else
			{
				Connections.closeConnection();
				//session.invalidate();
				response.sendRedirect("loggedOut.html");
			}
		}
		else
		{
			Connections.closeConnection();
			response.sendRedirect("index.jsp");
		}
	}
	catch(Exception e)
	{
		Connections.closeConnection();
		response.sendRedirect("index.jsp");
		System.out.println(e);
	}
%>

<div id="head" style="z-index:10">
	<div style="font-size:40px;width:100%;height:50">Code Chamber</div>
	<div style="height:30px ;width:100%">
		<div style="font-size:20px;text-align:left;float:left;width:45%">Welcome <%=clg %></div>
		<div id="timer" style="width:10%;color:white;border-radius:2px;text-align:center;float:left;font-size:20px;background:green"></div>
		<div style="font-size:20px;text-align:center;float:right;width:20%;">Points: <%=clgScore %></div>
	</div>
</div>

<%!
	String questag,ques,ipf,opf,cons,test1,ans1,err,yo,eo,regCode;
	Bean b;
	Statement st;
	ResultSet rs;

%>
<div style="padding:0px 30px 10px 30px;margin-top:130px">
<div style="margin:20px;width:60%;color:black;">
<%
	questag=request.getParameter("questag");
	try 
	{
		st = Connections.makeConnection();
		rs = st.executeQuery("select question,inputf,outputf,constr,test1,ans1 from questions where questag='"+questag+"'");
		rs.next();
		ques = rs.getString(1);
		ipf=rs.getString(2);
		opf=rs.getString(3);
		cons=rs.getString(4);
		test1=rs.getString(5);
		ans1=rs.getString(6);
%>
		
			<div style="background-color:white;;padding:10px;height:60px;box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);color:black">
				<!-- welcome <%= session.getAttribute("college") %> -->
				<h2><%=questag %></h2>
			</div>	
			<br>
			<div style="background-color:white;min-height:400px;overflow:hidden;padding:20px 20px 30px 20px;box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2)">
				<div class="question">
					<%=ques %>
				</div>
				<br>
				<h2>Input Format:</h2>
				<div class="inpFor">
					<%=ipf %>
				</div>
				<br>
				<h2>Output Format:</h2>
				<div class="outFor">
					<%=opf %>
				</div>
				<% if(cons!=null) { %>
					<h2>Constraint:</h2>
					<div class="cons">
						<%=cons %>
					</div>
					
				<%}%>
				<br>
				
				<div class="test" style="width:40%;float:left">
				<h2>Sample Input:</h2>
					<pre><%=test1 %></pre>
				</div>
				<div class="ans" style="width:60%;float:right">
				<h2>Sample Output:</h2>
					<pre><%=ans1 %></pre>
				</div>
				
			</div>
				<br>
				<br>
				<h2>Code Editor</h2>
				<div>
				
				
				
				
				<form id="resForm" action="Result.jsp" method="post">
						<div style="background-color:white;padding:10px 10px 10px 15px;height:352px;box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2)">
						
							<div style="padding:10px;margin:2px;height:20px;background-color:#2F4F4F;border:1px solid black">
								<div style="width:30%;float:left;color:white">
									Enter Your Code Here
								</div>
								<div style="width:30%;float:right">
									<select name="opt" id="slct" style="background-color:whitesmoke;float:right">
										<option value="c" <% if(request.getParameter("opt")!=null && request.getParameter("opt").equals("c")){%> selected<%} %>>C</option>
										<option value="cpp" <% if(request.getParameter("opt")!=null && request.getParameter("opt").equals("cpp")){%> selected<%} %>>C++</option>
										<option value="java" <% if(request.getParameter("opt")!=null && request.getParameter("opt").equals("java")){%> selected<%} %>>Java</option>
										<option value="py" <% if(request.getParameter("opt")!=null && request.getParameter("opt").equals("python")){%> selected<%} %>>Python</option>
									</select>
								</div>
							</div>
							<textarea id="cd" name="code" style="margin-left:0px;margin-top:5px;"></textarea>
							<script>
							var myCode=document.getElementById("cd");
							var editor = CodeMirror.fromTextArea(myCode, {
								mode: "text/x-c++src",
								matchBrackets: true,
								autoCloseBrackets:true,
								tabSize: 3,
								lineNumbers: true,
								extraKeys: {"Ctrl-Space": "autocomplete"}
							});
							</script>
						<div style="margin-top:10px"></div>	
						</div>
						<div style="height:50px;margin-top:10px;width:100%">
									<button type="button" class="sbt" value="submit" onclick="compile(this.value)" name="sbt"  style="float:right;margin:2px;background-color:#1E90FF;border:none;border-radius:2px;height:30px;width:10%">SUBMIT</button>
									<button type="button" class="sbt" value="compile" onclick="compile(this.value)" name="sbt" style="float:right;margin:2px;background-color:#228B22;border:none;border-radius:2px;height:30px;width:10%">COMPILE</button>
									<input type="hidden" name="questag" value="<%=questag %>">
									<input type="hidden" name="ans1" value="<%=ans1 %>">
						</div>
							
				</form>
				</div>
				<br>	
<div style="position:fixed;top:159px;right:30px;border-radius:3px;min-height:100px;text-align:center;width:400px;margin-right:30px;float:right">
	<div style="font-size:20px;font-weight:bold;text-align:center;">
		<h3 >Active Colleges in Pool <span style="color:white;text-shadow: 2px 2px 4px #000000;"><%=pool %></span> </h3><hr>
	</div>
	<div style="font-size:20px;font-weight:bold;background:transparent;">
	<%
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
	}
	catch(Exception e)
	{
		System.out.println("code.jsp ");
	System.out.println(e);
	}
	finally{
		Connections.closeConnection();}
%>
<div id="load" style="text-align:center;margin-top:10px;display:none" ><img alt="loader" src="load.gif" height=50 width=50></div>
<div id="result"></div>
		
				</div>
</div>
<script>

	function compile(sbt){ 
		var frm=$('#resForm');
		var cd=editor.getValue();
		var dat='code='+cd+'&'+frm.serialize()+'&sbt='+sbt;
	    	$.ajax({
	    		type: frm.attr('method'),
				url: frm.attr('action'),
				data: dat,
				cache: false,
			    beforeSend: function(){
			        $('#load').show();
			        $('#result').hide();
			        var scrollPos =  $("#load").offset().top;
					 $(window).scrollTop(scrollPos);
			    },
			    complete: function(){
			        $('#load').hide();
			    },
				success: function(res)
				{
					$('#result').html(res);
					$('#result').show();
					 var scrollPos =  $("#result").offset().top;
					 $(window).scrollTop(scrollPos);
				},
				error: function()
				{
					alert('not');
				}
			});
	    } 
    var countDownDate = new Date("Aug 31, 2019 15:37:25").getTime();
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