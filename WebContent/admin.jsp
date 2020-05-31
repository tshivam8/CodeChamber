<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<form action="quesreg">
		<table>	
	<tr>
		<td>Question No</td>
		<td><input type="text" name="quesno"></td>
	</tr>
	<tr>
		<td>Question</td>
		<td><textarea name="question"></textarea></td>
	</tr>
	<tr>
		<td>Question Tag</td>
		<td><input type="text" name="questag"></td>
	</tr>
	<tr>
		<td>Input Format</td>
		<td><textarea name="inf"></textarea></td>
	</tr>
	<tr>
		<td>Output Format</td>
		<td><textarea name="opf"></textarea></td>
	</tr>
	<tr>
		<td>Constraints</td>
		<td><textarea name="cons"></textarea></td>
	</tr>
	<tr>
		<td>Marks</td>
		<td><input type="text" name="marks"></td>
	</tr>
	<tr>
		<td>Testcase1</td>
		<td><textarea name="t1"></textarea></td>
	</tr>
	<tr>
		<td>Answer1</td>
		<td><textarea name="a1"></textarea></td>
	</tr>
	<tr>
		<td>Testcase2</td>
		<td><textarea name="t2"></textarea></td>
	</tr>
		<tr>
		<td>Answer2</td>
		<td><textarea name="a2"></textarea></td>
	</tr>
	<tr>
		<td>Testcase3</td>
		<td><textarea name="t3"></textarea></td>
	</tr>
		<tr>
		<td>Answer3</td>
		<td><textarea name="a3"></textarea></td>
	</tr>
		</tr>
		<tr>
		<td></td>
		<td><input type="submit" value="submit"></td>
	</tr>
	</table>
		
	</form>
</body>
</html>