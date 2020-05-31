<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<p> Sorry you are not allowed to enter the contest ...</p><br>
	<%	
		out.println("Your IP Address is "+request.getRemoteAddr()); 
	%>
	<p>Today's date: <%= (new java.util.Date()).toLocaleString()%></p>
</body>
</html>