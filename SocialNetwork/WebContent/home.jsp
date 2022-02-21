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

	<title>The Social Network</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="w3.css">
<%--  	<link rel="stylesheet" href="w3-theme-blue-grey.css"> --%>
	<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
	<link rel="stylesheet" href="font-awesome.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">	
	
	<link rel="stylesheet" href="w3-theme-blue-grey.css">
	

	
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

a{
text-decoration: none;
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

			function loadNotifications()
			{
				var xhttp = new XMLHttpRequest();
				  xhttp.onreadystatechange = function() 
				  {
					   if (this.readyState == 4 && this.status == 200) 
					   {
					      document.getElementById("notifications").innerHTML = xhttp.responseText;
					   }
				  };  
				  xhttp.open("GET", "Notification", true);
				  xhttp.send();
			}
			
			function loadFriendRequests()
			{
				var xhttp = new XMLHttpRequest();
				  xhttp.onreadystatechange = function() 
				  {
					   if (this.readyState == 4 && this.status == 200) 
					   {
					      document.getElementById("friendRequests").innerHTML = xhttp.responseText;
					   }
				  };  
				  xhttp.open("GET", "Request", true);
				  xhttp.send();
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
			
			
			function cancelSelection()
			{
				document.getElementById("postImage").value="";
				document.getElementById("imageSection").style = "display: none;";
			}
			
	</script>
	

<body class="w3-theme-l5 w3-animate-top" onload="loadPages()">

		<!--##### Navbar #####--> 
		
		<div class="w3-top">
			  <div class="w3-bar w3-theme-d5 w3-padding">
				   <div class="w3-third w3-padding">
				  		&nbsp;Hi! <a href="Profile" style="text-decoration: none;"><%=user.getFirst_name() %></a>
				  		&nbsp;|&nbsp;<a href="Home" style="text-decoration: none;">Home</a>
				   </div>
			    <div class="w3-third">
					  <input type="search" id="s" class="w3-third w3-bar-item w3-input" style="width: 100%; border: none;" name="keyword" placeholder="Search Friend" onkeyup="search('<%=user.getId()%>')">
				      <div id="results" class="w3-padding" style="position:absolute; top:50px; left: 34%;">
						</div>	
				      
					  <form action="Request" method="post" id="requestForm">
					      <input type="hidden" name="requestType" id="reqType">
					      <input type="hidden" name="senderID" id="send">
					      <input type="hidden" name="receiverID" id="receive">
					  </form>
	  			</div>
			  
			  	<div class="w3-third">
			  	  <div class="w3-dropdown-hover w3-hide-small">
				      <button onmouseover="loadFriendRequests()" class="w3-button w3-padding"><i class="fa fa-user"></i><span class="w3-badge w3-right w3-small w3-green"><% if(receivedRequestList.size() != 0){out.print(receivedRequestList.size());} %></span></button>     
					    
					    <div id="friendRequests" class="w3-dropdown-content w3-card-4 w3-bar-block w3-animate-zoom" style="width:300px; max-height: 500px; overflow: auto;">
						   
					      </div>
			  	   </div> 
			  
		  
			  	    <!-- Notifications -->	
					    
					 <div class="w3-dropdown-hover w3-hide-small">
					    <button onmouseover="loadNotifications()" class="w3-button w3-padding" title="Notifications"><i class="fa fa-bell"></i><span class="w3-badge w3-right w3-small w3-green"><%if(postNotificationList.size() != 0){out.print(postNotificationList.size());} %></span></button>
					         
						     <div id="notifications" class="w3-animate-zoom w3-dropdown-content w3-card-4 w3-bar-block<%if(!postNotificationList.isEmpty()){out.println(" w3-padding");} %>" style="width:300px; max-height: 500px; overflow: auto;">
						     
						      <br>
						    </div>
				     </div>
				     
				     <form action="ViewUser" method="post" id="viewUserForm">
						<input type="hidden" name="userId" id="viewUserId">
					</form>
					
					<!-- 
						  <button class="w3-button w3-padding" title="Notifications" onclick="viewNote()"><i class="fa fa-bell"></i><span class="w3-badge w3-right w3-small w3-green"></span></button>
							<div id="note" class="w3-padding" style="display: none;">
								hi&nbsp;<br>
								hi&nbsp;<br>
								hi&nbsp;<br>
							</div>
							
							<script>
									function viewNote()
									{
										var x = document.getElementById('note');
										if(x.style.display === 'none')
										{
											x.style = "position: absolute; width: 30%; display: block; background-color: white; border: 1px solid black";	
										}
										else
										{
											x.style.display = "none";
										}
									}
							</script>
			   -->
			      	<a href="Logout" class="w3-bar-item w3-button w3-hide-small w3-right w3-padding-large w3-hover-white" title="My Account">Logout</a>
			      </div>
			  </div>
		</div>
		
		<!-- ########## -->


		<!-- yfghfhj -->

		<!--##### Page Container #####-->
		<div class="w3-container w3-content" style="max-width:1400px;margin-top:80px">
		    
			  <!--###### The Grid ######-->
			  <div class="w3-row">
			  
				    <!--###### Left Column ######-->
				    <div class="w3-col m2">
				    
					      <!--###### Profile ######-->
					      <div class="w3-white w3-border w3-round">
						        <div class="w3-container">
							         <h4 class="w3-center"><a href="Profile" style="text-decoration: none;"><%=user.getFirst_name()+" "+user.getLast_name() %></a></h4>
							         <p class="w3-center"><img src="<%=user.getImage_path() %>" class="w3-circle" style="height:106px;width:106px" alt="Avatar"></p>
							         <p><i class="fa fa-address-card-o fa-fw w3-margin-right w3-text-theme"></i><%=user.getProfession() %></p>
							         <p><i class="fa fa-pencil fa-fw w3-margin-right w3-text-theme"></i><%=user.getAbout() %></p>
							         <p><i class="fa fa-home fa-fw w3-margin-right w3-text-theme"></i><%=user.getPlace() %></p>
						        </div>
					      </div>
					    
				    	  <br>
				    	  
				    	   <!-- Alert Box -->
					      <div class="w3-container w3-display-container w3-round w3-theme-l4 w3-border w3-theme-border w3-margin-bottom w3-hide-small">
						        <span onclick="this.parentElement.style.display='none'" class="w3-button w3-theme-l3 w3-display-topright">
						          <i class="fa fa-remove"></i>
						        </span>
						        <p><strong>Events!</strong></p>
						        <p>No Events Available!</p>
					      </div>
				    	  
				    </div>
				    <!--###### End Left Column ######-->
			 		  
			        <!--###### Middle Column ######--> 
                    <div class="w3-col m8">
				      	<div class="w3-row">
				        	<div class="w3-container">		<!-- container -->
				          		<div class="w3-col m8 w3-border w3-round w3-white">
				            		<div class="w3-container w3-padding-16">    		
				            	 		<form action="#" method="post" id="postForm">           		        						            	            		
				            	 			<input type="file" name="postImage" id="postImage" oninput="showImage(this);" style="visibility: hidden;">	
						            		<a href="#" class="w3-left" title="Post Image"><i id="imageFile" class="fa fa-picture-o" style="font-size:24px"></i></a><br>
						            		<script>
								 	            	$("#imageFile").on("click", function() {
									 	                $("#postImage").trigger("click");
								 	            	});
								 	        </script>
							        		<input type="text" name="postText" class="w3-opacity w3-padding w3-input" style="border-left: none; border-right: none; border-top: none;" id="post"  placeholder="What's on your mind?"><br>
				            	 		</form>	 
										<button type="button" class="w3-button w3-theme-d5 w3-right" onclick="post()"><i class="fa fa-pencil"></i> &nbsp;Post</button><br>						
										<div id="imageSection" class="w3-threequarter" style="display: none;">
											<span onclick="cancelSelection()" style="cursor: pointer;">X</span>
											<img src="" id="pic" style="max-width: 100%;">
										</div>
									</div>
				          		</div>
				          			
				          		<!-- ###### Advertising ###### -->			
				          		<div class="w3-col m4" style="padding-left: 8px;">
							  			<div  class=" w3-white w3-round w3-border w3-padding w3-leftbar w3-light-grey" style="max-height: 140px; overflow: auto;">
								  			<p id="quote"></p>
											<i id="author"></i>
											
											<script type="dd961b1c91a7e2597d39ff8b-text/javascript">
												function parseQuote(response)
												{
													document.getElementById("quote").innerHTML = response.quoteText;
													document.getElementById("author").innerHTML = response.quoteAuthor;
												}
											</script>
										<script type="dd961b1c91a7e2597d39ff8b-text/javascript" src="https://api.forismatic.com/api/1.0/?method=getQuote&format=jsonp&jsonp=parseQuote&lang=en"></script>
										<script src="https://ajax.cloudflare.com/cdn-cgi/scripts/2448a7bd/cloudflare-static/rocket-loader.min.js" data-cf-nonce="dd961b1c91a7e2597d39ff8b-" defer=""></script>
											
							  			
							  			</div>
							  	</div>
				          						        
				          						          		
				          		<!--###### NEWS FEED  ######-->
				          		<div class="w3-col m8" id="newsFeed">
	                    	
	                    		<!-- ##### POSTS WILL BE SHOWN HERE ####### -->
				  			
				  				</div>
				  				
				          		
				          		<!-- ###### SUGGESTIONS ###### -->
				          		<div class="w3-col m4 w3-animate-opacity" style="padding-left: 8px;">
							  			<div  class=" w3-white w3-border w3-round w3-padding w3-animate-top">      		
				                    		<div id="recommendations" class="w3-animate-opacity">
				                    		
				                    		</div>		                    				
							  			</div>
						  		</div> 
				          		
				          		
				          	
				  				
				  				
				        	</div>
				      	</div>
			      	</div>
			    	<!--###### End Middle Column ######-->
			    	
			    	 
			  			
			    
			    <!--###### Right Column ######-->
			    <div class="w3-col m2">
				      <div class="w3-border w3-round w3-center">
					        <div class="w3-container">
						          <p><strong>Conversations</strong></p>
						          	<table cellspacing="5">
						          	<%
											if(!friendList.isEmpty())
											{
																								
												for(int i=0; i < friendList.size(); i++)
												{
												
							%>
														<tr>
						        						<td><img src="<%=friendList.get(i).getImage_path() %>" alt="Avatar" class="w3-left w3-circle w3-margin-right" style="width:35px"></td>
							          					<td align="left"><a href="#" style="text-decoration: none;" onclick="openChatBox(<%=friendList.get(i).getId() %>,'<%=friendList.get(i).getFirst_name()%>','<%=friendList.get(i).getLast_name()%>')"><%=friendList.get(i).getFirst_name()+" "+friendList.get(i).getLast_name() %></a></td>
							          					</tr>
							<%					
														
												}												
											}
											else
											{
												
											}
						          	%>
						          	</table>
						          	<br>
					        </div>
				      </div>
				      <br>
			    </div>
				<!--###### End Right Column ######-->	    
			  
			  </div>
			  <!--###### End Grid ######-->
		
		</div>
		<!--###### End Page Container ######-->

	<br>



 <!--###### CHAT POP UP ######-->
    
		<div id="id01" class="w3-modal">
			    <div class="w3-modal-content w3-animate-right w3-card-4" style="width: 33%;">
				      <header class="w3-container w3-theme-d5">
				        <span onclick="terminate()" class="w3-button w3-display-topright">&times;</span>
				       	<span id="userName"></span>
				      </header>
				      <div class="w3-container" id="messagePanel" style="word-wrap: break-word; height: 400px; overflow: auto;">
				        
				        <!-- This chat panel -->
				        
				      </div>
				       
				        <div class="w3-row w3-padding w3-theme-l5">
				        	<div class="w3-col m10">
				        		    <input type="text" id="message" class="w3-input w3-border" style="border-radius: 20px;" placeholder="  Type a message">
				        	</div>
				        	<div class="w3-col m2">
				        			&nbsp;<button class="w3-button w3-circle w3-theme-l1" onclick="sendMessage()"><i style="font-size:15px" class="fa">&#xf1d8;</i></button>
				        	</div>
		       		  	</div>
		       		  	
			    </div>
		</div>




	<footer class="w3-container" style="text-align: center;">
		<p style="font-size: 12px;">The Social Network 2018</p>
	</footer>
	
	
		
 
	<script>
	
	var senderID = <%=user.getId()%>;							// Global Variables
	var receiverID;
	var auto_refresh;
	
	function openChatBox(friendID,firstName,lastName)
	{
			document.getElementById('id01').style.display='block';
			document.getElementById("userName").innerHTML = '<h6>'+firstName+' '+lastName+'</h6>';
			receiverID = friendID;
			var xhttp = new XMLHttpRequest();
		
			xhttp.onreadystatechange= function()
			{
				if(xhttp.readyState == 4 && xhttp.status == 200)
				{
					document.getElementById("messagePanel").innerHTML = xhttp.responseText;
					
					var div = document.getElementById("messagePanel");			// To get automatically scroll down.....
					div.scrollTop = div.scrollHeight;							
				}
			};
			
			xhttp.open("POST", "Chat", true);
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhttp.send('friendID='+friendID+'&activity=loadChats');
			
			 auto_refresh = setInterval(
					function ()
					{
					$('#messagePanel').load('Chat?friendID='+receiverID).fadeIn("slow");
					}, 3000); // refresh every 10000 milliseconds
	}
	
	
	function terminate()
	{
		document.getElementById('id01').style.display='none';
		
		clearInterval(auto_refresh);
	}
	
			// Accordion
			function myFunction(id) 
			{
			    var x = document.getElementById(id);
			    if (x.className.indexOf("w3-show") == -1) 
			    {
			        x.className += " w3-show";
			        x.previousElementSibling.className += " w3-theme-d1";
			    } 
			    else 
			    { 
			        x.className = x.className.replace("w3-show", "");
			        x.previousElementSibling.className = 
			        x.previousElementSibling.className.replace(" w3-theme-d1", "");
			    }
			}

			
			// Used to toggle the menu on smaller screens when clicking on the menu button
			function openNav() 
			{
			    var x = document.getElementById("navDemo");
			    if (x.className.indexOf("w3-show") == -1) 
			    {
			        x.className += " w3-show";
			    }
			    else 
			    { 
			        x.className = x.className.replace(" w3-show", "");
			    }
			}


			// Opens the chat box in middle of screen upon clicking on user's name on right hand side.
			
			
			
			
	</script>

	
		

</body>
</html> 
