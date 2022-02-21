<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="dto.PostNotification"%>
<%@page import="java.util.ArrayList"%>
<%
ArrayList<PostNotification> postNotificationList = (ArrayList<PostNotification>) session.getAttribute("postNotificationList");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
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

</body>
</html>