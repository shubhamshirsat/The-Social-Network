<%@page import="dto.PostNotification"%>
<%@page import="dto.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
	response.setHeader("Cache-Control", "no-cache, no-store, must revalidate");	// HTPP 1.1
	response.setHeader("Pragma", "no-cache");	// HTTP 1.0
	response.setHeader("Expires", "0");		// Proxies

	User user = (User) session.getAttribute("user");
	
	if(user == null)
	{
		response.sendRedirect("SignIn");
	}
	
	String requestFrom = (String) request.getAttribute("requestFrom");
	String about = "";
	String profession = "";
	String place = "";
	String workplace = "";
	String cover = "";

	
	if(user.getAbout() != null)
	{
		about = user.getAbout();
	}
	
	if(user.getProfession() != null)
	{
		profession = user.getProfession();
	}
	
	if(user.getPlace() != null)
	{
		place = user.getPlace();
	}
	
	if(user.getWorkplace() != null)
	{
		workplace = user.getWorkplace();
	}
	
	if(user.getCover_image() != null)
	{
		cover = user.getCover_image();
	}
	
	
	ArrayList<Post> postList = (ArrayList<Post>) session.getAttribute("postList");
	ArrayList<User> friendList = (ArrayList<User>) session.getAttribute("friendList");
	ArrayList<User> receivedRequestList = (ArrayList<User>) session.getAttribute("receivedRequestList");
	ArrayList<PostNotification> postNotificationList = (ArrayList<PostNotification>) session.getAttribute("postNotificationList");
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

	
	<script type="text/javascript" src="jquery-1.10.2.min.js"></script>

<style>
html,body,h1,h2,h3,h4,h5 {font-family: "Open Sans", sans-serif}
a{
text-decoration: none;
}
</style>



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


<script src="jquery-1.10.2.min.js"></script>
<script type="text/javascript">
function showProfileImage(input)													// Called from profile.jsp 
{																		
 		if (input.files && input.files[0]) 
		{
	        var reader = new FileReader();
	        reader.onload = function (e) 									// Displays selected image to be set as profile image
	        {
	            $('#profileImage')
	                .attr('src', e.target.result);
	        };
	        reader.readAsDataURL(input.files[0]);
	    }	
}



function showCoverImage(input)													// Called from profile.jsp 
{	
	if (input.files && input.files[0]) 
	{
        var reader = new FileReader();
        reader.onload = function (e) 									// Displays selected image to be set as profile image
        {
        	document.getElementById('cover').style.backgroundImage = "url("+e.target.result+")";
        };
        reader.readAsDataURL(input.files[0]);
    }	
	
}




function check(type)
{
	
	document.getElementById("profileUpdateForm").submit(); 

}

function removeProfileImage()
{
	
	document.getElementById('profileImage').src = 'Images/Male/avatar2.png';
	document.getElementById('removeButton').style.display = 'none';
	document.getElementById('isChanged').value = '0';
}



function viewUser(userid)			/* View friends profile*/
{
	document.getElementById('viewUserId').value = userid;
	document.getElementById('viewUserForm').submit();
	
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

<body class="w3-theme-l5 w3-animate-right">

<!-- Navbar -->
<!--##### Navbar #####--> 
		
		<div class="w3-top">
			  <div class="w3-bar w3-theme-d5 w3-padding">
				   <div class="w3-third w3-padding">
				  		&nbsp;Hi! <a href="Profile" style="text-decoration: none;"><%=user.getFirst_name() %></a>
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
								      							      			
								      			out.print("<hr><a href='#' class='w3-text-blue'>"+postNotificationList.get(i).getLikeByUserFirstName()+" "+postNotificationList.get(i).getLikeByUserLastName()+"</a> likes your post<br>");
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










<div class="w3-container w3-content" style="max-width:1400px;margin-top:80px">    <!-- Page Container -->

  <div class="w3-row">    <!-- The Grid -->

      <div class="w3-col m1">   <!--Start Left Column -->
        &nbsp;
      </div>  <!-- End Left Column -->


<!-- Middle Column -->

    <div class="w3-col m10">
	
	<form id="profileUpdateForm" action="Profile" method="post" enctype="multipart/form-data">     	<!-- Profile Update Form -->
    
      <div id="cover" class="w3-container w3-border w3-white w3-round w3-margin w3-padding" style="background-image: url(<%=cover%>)"><br>
 		

<!-- #############  FILE DIALOGUE FOR UPLOADING IMAGE ############# -->
					
		 
        	
        	  <div class="w3-rest w3-margin">
            		
	          		<input id="imageUpload" type="file" name="profileImage" style="visibility: hidden;" oninput="showProfileImage(this);" required>
	          		<input type="hidden" name="isChanged" id="isChanged" value="1">
	          		
	          		<input type="hidden" name="requestFrom" value="<%=requestFrom%>"> 
	      
	          			<a href="#">
			          		<img src="<%=user.getImage_path() %>" id="profileImage" alt="Avatar" class="w3-border w3-left w3-margin-right" style="max-width: 20%; width: 20%;">
			  			</a>
				        <script>
				            $("#profileImage").on("click", function() {
				                $("#imageUpload").trigger("click");
				            });
				        </script>
			  	
		          		<b><h2 class = "w3-text-white"><%=user.getFirst_name()+" "+user.getLast_name() %></h2></b><br>
          		</div>
          
          		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          		<!-- <input type="submit" id="updateButton" value="Update" style="border: none; visibility: hidden;">&nbsp; -->
          		<%
          			if(!user.getImage_path().contains("Images/Male/avatar") && !user.getImage_path().contains("Images/Female/avatar"))
          			{
          				out.println("<button class='w3-theme-d5' id='removeButton' style='border: none;' onclick='removeProfileImage()'>Remove</button>");		
          			}
          		%>
          		
	     
          
<!-- #################################################################### -->

		<input type="file" id="coverUpload" name="coverUpload" style="visibility: hidden;" oninput="showCoverImage(this);">
       <i class="fa fa-camera" style="font-size:24px; float: right; cursor: pointer;" id="coverImage"></i>
       <script>
		            $("#coverImage").on("click", function() {
		               $("#coverUpload").trigger("click");
		            });
		</script>
         
      </div>




		<%
     		if(requestFrom.equals("signup"))
     		{
     	%>
				<div class="w3-center">Hi! <%=user.getFirst_name() %>, Please complete your profile ...</div> 			
     	<%
     		}
     	%>



  <div class="w3-container w3-margin">

        &nbsp;

	   <div class="w3-half w3-padding">
	   
	   <h3>About</h3>  
	      
	     
		<div class="w3-border w3-round w3-white">
	            <div class="w3-container w3-padding-16">		
        		       		
        		<table style="border: 0px solid black;" cellspacing="10px;">
        		
        			<tr>
        				<td>Status</td>
        				<td><textarea rows="2" cols="30" name="about" class="w3-opacity w3-border w3-padding w3-input"><%=about%></textarea></td>
	        		</tr>
        		
        			<tr>
	        			<td>Profession</td>
        				<td><input type="text" name="profession" value="<%=profession%>" class="w3-opacity w3-border w3-padding w3-input"></td>
	        		</tr>
        		
	        		<tr>
        				<td>Place</td>
	        			<td><input type="text" name="place" value="<%=place%>" class="w3-opacity w3-border w3-padding w3-input"></td>
	        		</tr>
	        			
	        		<tr>
	        			<td>Workplace / College / Organization</td>
	        			<td><input type="text" name="workplace" value="<%=workplace%>" class="w3-opacity w3-border w3-padding w3-input"></td>
	        		</tr>
	        		
	        		<tr>
        				<td>Date Of Birth</td>
	        			<td><input type="date" name="dob" value="<%=user.getDob()%>" class="w3-opacity w3-border w3-padding w3-input"></td>
	        		</tr>
	        		
	        		<tr>
        				<td>Mobile</td>
	        			<td><input type="text" name="mobile" value="<%=user.getMobile() %>" class="w3-opacity w3-border w3-padding w3-input"></td>
	        		</tr>

					<tr>
        				<td>Gender</td>
	        			<td><input type="text" value="<%=user.getGender()%>" class="w3-opacity w3-border w3-padding w3-input" readonly></td>
	        		</tr>
	        		
	        		<tr>
        				<td>Email</td>
	        			<td><input type="text" value="<%=user.getEmail()%>" class="w3-opacity w3-border w3-padding w3-input" readonly></td>
	        		</tr>
	        		
	        	</table>
		 </div>
		</div>
		</form>
		<br>
		
		<%
		
				if(requestFrom.equals("signup"))
				{
		%>
					<button class="w3-button w3-theme-d5 w3-margin-bottom w3-right" onclick="check('signup')">Continue</button>
		<%
				}
				else if(requestFrom.equals("profile_update"))
				{
		%>
					<button class="w3-button w3-theme-d5 w3-margin-bottom w3-right" onclick="check('profile_update')">Save Changes</button>
		<%	
				}
		%>
	
			<br><br><br>
	
	
			<div>
			
				<div><h3>Friends  <%if(friendList.size() > 0){ %><%=friendList.size()%><%} %></h3></div>
					
					<%
						if(friendList.isEmpty())
						{
							out.print("<br>Currently you havn't any friends!");	
						}
						else
						{
					
							for(int i = 0; i < friendList.size();i++)
							{
								
								for(int j=0; j < 2; j++)
								{
									if(i < friendList.size())
									{
										out.print("<div class='w3-half' style='padding: 5px;'>");
										out.print("<div class='w3-rest w3-padding w3-border w3-white'><img src="+friendList.get(i).getImage_path()+" alt='Avatar' class='w3-left w3-circle w3-margin-right' style='width:45px'>");
										out.print("<span style=\"cursor: pointer;\" onclick='viewUser("+friendList.get(i).getId()+")' style='text-decoration: none'>"+friendList.get(i).getFirst_name()+" "+friendList.get(i).getLast_name()+"</span></div>");
										out.print("</div>");
		
									}	
									i++;
								}
								i--;
								out.print("<br>");
							}
						}
					%>	
						
					</table>
			
			</div>
		
		
		<form action="ViewUser" method="post" id="viewUserForm">
			<input type="hidden" name="userId" id="viewUserId">
		</form>
			
			
		&nbsp;<br><br><br><br>	
		
		
		<!-- Next content should go from here -->
			
	
		
	   </div>
	

	
	
	
	
	
	
	<!--  #########################################	RIGHT HAND SIDE COLUMN	#########################################   -->
	
	
	
	      <div class="w3-half w3-padding">
	     <br><br>
	      
	        <div class="w3-border w3-round w3-white">
	            <div class="w3-container w3-padding-16">
	     	
	            
	            		<input type="text" class="w3-opacity w3-border w3-padding w3-input" id="post" placeholder="What's on your mind?"><hr>
	            		 <button type="submit" class="w3-button w3-theme-d5" onclick="post('<%=user.getId()%>')"><i class="fa fa-pencil"></i> &nbsp;Post</button> 
	            
	                    
	            </div>
	          </div>   
	          
	                  
	            
	  <%
	    			for(int i = 0 ; i < postList.size();i++)
	    			{
	    				Post post = postList.get(i);
	    				
	    				if(post.getUser_id() == user.getId())
	    				{
	  %>
	  						<br>
				   			<div class="w3-border w3-round w3-white">
				            <div class="w3-container w3-padding-16">
	  
		    					<img src="<%=post.getImage_path() %>" alt="Avatar" class="w3-left w3-circle w3-margin-right" style="width:40px">
						        <span class="w3-right w3-opacity"><%=post.getPost_timestamp() %></span>
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
					        
	  <%     
	    				}
	    			}
	  	          		
	  %> 
	     
	                    
	               
	            
	          
		</div>
        
        <br>
          

      </div>
      
      

	
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
