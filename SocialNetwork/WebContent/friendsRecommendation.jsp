<%@page import="dto.RecommendedFriend"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
	response.setHeader("Cache-Control", "no-cache, no-store, must revalidate");	// HTPP 1.1
	response.setHeader("Pragma", "no-cache");	// HTTP 1.0
	response.setHeader("Expires", "0");		// Proxies

	ArrayList<RecommendedFriend> recommendedFriends = (ArrayList<RecommendedFriend>) session.getAttribute("recommendedFriends");

%>    

<!DOCTYPE html>
<html>
<head>

	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="w3.css">
	<link rel="stylesheet" href="w3-theme-blue-grey.css">
	<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
	<link rel="stylesheet" href="font-awesome.min.css">

<meta charset="ISO-8859-1">
<title>Recommended Friends For You</title>
</head>
<body class="w3-animate-top">

<%
			if(recommendedFriends.isEmpty())
			{
				out.print("<div class='w3-padding'>No Suggestions!<br><br><span class='w3-small'> You have no friend suggestion right now!</span></div>");
			}
			else
			{
				out.print("<p><h5>People you may know</h5></p>");
				for(int i=0; i < recommendedFriends.size(); i++)
				{
					RecommendedFriend recommendedFriend = recommendedFriends.get(i);
%>
 					<div class="w3-padding">
                   			<div class="w3-quarter"><img alt="Unavailable" src="<%=recommendedFriend.getImage_path() %>" class="w3-left w3-circle w3-margin-right" style="width:35px"></div>
                   			<div class="w3-rest">
                   				<a href="#" onclick="viewUser('<%=recommendedFriend.getUser_id() %>')" style="text-decoration: none;">
	                   				<%=recommendedFriend.getFirst_name()+" "+recommendedFriend.getLast_name() %>
	                   			</a><br>
	                   			<div class="w3-small w3-text-grey">
	                   				<%=recommendedFriend.getMutualFriends()+" "%>Mutual Friends
	                   			</div>
			           			<button style="border: none; align-self: center;" class="w3-border w3-ripple w3-round-large">Send Request</button>
		           			</div>
               		</div>
		   			
<%
				}
			}

%>

<form action="ViewUser" method="post" id="viewUserForm">
<input type="hidden" name="userId" id="viewUserId">
</form>
				                			     
</body>
</html>