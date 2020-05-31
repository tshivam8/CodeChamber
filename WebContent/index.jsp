<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.connections.*,java.sql.*,java.util.*,java.io.IOException,com.classes.Bean" %>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	    <script src="jquery-3.4.1.min.js"></script>
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	    
	    <title></title>
	    <meta name="description" content="">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	 	<META Http-Equiv="Cache-Control" Content="no-cache">
		<META Http-Equiv="Pragma" Content="no-cache">
		<META Http-Equiv="Expires" Content="0">
		<link rel="stylesheet" href="style.css">
	</head>
	    
	<body>
	
	    <%
	    	if((String)request.getAttribute("college")!=null)
	    	{
	    		response.sendRedirect("azaxCode.jsp");
	    	}
	    	else
	    	{
	    		//System.out.println("pal count".replace(" ",""));
	    %>    
		<div class="header" style="min-height:80px;border-radius:5px;box-shadow: 10px 10px 5px grey;border:none;background-color:green" id="myHeader">
			<div style="position:absolute;top:25px;right:30px;">
				<form role="form" name="myF" method="post" id="logform" action="login">
					<input style="margin:2px" name="id" type="text" id="textf" placeholder="Username">
					<input style="margin:2px" type="password" name="pass" id="passf" placeholder="Password">
					<button style="  margin:2px; border-radius: 5px;width: 80px;height:25px;" type="button" onclick="validate()">Sign in</button>
			      </form>
			     <!--  <br><a href="admin.jsp" style="float:right">ADMIN LOGIN</a> -->
			</div>	
		</div>
		<br>
		
	<div style="margin:20px">
		<div style="width:65%;float:left">
			<h1 style="color: white;text-shadow: 1px 1px 2px black, 0 0 25px blue, 0 0 5px darkgreen;">CODE CHAMBER</h1>
			<div>
			<p style="font-size:25px;font-family: myFirstFont;">A programmer is ideally an essayist who works with traditional aesthetic and literary forms as well as mathematical concepts, to communicate the way that an algorithm works and to convince a reader that the results will be correct.</p>
			</div>
		</div>
		<div style="width:30%;float:right;height:550px;">
			<div style="width:30%;min-height:550px;font-family: Comic Sans MS, cursive, sans-serif;position:absolute;top:15%;left:68%;border-radius:10px; 
			box-shadow: 10px 10px 5px grey;background:linear-gradient(to top, white, Gainsboro);">
	
	
	
	<form name="myForm" id="myForm" method="get" action="register">
	
			<div style="text-align:center">
				<h2 style="color: white;text-shadow: 1px 1px 2px black, 0 0 25px blue, 0 0 5px darkgreen;">REGISTER</h2>
			</div>
			<hr>

			<table style="position:absolute;top:20%;left:15%;">
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
					<td height="50">Pool</td>
					<td height="50">
					<select id="pool" name="pool" onchange="myFun(this.value)">
					<option value="" selected disabled>select your pool</option>
						<option value="A">A</option>
						<option value="B">B</option>
						<option value="C">C</option>
						<option value="D">D</option>
						<option value="E">E</option>
					</select>
					</td>
				</tr>
				<tr>
				<td height="50">Question Number</td>
				<td height="50">
				<select id="quesno" name="quesno">
					
				</select>
				</td>
			</tr>
			
			<tr>
				<td></td>
				<td height="50">
				<button style="border-radius: 5px;width: 80px;height:25px" onclick="register()" type="button" name="sbt" value="Register">Register</button></td>
			</tr>

		</table>
</form>



</div>
		</div>
		  <br>
		      
		        <div>
					
					<div style="width:30%;float:left;border-radius:10px;background-color:#f1f1f1;text-align:center;box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);">
						<h2>About</h2>
		                <ul>
		                	<li>Code Chamber is a coding event where you have to enter into a logical chamber and you will find others competing with each others and you have to do the same</li>
		                </ul>
		            </div>
		            <div style="width:4%;float:left;"></div>
					<div style="float:left;width:30%;border-radius:10px;background-color:#f1f1f1;box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);">
						<div style="text-align:center"><h2 id="demo">Rules</h2></div>
			            <ul>
						  <li>Each team will have exactly two participants.</li>
						  <li>Codes will be randomly allocated to teams.</li>
						  <li>It is the final round, there are no further rounds.</li>
						  <li>No participant can be the member of more than one team.</li>
						  <li>No registration is required.</li>
						  <li>Teams involving in any type of malpractice will be disqualified.</li>
						</ul>
					</div>
		        </div>
		        
	
	</div>	
		<footer style="position:absolute;bottom:5px;width:99%;border:none;">
		<hr>
		<div style="text-align:center"><p>&copy; 2019, Made with &hearts; by EEC</p></div>
		</footer>
		<%} %>
		
	</body>
	<script>
		
		
		function myFun(po){
	               $.ajax({
	                    url: 'pool.jsp',
	                    data: { pool : po },
	                    type: 'POST',
	                    success: function (result)
	                    {
	                        $('#quesno').html(result);
	                    }
	                });
	        }
		
			function validate()
			{
				if( document.myF.id.value == "" ) {
		            alert( "Please provide your id!" );
		            document.myF.id.focus() ;
		         }
				else if( document.myF.pass.value == "" ) 
				{
		            alert( "Please provide your password!" );
		            document.myF.pass.focus() ;
		         }
				else
				{
					document.myF.submit();
				}
			}
			
			function register()
			{
				if( document.myForm.clg.value == "" ) {
		            alert( "Please provide your college name!" );
		            document.myForm.clg.focus() ;
		         }
				else if( document.myForm.id.value == "" ) {
		            alert( "Please provide your username!" );
		            document.myForm.id.focus() ;
		         }
				else if( document.myForm.pass.value == "" ) {
		            alert( "Please provide your password!" );
		            document.myForm.pass.focus() ;
		         }
				else if( document.myForm.cnfpass.value == "" ) {
		            alert( "Please confirm your password!" );
		            document.myForm.cnfpass.focus() ;
				}
				else if(document.myForm.pass.value != document.myForm.cnfpass.value)
					{
						alert( "Password Confirmation Failed!" );
		            	document.myForm.cnfpass.focus() ;
					}
				else
				{
					var frm = $('#myForm');
					alert('d');
					$.ajax({
						type: frm.attr('method'),
						url: frm.attr('action'),
						data: frm.serialize(),
						success: function(data){
							if(data=='true')
								{
									alert('Registered Successfully\nNow you can Login');
								}
							else if(data=='rep')
								{
									alert('Registeration Failed!!!\nMay be you are already registered');
								}
							else
								{
									alert('Registeration Failed!!');
								}
						}
					});
				}
			}
	
		

		</script>
</html>
