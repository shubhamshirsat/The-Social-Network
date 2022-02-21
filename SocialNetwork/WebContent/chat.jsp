<%@page import="dto.User"%>
<%@page import="dto.Chat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	ArrayList<Chat> messageList = (ArrayList<Chat>) request.getAttribute("messageList");
	User user = (User) session.getAttribute("user");
	
	//response.setIntHeader("Refresh", 2);		// not working
%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>The Social Network</title>
<link rel="stylesheet" href="w3.css">
<link rel="stylesheet" href="w3-theme-blue-grey.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
<link rel="stylesheet" href="font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">









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


</head>
<body>

<div class="w3-container">

<%
		if(messageList.isEmpty())
		{
			
		}
		else
		{
			for(int i = 0; i < messageList.size(); i++)
			{
				Chat chat = messageList.get(i);
				
				if(chat.getSender_id() == user.getId())
				{
%>
					<div class="w3-panel w3-pale-green w3-threequarter w3-round-xlarge w3-right" style="word-wrap: break-word;">
						<%=chat.getMessage() %><br>
						<div class="w3-right w3-tiny">
						<%=chat.getTimestamp().toString().substring(0, 16) %>
						</div>
					</div>			
<%
				}
				else
				{
%>
					<div class="w3-panel w3-pale-blue w3-threequarter w3-round-xlarge w3-left" style="word-wrap: break-word;">
						<%=chat.getMessage() %><br>
						<div class="w3-right w3-tiny">
						<%=chat.getTimestamp().toString().substring(0, 16) %>
						</div>
					</div>
<%					
				}
				
				out.println("<br><br>");
			}
			
		}
%>	
		
			
	
</div>
	
	
	
</body>
</html>