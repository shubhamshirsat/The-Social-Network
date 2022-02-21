<%@page import="java.util.List"%>
<%@page import="dto.PostNotification"%>
<%@page import="dto.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%



	response.setHeader("Cache-Control", "no-cache, no-store, must revalidate");			// HTPP 1.1
	response.setHeader("Pragma", "no-cache");											// HTTP 1.0
	response.setHeader("Expires", "0");													// Proxies



	User loggedInUser = (User) session.getAttribute("user");
	
	ArrayList<User> friendList = (ArrayList<User>) session.getAttribute("friendList");			// To check whether this user exist in my friend list or not 
	ArrayList<User> sentRequestList = (ArrayList<User>) session.getAttribute("sentRequestList");
	ArrayList<User> receivedRequestList = (ArrayList<User>) session.getAttribute("receivedRequestList");

	if(loggedInUser == null)
	{
		response.sendRedirect("SignIn");
	}
	
	User user = (User) request.getAttribute("viewUser");
	

	boolean isFriend = false;
	boolean isRequestSent = false;
	boolean isRequestReceived = false;

	
	ArrayList<Post> userPostList = (ArrayList<Post>) request.getAttribute("userPostList");
	ArrayList<User> searchUserFriendList = (ArrayList<User>) request.getAttribute("searchUserFriendList");
	ArrayList<PostNotification> postNotificationList = (ArrayList<PostNotification>) session.getAttribute("postNotificationList");
	ArrayList<User> mutualFriendsList = (ArrayList<User>) request.getAttribute("mutualFriendsList");

%>
     
<!DOCTYPE html>
<html>
<title><%=user.getFirst_name()+" "+user.getLast_name() %></title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="w3.css">
<link rel="stylesheet" href="w3-theme-blue-grey.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
<link rel="stylesheet" href="font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">	

<style>
html,body,h1,h2,h3,h4,h5 
{
	font-family: "Open Sans", sans-serif;
}

a{
text-decoration: none;
}
</style>

<script type="text/javascript" src="social-network.js"></script>



<style>
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


<script>

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


<body class="w3-theme-l5 w3-animate-right">

<!-- Navbar -->
<!-- Navbar -->
<!--##### Navbar #####--> 
		
		<div class="w3-top">
			  <div class="w3-bar w3-theme-d5 w3-padding">
				  <div class="w3-third w3-padding">
				  		&nbsp;Hi! <a href="Profile" style="text-decoration: none;"><%=loggedInUser.getFirst_name() %></a>
				  		&nbsp;|&nbsp;<a href="Home" style="text-decoration: none;">Home</a>
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
										          <span><%=receivedRequestList.get(i).getFirst_name()+" "+receivedRequestList.get(i).getLast_name()%></span>
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
								      							      			
								      			out.print("<hr><a href='#' class='w3-text-blue' style='text-decoration: none'>"+postNotificationList.get(i).getLikeByUserFirstName()+" "+postNotificationList.get(i).getLikeByUserLastName()+"</a> likes your post<br>");
							      				out.print("\""+postNotificationList.get(i).getText().substring(0,postNotificationList.get(i).getText().length()/2)+"...\"");
								      		}
						      		}
						      	
						      %>
						      <br>
						    </div>
				     </div>
			  
			      	<a href="Logout" class="w3-bar-item w3-button w3-hide-small w3-right w3-padding-large w3-hover-white" title="My Account">Logout</a>
			  </div>
		</div>
		
		<!-- ########## -->

<!-- Navbar on small screens -->
<div id="navDemo" class="w3-bar-block w3-theme-d2 w3-hide w3-hide-large w3-hide-medium w3-large">
  <a href="#" class="w3-bar-item w3-button w3-padding-large">Link 1</a>
  <a href="#" class="w3-bar-item w3-button w3-padding-large">Link 2</a>
  <a href="#" class="w3-bar-item w3-button w3-padding-large">Link 3</a>
  <a href="#" class="w3-bar-item w3-button w3-padding-large">My Profile</a>
</div>







<div class="w3-container w3-content" style="max-width:1400px;margin-top:80px">    <!-- Page Container -->

  <div class="w3-row">    <!-- The Grid -->

      <div class="w3-col m1">   <!--Start Left Column -->
        &nbsp;
      </div>  <!-- End Left Column -->


<!-- Middle Column -->
    <div class="w3-col m10">

      <div class="w3-container w3-border w3-white w3-round w3-margin w3-padding" style="background-image: url(<%=user.getCover_image()%>)"><br>

          <div class="w3-rest">
          <img src="<%=user.getImage_path() %>" alt="Avatar" class="w3-left w3-margin-right" style="width:20%">
          <h3 class = "w3-text-black"><%=user.getFirst_name()+" "+user.getLast_name() %></h3><br>
          </div>

          <!-- <hr class="w3-clear"> -->

          <div class="w3-rest w3-right">
          
          <!-- Form to send friend request -->
          <form action="Request" method="post" id="sendRequestForm">
          	<input type="hidden" name="requestType" id="requestType">
          	<input type="hidden" name="senderID" id="senderID">
          	<input type="hidden" name="receiverID" id="receiverID">
          </form>
          
          	<%
          		
          	
          		for(int i = 0; i < friendList.size();i++)
          		{
          			if(friendList.get(i).getId() == user.getId())
          			{
          				isFriend = true;
          				break;
          			}
          		}
          		
          		for(int i = 0; i < sentRequestList.size();i++)
          		{
          			if(sentRequestList.get(i).getId() == user.getId())
          			{
          				isRequestSent = true;
          				break;
          			}
          		}
          		
          		for(int i=0; i < receivedRequestList.size(); i++)
          		{
          			if(receivedRequestList.get(i).getId() == user.getId())
          			{
          				isRequestReceived = true;
          			}
          		}

          		
          		if(loggedInUser.getId() != user.getId())
          		{
          	
		          		if(isFriend)
		          		{
		          	%>
		          			<button type="button" class="w3-button w3-theme-d5 w3-margin-bottom" disabled="disabled"><i class="fa fa-thumbs-up"></i>Friend</button>&nbsp;&nbsp;
		          	<%		
		          		}
		          		else if(isRequestSent)
		          		{
		          	%>
		          			<button type="button" class="w3-button w3-theme-d5 w3-margin-bottom" disabled="disabled"><i class="fa fa-thumbs-up"></i>Friend Request Sent</button>&nbsp;&nbsp;
		          	<%
		          		}
		          		else if(isRequestReceived)
		          		{
		  			%>
		          			<button type="button" class="w3-button w3-theme-d5 w3-margin-bottom" onclick="sendRequest('1','<%=loggedInUser.getId()%>','<%=user.getId()%>')" disabled="disabled"><i class="fa fa-thumbs-up"></i>Send Friend Request</button>&nbsp;&nbsp;
		    		<%
		          		}
		          		else
		          		{
		          	%>
		          			<button type="button" class="w3-button w3-theme-d5 w3-margin-bottom" onclick="sendRequest('1','<%=loggedInUser.getId()%>','<%=user.getId()%>')"><i class="fa fa-thumbs-up"></i>Send Friend Request</button>&nbsp;&nbsp;
		          	<%		
		          		}
          		}
          	%>
            
          </div>
      </div>

   
   
   
   <div class="w3-container w3-margin">

	
	    <div class="w3-half w3-padding">
	    	<h3>About</h3>          
					<div class="w3-border w3-round w3-white">
			            <div class="w3-container w3-padding-16">	
			
							<table class="w3-padding" cellspacing="20px">
							
								
								<tr>
									<td align="left">Status</td>
									<td><%=user.getAbout() %></td>
								</tr>
								
								<tr>
									<td align="left">Profession</td>
									<td><%=user.getProfession() %></td>
								</tr>
								
								<tr>
									<td align="left">Place</td>
									<td><%=user.getPlace() %></td>
								</tr>
								
								<tr>
									<td align="left">Work place / College / Organization</td>
									<td><%=user.getWorkplace() %></td>
								</tr>
								
								<tr>
									<td align="left">Date of Birth</td>
									<td><%=user.getDob() %></td>
								</tr>
								
								<tr>
									<td align="left">Mobile</td>
									<td><%=user.getMobile() %></td>
								</tr>
							
								
								<tr>
									<td align="left">Gender</td>
									<td><%=user.getGender() %></td>
								</tr>
							
								<tr>
									<td align="left">Email</td>
									<td><%=user.getEmail() %></td>
								</tr>
								
							</table>
			            
			            </div>
			        </div>
			        
			        
			        <br><br><br>
	
	
			<div class="w3-container">
			
				<div>
					<h3>Friends  <%if(searchUserFriendList.size() > 0){ %><%=searchUserFriendList.size()%><%} %>
					<% if(mutualFriendsList.size() > 0){out.print("<i class='w3-small'>("+mutualFriendsList.size()+" mutual friends)</i>");}%>
					</h3>
						
				</div>
					
					<%
					
						if(searchUserFriendList.isEmpty())
						{
							out.print("<br>Currently you havn't any friends!");	
						}
						else
						{
							if(!mutualFriendsList.isEmpty())
							{
								// This is for Display Mutual Friends
								out.print("<div class='w3-container'>");					
								for(int i = 0; i < mutualFriendsList.size();i++)
								{
									
									for(int j=0; j < 2; j++)
									{
										if(i < mutualFriendsList.size())
										{
											out.print("<div class='w3-half' style='padding: 5px;'>");
											out.print("<div class='w3-rest w3-padding w3-border w3-white'><img src="+mutualFriendsList.get(i).getImage_path()+" alt='Avatar' class='w3-left w3-circle w3-margin-right' style='width:45px'>");
											out.print("<span style=\"cursor: pointer;\" onclick='viewUser("+mutualFriendsList.get(i).getId()+")'>"+mutualFriendsList.get(i).getFirst_name()+" "+mutualFriendsList.get(i).getLast_name()+"</span>");
											out.print("</div></div>");
			
										}	
										i++;
									}
									i--;
									out.print("<br>");
								}
								out.print("</div>");
								
							}
							

							// This is for non mutual friends
							out.print("<div class='w3-container'><hr class='w3-border-grey'>");
							for(int i = 0; i < searchUserFriendList.size();i++)
							{
								
								for(int j=0; j < 2; j++)
								{
									if(i < searchUserFriendList.size())
									{
										out.print("<div class='w3-half' style='padding: 5px;'>");
										out.print("<div class='w3-rest w3-padding w3-border w3-white'><img src="+searchUserFriendList.get(i).getImage_path()+" alt='Avatar' class='w3-left w3-circle w3-margin-right' style='width:45px'>");
										if(searchUserFriendList.get(i).getId() == loggedInUser.getId())
										{
											out.print("<span>"+searchUserFriendList.get(i).getFirst_name()+" "+searchUserFriendList.get(i).getLast_name()+"</span>");											
										}
										else
										{
											out.print("<span style=\"cursor: pointer;\" onclick='viewUser("+searchUserFriendList.get(i).getId()+")'>"+searchUserFriendList.get(i).getFirst_name()+" "+searchUserFriendList.get(i).getLast_name()+"</span>");	
										}
										
										out.print("</div></div>");
		
									}	
									i++;
								}
								i--;
								out.print("<br>");
							}
							out.print("</div>");

						}
					%>	
						
					
			
			</div>
			        
			        
	    </div> 
	        
	   <form action="ViewUser" method="post" id="viewUserForm">
			<input type="hidden" name="userId" id="viewUserId">
	   </form> 
	        
	    
	        
	    <div class="w3-half w3-padding">
	     	<h3>Posts</h3>  
	     	
	  <%
	        	if(!userPostList.isEmpty())
	        	{
	    			for(int i = 0 ; i < userPostList.size();i++)
	    			{
	    				Post post = userPostList.get(i);
	    				
	    				
	  %>
	  					
				   			<div class="w3-border w3-round w3-white">
				            <div class="w3-container w3-padding-16">
	  
		    					<img src="<%=user.getImage_path() %>" alt="Avatar" class="w3-left w3-circle w3-margin-right" style="width:40px">
						        <span class="w3-right w3-opacity"><%=post.getPost_timestamp() %></span>
						        <h4><%=user.getFirst_name()+" "+user.getLast_name() %></h4>
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
	        						<video width="100%" controls>
				  						<source src="<%=post.getPost_url() %>" type="<%=post.getPost_type()%>">
									</video>
	        					</div>
	<%
							}	
	  
	%>
								<i class="fa fa-heart" style="font-size:20px; color: red;"></i>&nbsp;<%=post.getPost_likes() %>	
										
					        </div>
	          				</div>  
					        <br>
	  <%     
	    				
	    			}
	        	}
	        	else
	        	{
	  %>
	  						<br>No posts available!  
	  <%
	        	}
	  %> 
	        
	        
		</div>
        
        <br>
      </div>

		<%
			String msg = (String) request.getAttribute("msg");
		
			if(msg != null)
			{
				out.print("<h3>"+msg+"</h3>");
			}
		%>
      </div>


    <!-- End Middle Column -->
    </div>



    <div class="w3-col m1">   <!-- Right Column -->
      &nbsp;
    </div>    <!-- End Right Column -->



  </div>    <!-- End Grid -->
</div>    <!-- End Page Container -->


<br>


<!-- Footer -->

	<footer class="w3-container" style="text-align: center;">
		<p style="font-size: 12px;">The Social Network 2018</p>
	</footer>
	



<!-- ===================================================== End of page content ================================================= -->




<script>
// Accordion
function myFunction(id) {
    var x = document.getElementById(id);
    if (x.className.indexOf("w3-show") == -1) {
        x.className += " w3-show";
        x.previousElementSibling.className += " w3-theme-d1";
    } else {
        x.className = x.className.replace("w3-show", "");
        x.previousElementSibling.className =
        x.previousElementSibling.className.replace(" w3-theme-d1", "");
    }
}

// Used to toggle the menu on smaller screens when clicking on the menu button
function openNav() {
    var x = document.getElementById("navDemo");
    if (x.className.indexOf("w3-show") == -1) {
        x.className += " w3-show";
    } else {
        x.className = x.className.replace(" w3-show", "");
    }
}
</script>




</body>
</html>
