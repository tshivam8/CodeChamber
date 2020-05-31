<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.connections.*,java.sql.*,java.io.IOException,com.classes.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<%!
	Bean b;
	String clg,code,btn,lang,pool,err,yo,questag,ans1;
	
%>
<%
					System.out.println("result");
					clg=(String)session.getAttribute("college");
					pool=(String)session.getAttribute("pool");
					code=(String)request.getParameter("code");
					btn=(String)request.getParameter("sbt");
					questag=(String)request.getParameter("questag");
					ans1=(String)request.getParameter("ans1");
					lang=(String)request.getParameter("opt");
					System.out.println("College "+clg);
					System.out.println("Pool "+pool);
					System.out.println("Code "+code);
					System.out.println("Button "+btn);
					System.out.println("Questag "+questag);
					System.out.println("Cans1 "+ans1);
					System.out.println("lang "+lang);
					Compile c=new Compile(questag,pool,lang,clg,code,btn);
					b=c.compi();
					//Bean b=(Bean)request.getAttribute("Result");
					if(b.getMark()==0)
					{
					err=b.getError();
					yo=b.getMyOut();
					System.out.println("yo :"+yo);
					System.out.println("err :"+err);
		%>
				<div id="result" style="background-color:white;color:black;overflow: auto;padding:10px;min-height:100px;box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);border-radius:5px">
				<%if(yo.equals(ans1)) {%>
					<div style="height:30px ;width:100%;">
						<b>Result : </b> <i class="fa fa-check-circle" style="color:green"></i> <span style="color:green">Compiled and Run</span> 
					</div>
				<%}
				if(!yo.equals(ans1))
				{
					%>
					<div style="height:30px ;width:100%;">
					<b>Result : </b> <i class="fa fa-times-circle fa-red result-icon tool-tip" style="color:red"></i> <span style="color:red">Wrong Answer</span> 
				</div>
				<%}
					if(!err.equals("")){
				%>
						<pre><%=err %></pre>
				<%
					}else
					{
				%>
					<h3>Your Output</h3>
					<% if(!yo.equals("")) {%>
					<pre><%=yo %></pre>
					<% }else {%>
					<pre>Your Code prints Nothing ..</pre>
				<%
						}
					} 
				%>
				
					<h3>Expected Output</h3>
					<pre><%=ans1 %></pre>
				
				</div>	
		<%
			}
			else
			{
				%>
				<div id="result" style="background-color:white;color:black;overflow: hidden;;padding:10px;min-height:100px;box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);border-radius:5px">
				<div style="margin-bottom:5px;min-height:30px;padding-top:5px;margin-left:15px;">
					<b style="font-size:20px">Result :</b>
				</div>
				<table style="width:100%;padding:5px;margin:5px">
					<tr><td>TestCase 1</td>
						
						<td>
							<%if(b.getQ(1)==true){%> <i class="fa fa-check-circle" style="color:green;font-size:30px"></i> 
							<%}else %> <i class="fa fa-times-circle fa-red result-icon tool-tip" style="color:red;font-size:30px"> </i>
						</td>
						<td>
						<%if(b.getQ(1)==true){%> <%=b.getMark() %> 
							<%}else %> 0
						</td>
					</tr>
					<tr><td>TestCase 2</td>
						
						<td>
							<%if(b.getQ(2)==true){%> <i class="fa fa-check-circle" style="color:green;font-size:30px"></i> 
							<%}else %> <i class="fa fa-times-circle fa-red result-icon tool-tip" style="color:red;font-size:30px"> </i>
						</td>
						<td>
						<%if(b.getQ(2)==true){%> <%=b.getMark() %> 
							<%}else %> 0
						</td>
					</tr>
					<tr><td>TestCase 3</td>
						
						<td>
							<%if(b.getQ(3)==true){%> <i class="fa fa-check-circle" style="color:green;font-size:30px"></i> 
							<%}else %> <i class="fa fa-times-circle fa-red result-icon tool-tip" style="color:red;font-size:30px"> </i>
						</td>
						<td>
						<%if(b.getQ(3)==true){%> <%=b.getMark() %> 
							<%}else %> 
						</td>
					</tr>
					
				</table>
				</div>
				<%
				}
				%>
</body>
</html>