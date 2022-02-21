<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="dto.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.User"%>
    

    
    
<%
	response.setHeader("Cache-Control", "no-cache, no-store, must revalidate");	// HTPP 1.1
	response.setHeader("Pragma", "no-cache");	// HTTP 1.0
	response.setHeader("Expires", "0");		// Proxies

	User user = (User) session.getAttribute("user");
	if(user == null)
	{
		response.sendRedirect("SignIn");
	} 
	
	ArrayList<User> friendList = (ArrayList<User>) session.getAttribute("friendList");
	ArrayList<Post> postList = (ArrayList<Post>) session.getAttribute("postList");
	
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="w3.css">
<link rel="stylesheet" href="w3-theme-blue-grey.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
<link rel="stylesheet" href="font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
html,body,h1,h2,h3,h4,h5 {font-family: "Open Sans", sans-serif}
</style>



</head>
<body>
<br>

	<%
		if(!postList.isEmpty())
		{
			for(int i = 0; i<postList.size(); i++)
			{
				Post post = postList.get(i);
				
	%>
				  
			      <div class="w3-border w3-white w3-round w3-padding"><br>
			        
					        <img src="<%=post.getImage_path() %>" alt="Avatar" class="w3-left w3-circle w3-margin-right" style="width:40px">
					        <span class="w3-right w3-opacity"><%=post.getPost_timestamp().toString().substring(0,16) %></span>
					        <h4><%=post.getFirst_name()+" "+post.getLast_name() %></h4>
					        <hr class="w3-clear">
					        <p><%=post.getPost_text() %></p>
					     
	
	<% 	
							if(post.getPost_type().contains("image"))
							{
	%>
								<div class="w3-padding">
						        	<img alt="Image unavailable" src="<%=post.getPost_url()%>" style="max-width: 100%;">
						        </div>
	<% 
							}
					
							if(post.getPost_type().contains("video"))
							{
	%>
								<div class="w3-padding">
	        						<video width="100%" height="250" controls>
				  					<source src="<%=post.getPost_url() %>" type="<%=post.getPost_type()%>">
									</video>
	        					</div>
	<%
		}
	
	%>
	  				        
							<br>
					        	<button type="button" class="w3-button w3-theme-d5 w3-margin-bottom" onclick ='hitLike("<%=post.getUser_id()%>","<%=post.getPost_timestamp()%>","<%=user.getId()%>")'><i class="fa fa-heart-o" ></i> Like <%if(post.getPost_likes()>0){out.print(post.getPost_likes());} %></button> 
					        <br>
					        			         
			      </div><br>
	<%																	
			}
		}
	%>			  
          

</body>
</html>