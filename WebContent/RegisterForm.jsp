<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

</head>
<body>
<div style="width:30%;min-height:50px;text-align:center;border:1px solid black;position:absolute;top:5%;left:35%">
<h1>
	REGISTER YOURSELF
</h1>
</div>
<div style="width:30%;min-height:400px;position:absolute;top:25%;left:35%;border-radius:10px;background-color:#f1f1f1;box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);">
<form name="myForm" action="register">
	<table style="position:absolute;top:10%;left:15%;">
		<tr>
			<td height="50" width="150">College Name </td>
			<td height="50"><input type="text" name="clg"></td>
		</tr>
		<tr>
			<td height="50">Username </td>
			<td height="50"><input type="text" name="id"></td>
		</tr>
		<tr>
			<td height="50">Password </td>
			<td height="50"><input type="password" name="pass"></td>
		</tr>
		<tr>
			<td height="50">Confirm Password </td>
			<td height="50"><input type="password" name="cnfpass"></td>
		</tr>
		<tr>
			<td height="50"><input type="submit" onclick="register()" name="sbt" value="Register"></td>
			<td height="50"><a href="index.jsp">HOME</a></td>
		</tr>
		<%if(request.getParameter("flag")!=null ) { %>
		<tr>
			<td><%if(request.getParameter("flag").equals("true")){ %>Registered Successfully !!!<%}else{ %>Registration Failed !!!<%} %></td>
			
		</tr>
		<%} %>
	</table>
</form>
</div>
</body>

<script>
function register()
{
	if( document.myForm.pass.value != document.myForm.cnfpass.value ) {
            alert( "Password doesnt match!" );
            document.myForm.pass.focus() ;
            return false;
         }
	
}
</script>
</html>