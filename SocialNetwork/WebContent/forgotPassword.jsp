<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%
 		String exception = (String) request.getAttribute("exception");
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reset Password</title>
<link type="text/css" rel="stylesheet" href="w3.css" />
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-light-blue.css">

</head>
<body>


<div>

	<div class="w3-bar w3-theme-d5">
	  	<div class="w3-half w3-padding">
	  		<h3>The Social Network</h3>
	  	</div>
	  	<div class="w3-half w3-container w3-padding">
	  		
	  	</div>	
	</div>

	<div class="w3-container w3-theme-l4">
		
		<div class="w3-third">&nbsp;
		</div>
		
		<div class="w3-third w3-padding">
			<div class="w3-white w3-border w3-padding" style="margin-top: 20%;">
				
				<% 
					if(exception == null)
					{
						
					
						String requestFor = (String) request.getAttribute("requestFor");
						if(requestFor.equals("forgetPassword"))
						{
						
					%>
						 	<h4>Find Your Account</h4>
							<hr>
							<p class="w3-small">Please enter your email address to search for your account.</p><br>
							<form action="ForgotPassword"  method="post">
								<input type="hidden" name="requestFor" value="generateOTP">
								<input type="email" name="emailTo" placeholder="Email Id">
								<input type="submit" value="Search" class="w3-theme-d5" style="border: none;" />
							</form>
							<br> 
							
					<%
						}
						else if(requestFor.equals("verifyOTP"))
						{
							String email = (String) request.getAttribute("to");
					%>
							<h4>Verify OTP</h4>
							<hr>
							<p class="w3-small">OTP has been sent to <%=email %></p><br>
							<form action="ForgotPassword"  method="post">
								<input type="hidden" name="requestFor" value="verifyOTP">
								<input type="hidden" name="email" value="<%=email%>">
								<input type="text" name="otp" placeholder="Enter OTP"><br><br>
								<input type="password" name="password" placeholder="Enter New Password"><br><br>
								<input type="submit" value="Verify" class="w3-theme-d5" style="border: none;" />
							</form>
							<br>
					<%	
						}
						else if(requestFor.equals("resetPasswordFailed"))
						{
					%>
							<h4>Sorry! You entered invalid OTP</h4>
							<hr>
							<p class="w3-small">Your OTP has expired.Please <a href="ForgotPassword" style="text-decoration: none;">try again.</p><br>
							
					<% 
						}
					}
					else
					{
					%>
							<h4><%=exception %></h4>		
					<%
					}
				%>
			</div>
		</div>
		
		<div class="w3-third" style="margin-top: 45%;">&nbsp;
		</div>
	
			<!-- 
			<h2>Find Your The Social Network Account</h2>
		<br>
			
			  
			To:<input type="text" name="to"/><br/>  
			Subject:<input type="text" name="subject"><br/>  
			Text:<textarea rows="10" cols="70" name="msg"></textarea><br/>  
			<input type="submit" value="send"/>  
			</form>   -->
				
	</div>
</div>
<div>
	<br>
	<footer style="text-align: center;">
		<span class="w3-small">The Social Network &copy; 2018</span>
	</footer>
</div>




</body>
</html>