<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.connections.*,java.sql.*,java.io.IOException" %>

<!DOCTYPE html>
<html style="scroll-behavior:smooth">
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Insert title here</title>
</head>
<body style="background-color:#f1f1f1;padding:0px 30px 10px 30px">
<%!
	String questag,ques,ipf,opf;
	Statement st;
	ResultSet rs;

%>
<%
	questag=request.getParameter("questag");
	try 
	{
		st = Connections.makeConnection();
		rs = st.executeQuery("select question,inputf,outputf from questions where questag='"+questag+"'");
		rs.next();
		ques = rs.getString(1);
		ipf=rs.getString(2);
		opf=rs.getString(3);
%>
		<div style="margin:20px;width:60%;color:black;">
			<div style="background-color:white;;padding:10px;height:60px;box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);color:black;border-radius:5px">
				<!-- welcome <%= session.getAttribute("college") %> -->
				<h2><%=questag %></h2>
			</div>	
			<br>
			<div style="background-color:white;padding:20px 20px 30px 20px;box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);border-radius:5px">
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
			</div>
				<br>
				<br>
				<h2>Code Editor</h2>
				<div>
				<div style="background-color:white;padding:10px;height:410px;box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);border-radius:5px">
				<form action="compiler" id="frm">
					<div style="padding:10px;margin:2px;height:20px;background-color:#2F4F4F;border:1px solid black">
						<div style="width:30%;float:left;color:white">
							Enter Your Code Here
						</div>
						<div style="width:30%;float:right">
							<select name="opt" style="background-color:whitesmoke;float:right">
								<option value="c" <% if(request.getParameter("opt")!=null && request.getParameter("opt").equals("c")){%> selected<%} %>>C</option>
								<option value="cpp" <% if(request.getParameter("opt")!=null && request.getParameter("opt").equals("cpp")){%> selected<%} %>>C++</option>
								<option value="java" <% if(request.getParameter("opt")!=null && request.getParameter("opt").equals("java")){%> selected<%} %>>Java</option>
								<option value="python" <% if(request.getParameter("opt")!=null && request.getParameter("opt").equals("python")){%> selected<%} %>>Python</option>
							</select>
						</div>
					</div>
						<div contenteditable="true" id="logic" 
							onkeydown="if(event.keyCode===9)
							{
								var v=this.value,s=this.selectionStart,e=this.selectionEnd;
								this.value=v.substring(0, s)+'\t'+v.substring(s,this.value.length);
								this.selectionStart=this.selectionEnd=s+1;
								return false;
							}" 

							style="  
								font-family: Comic Sans MS, cursive, sans-serif;
								outline: none;
								margin-top:10px;
								padding: 10px;
								overflow: scroll;
								height: 300px;
								width: 97%;
								resize: none">
								<%
									if(request.getParameter("code")!=null)
									{
								%>
								<%=
									request.getParameter("code")
								%>
								<%
									}
								%>
						</div>
						<div style="margin-top:10px">
						<input type="submit" value="submit" name="sbt" style="float:right;margin:2px">
						<input type="submit" value="compile" name="sbt" onclick="myFunction()" style="float:right;margin:2px">
						<input type="hidden" name="questag" value="<%=questag %>">
						<input type="hidden" id="hidCode" name="code">
						</div>
					
					</form>
						</div>
				</div>
				<br>	
			
		<%
			if(request.getAttribute("Result")!=null)
			{
		%>			
				<div id="result" style="background-color:white;overflow: hidden;;padding:10px;min-height:100px;box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);color:black;border-radius:5px">
				<h3>Output:</h3>
				<%= request.getAttribute("Result") %>
				</div>
		<%
			}
		%>
			</div>
				
		</div>
		
	
<%
		Connections.closeConnection();
	}
	catch(Exception e)
	{
		System.out.println("code.jsp ");
	System.out.println(e);
	}
%>
<script type="text/javascript">
    window.onload = function() {
        
        <% if(request.getAttribute("Result")!=null){
        	%>
        	document.getElementById("result").scrollIntoView();
        	<%
        }
        else{
        	%>
        	document.getElementById("logic").focus();
        	<%
        }
        	%>
        
        	
    }
    function myFunction() {
    	document.getElementById("hidCode").value=document.getElementById("logic").textContent;	
    }
</script>
</body>
</html>