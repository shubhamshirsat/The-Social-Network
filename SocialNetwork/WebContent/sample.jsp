<%@page import="dto.PostNotification"%>
<%@page import="dto.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
		
			response.setHeader("Cache-Control", "no-cache, no-store, must revalidate");			// HTPP 1.1
			response.setHeader("Pragma", "no-cache");											// HTTP 1.0
			response.setHeader("Expires", "0");													// Proxies
		
			
			User user = (User) session.getAttribute("user");
			if(user == null)
			{
				response.sendRedirect("SignIn");
			} 
			
			
			ArrayList<User> friendList = (ArrayList<User>) session.getAttribute("friendList");
			ArrayList<Post> postList = (ArrayList<Post>) session.getAttribute("postList");
			ArrayList<User> receivedRequestList = (ArrayList<User>) session.getAttribute("receivedRequestList");
			ArrayList<PostNotification> postNotificationList = (ArrayList<PostNotification>) session.getAttribute("postNotificationList");

%>

<!DOCTYPE html>
<html>
<head>

<script type="text/javascript">

function loadData(resource)
{
	var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
	      document.getElementById("body").innerHTML = this.responseText;
	    }
	  };
	  xhttp.open("GET", resource, true);
	  xhttp.send();
}

</script>


<title>The Social Network</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="w3.css">
<%--  	<link rel="stylesheet" href="w3-theme-blue-grey.css"> --%>
	<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
	<link rel="stylesheet" href="font-awesome.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">	
	
	<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-light-blue.css">
	
	<style>
			html,body,h1,h2,h3,h4,h5 
			{
				font-family: "Open Sans", sans-serif
			}
			
			
		/* width */
		::-webkit-scrollbar {
		    width: 10px;
		}
		
		/* Track */
		::-webkit-scrollbar-track {
		    background: #f1f1f1; 
		}
		 
		/* Handle */
		::-webkit-scrollbar-thumb {
		    background: #888; 
		}
		
		/* Handle on hover */
		::-webkit-scrollbar-thumb:hover {
		    background: #555; 
		}

			
	</style>
	
	<script type="text/javascript" src="social-network.js"></script>
	<script type="text/javascript" src="jquery-1.10.2.min.js"></script>
	
	<script>
	

	

	
			function getNews()
			{
					  var xhttp = new XMLHttpRequest();
					  xhttp.onreadystatechange = function() 
					  {
						   if (this.readyState == 4 && this.status == 200) 
						   {
						      document.getElementById("newsFeed").innerHTML = xhttp.responseText;
						   }
					  };  
					  xhttp.open("GET", "newsFeed.jsp", true);
					  xhttp.send();
					  
			}
			
			
			function recommendFriends()
			{
				var xhttp = new XMLHttpRequest();
				  xhttp.onreadystatechange = function() 
				  {
					   if (this.readyState == 4 && this.status == 200) 
					   {
					      document.getElementById("recommendations").innerHTML = xhttp.responseText;
					   }
				  };  
				  xhttp.open("GET", "FriendsRecommendation", true);
				  xhttp.send();
			}
			
		
			function loadPages()
			{
				getNews();
				recommendFriends();
			}

			
			function search(id)
			{
						var keyword = document.getElementById("s").value;
						
						if(keyword == "")
						{
							document.getElementById("results").style= "display: none;";
						}
						else
						{
														
								var xhttp = new XMLHttpRequest();
							
								xhttp.onreadystatechange= function()
								{
									if(xhttp.readyState == 4 && xhttp.status == 200)
									{
										
										document.getElementById("results").innerHTML = xhttp.responseText;
										document.getElementById("results").style= "width: 32%; display: block; position:absolute; top:50px; left: 34%;";
										document.getElementById("results").classList.add("w3-card");
										document.getElementById("results").classList.add("w3-white");
										document.getElementById("results").classList.add("w3-animate-opacity");
									}
								};
								
								xhttp.open("POST", "Activity", true);
								xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
								xhttp.send('activity='+1+'&keyword='+keyword+'&userid='+id);
						}
			}
			
			
	</script>


</head>
<body onload="loadData('home.jsp')" id="body">

		<!--##### Navbar #####--> 
		
		<div class="w3-top">
			  <div class="w3-bar w3-theme-d5 w3-padding">
				   <div class="w3-third w3-padding">
				  		&nbsp;Hi! <a href="Profile" style="text-decoration: none;"><%=user.getFirst_name() %></a>
				  		&nbsp;|&nbsp;<a href="home.jsp" style="text-decoration: none;">Home</a>
				   </div>
			    
				  <input type="search" id="s" class="w3-third w3-bar-item w3-input" style="width: 33%;" name="keyword" placeholder="Search Friend" onkeyup="search('<%=user.getId()%>')">
			      <div id="results" class="w3-padding" style="position:absolute; top:50px; left: 34%;">
					</div>	
			      
				  <form action="Request" method="post" id="requestForm">
				      <input type="hidden" name="requestType" id="reqType">
				      <input type="hidden" name="senderID" id="send">
				      <input type="hidden" name="receiverID" id="receive">
				  </form>
			  
			  	  <div class="w3-dropdown-hover w3-hide-small">
				      <button class="w3-button w3-padding"><i class="fa fa-user"></i><span class="w3-badge w3-right w3-small w3-green"><%if(receivedRequestList.size() != 0){out.print(receivedRequestList.size());} %></span></button>     
					    
					    <div class="w3-dropdown-content w3-card-4 w3-bar-block w3-animate-zoom" style="width:300px; max-height: 500px; overflow: auto;">
						      <%
									if(receivedRequestList.isEmpty())
									{
										out.println("<br><center><span style='font-size: 14px;'>No Friend Requests!</span></center>");
									}
									else
									{
										for(int i=0; i < receivedRequestList.size(); i++)
										{
							   %>  
							   			    <hr>
										        <div class="w3-container">
										         
										          <img src="<%=receivedRequestList.get(i).getImage_path() %>" alt="Avatar" style="width:75px;">
										          <span><a href='#' class='w3-text-blue' style='text-decoration: none' onclick='viewUser(<%=receivedRequestList.get(i).getId()%>)'><%=receivedRequestList.get(i).getFirst_name()+" "+receivedRequestList.get(i).getLast_name()%></a></span>
										          <div class="w3-row w3-opacity">
										            <div class="w3-half">
										              <button class="w3-button w3-block w3-green" title="Accept" onclick="processRequest(2,<%=receivedRequestList.get(i).getId()%>,<%=user.getId()%>)"><i class="fa fa-check"></i></button>
										            </div>
										            <div class="w3-half">
										              <button class="w3-button w3-block w3-red" title="Decline" onclick="processRequest(3,<%=receivedRequestList.get(i).getId()%>,<%=user.getId()%>)"><i class="fa fa-remove"></i></button>
										            </div>
										          </div>
										        </div>
										       
							  <%
										}
									}
						      %>
					        <br>
					      </div>
			  	   </div> 
			  
			  
			  	    <!-- Notifications -->	
					    
					 <div class="w3-dropdown-hover w3-hide-small">
					    <button class="w3-button w3-padding" title="Notifications"><i class="fa fa-bell"></i><span class="w3-badge w3-right w3-small w3-green"><%if(postNotificationList.size() != 0){out.print(postNotificationList.size());} %></span></button>
					         
						     <div class="w3-animate-zoom w3-dropdown-content w3-card-4 w3-bar-block<%if(!postNotificationList.isEmpty()){out.println(" w3-padding");} %>" style="width:300px; max-height: 500px; overflow: auto;">
						      <%
						      		if(postNotificationList.isEmpty())
						      		{
						      			out.println("<br><center><span style='font-size: 14px;'>No Notifications!</span></center>");
						      		}
						      		else
						      		{
								      		for(int i = 0; i < postNotificationList.size(); i++)
								      		{
								      							      			
								      			out.print("<hr><a href='#' class='w3-text-blue' style='text-decoration: none' onclick='viewUser("+postNotificationList.get(i).getLikesByuserid()+")'>"+postNotificationList.get(i).getLikeByUserFirstName()+" "+postNotificationList.get(i).getLikeByUserLastName()+"</a> likes your post<br>");
							      				out.print("\""+postNotificationList.get(i).getText().substring(0,postNotificationList.get(i).getText().length()/2)+"...\"");
								      		}
						      		}
						      	
						      %>
						      <br>
						    </div>
				     </div>
				     
				     <form action="ViewUser" method="post" id="viewUserForm">
						<input type="hidden" name="userId" id="viewUserId">
					</form>
			  
			      	<a href="Logout" class="w3-bar-item w3-button w3-hide-small w3-right w3-padding-large w3-hover-white" title="My Account">Logout</a>
			  </div>
		</div>



</body>
</html>
