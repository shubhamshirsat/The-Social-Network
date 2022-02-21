<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.User"%> 

   <%
   ArrayList<User> receivedRequestList = (ArrayList<User>) session.getAttribute("receivedRequestList");
	User user = (User) session.getAttribute("user");
   %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Friend Requests</title>
</head>
<body>
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
</body>
</html>