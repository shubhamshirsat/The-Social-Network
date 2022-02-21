<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    
<!DOCTYPE html>
<html>
<head>
<title> 
The Social Network</title>

<link type="text/css" rel="stylesheet" href="w3.css" />
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-light-blue.css">

<script>

	var flag1= true, flag2 = true, flag3 = true;
	
	function validateDOB()
	{
		
		var dob = document.getElementById('dob').value;	
		var yob = new Date(dob);
		var current = new Date();
		
		
		
		if((current.getFullYear() - yob.getFullYear() < 18))
		{
			document.getElementById('dobError').style = 'display: block; font-size: small; color: red;';
			document.getElementById('dobError').innerHTML = '\* You are below 18';
			flag1 = false;
		}	
		else
		{
			document.getElementById('dobError').innerHTML = '';
			document.getElementById('dobError').style = 'display: none';
			flag1 = true;
		}
	}
	
	function validateMobile()
	{
		var mobile = document.getElementById('mobile').value;
		if((mobile.length < 10))
		{
			document.getElementById('mobileError').style = 'display: block; font-size: small; color: red;';
			document.getElementById('mobileError').innerHTML = '\* Mobile number should contain minimum 10 digits';
			flag2 = false;
		}
		else
		{
			document.getElementById('mobileError').innerHTML = '';
			document.getElementById('mobileError').style = 'display: none';
			flag2 = true;
		}
		
	}
	
	function validatePassword()
	{
		var password = document.getElementById('password').value;
		if((password.length < 7))
		{
			document.getElementById('passwordError').style = 'display: block; font-size: small; color: red;';
			document.getElementById('passwordError').innerHTML = '\* Password should contain minimum 7 characters';
			flag3 = false;
		}
		else
		{
			document.getElementById('passwordError').innerHTML = '';
			document.getElementById('passwordError').style = 'display: none';
			flag3 = true;
		}
	}
	
	function validate()
	{
		if(flag1 == true && flag2 == true && flag3 == true)
		{
			return true;
				
		}
		else
		{
			alert('\n\nPlease provide correct information');
			return false;			
		}
	}
	
</script>

</head>



<body class="w3-animate-top">

<%-- 

<div class="header" >
	<div>
		<h1>The Social Network</h1>
	</div>
	

<form method="post" action="Signin">

	<div id="form1" class="header">Email or Username<br>
		<input placeholder="Email" type="email" id="login" name="username" required="required"/><br>
	</div>

	<div id="form2" class="header">Password<br>
		<input placeholder="Password" type="password" id= "login" name="password" required="required"/><br>
		Forgotten my password ?
	</div>
	<div id="submit1" class="header"><input type="submit" id="button1" value="login"/></div>
</form>

</div>


<div class="bodyx">
<!-- 
   <div id="intro1" class="bodyx">Let's Connect...... <br>Join SOON !</div>
    -->
    
<div id="intro2" class="bodyx">Create an account</div>
<div id="img2" class="bodyx"><img src="bg.png"/></div>
<div id="intro3" class="bodyx">&nbsp;It's free and always will be.</div>

<form method="post" action="Signup" >
<div id="form3" class="bodyx">

<table  cellpadding="4">

	<tr>
		<td><input  placeholder="  Firstname" type="text" name = "firstName" required="required"/></td>
		<td><input placeholder="  Lastname" type="text"  name = "lastName" required="required"/></td>
	</tr>
	
	<tr>
		<td colspan="2"><input placeholder="  Email" type="email" name = "email" required="required"/><br></td>
	</tr>
	
	<tr>
	<td colspan="2"><input placeholder="  Password" type="password"  name = "password" required="required"/><br></td>
	</tr>
	
	<tr>
	<td colspan="2"><input placeholder="  Mobile Number" type="text"  name = "mobile" required="required"/><br></td>
	</tr>
	
	<tr>
	<td colspan="2"><input placeholder="Date Of Birth" type="date"  name = "dob" required="required"/><br></td>
	</tr>
	
	<tr>
		<td colspan="2">
			<input type="radio" name="gender" value="Male" required="required"/> Male  
			<input type="radio" name="gender" value="Female" required="required"/> Female
		</td>
	</tr>
	
</table>
	
	
	<h6>By signing up, you agree to our terms of use, privacy policy, and cookie policy.</h6>
	<input type="submit" class="w3-button w3-green" value="Sign Up"/>
</form>

</div>

</div>

</div>
<%
        	String msg = (String) request.getAttribute("msg");
        	if(msg != null)
        	{
        		out.println("<h3>"+msg+"</h3>");
        	}
%>


*************************************************************************************************************************************
--%>





<div>

	<div class="w3-bar w3-theme-d5">
	  	<div class="w3-half w3-padding">
	  		<h3>The Social Network</h3>
	  	</div>
	  	<div class="w3-half w3-container w3-padding">
	  		<form method="post" action="Signin">
	  		
	  			
		  			<input name="username" type="email" placeholder=" Email" style="border: 1px;" required="required"/>
					<input name="password" type="password" placeholder=" Password" style="border: 1px;"  required="required"/>
					<input type="submit" value="login" style="border: none;"/>
					<br>
					<a href="ForgotPassword" style="text-decoration: none;" class="w3-small">Forgot password?</a>
					<span class="w3-small w3-padding">					
						<%
						       	String msg = (String) request.getAttribute("msg");
						       	if(msg != null)
						       	{
						       		out.println(msg);
						       	}
						%>
					</span>
					
	  		</form>
	  	</div>	
	</div>

	<div class="w3-container w3-theme-l4">
			
			<div class="w3-half w3-padding">
				
				<img src="Images/fb.png" style="max-width: 100%; margin-top: 25%;">
			</div>
			
			<div class="w3-half w3-padding">
				<h2>Create a new account</h2>
				<h6>It's free and always will be.</h6>
				<br>
				<form method="post" action="Signup" onsubmit="return validate()">
					<table  cellpadding="4">
					
						<tr>
							<td><input  placeholder="  First name" type="text" name = "firstName" class="w3-input w3-border" required="required"/></td>
							<td><input placeholder="  Last name" type="text"  name = "lastName" class="w3-input w3-border" required="required"/></td>
						</tr>
						
						<tr>
							<td colspan="2"><input placeholder="  Email" type="email" name = "email" class="w3-input w3-border" required="required"/></td>
						</tr>
						
						<tr>
							<td colspan="2">
								<input onchange=validatePassword() placeholder="  Password" type="password" id="password" name = "password" class="w3-input w3-border" required="required"/>
								<span id="passwordError" style="font-size: small; color: red;"></span>
							</td>
						</tr>
						
						<tr>
						<td colspan="2">
							<input onchange="validateMobile()" placeholder="  Mobile Number" type="text" id="mobile" name = "mobile" class="w3-input w3-border" required="required"/>
							<span id="mobileError" style="font-size: small; color: red;"></span>
						</td>
						</tr>
						
						<tr>
							<td>
								Birthday<br>
								<input type="date" onchange="validateDOB()" id="dob"  name = "dob" required="required"/>
								<span id="dobError" style="font-size: small; color: red;"></span>
							</td>
						</tr>
						
						<tr>
							<td colspan="2" style="padding: 10px;">
								<input type="radio" name="gender" value="Male" required="required"/> Male  
								<input type="radio" name="gender" value="Female" required="required"/> Female
							</td>
						</tr>
						
					</table>
						
						
						<h6>By signing up, you agree to our terms of use<br> and policy.</h6>
						<input type="submit" class="w3-button w3-green" value="Sign Up"/>
				</form>
				<br><br>
			</div>
			
		</div>
</div>
<div>
	<br>
	<footer style="text-align: center;">
		<span class="w3-small">The Social Network &copy; 2018</span>
	</footer>
</div>

<a href="error.jsp">error</a>


</body>
</html>