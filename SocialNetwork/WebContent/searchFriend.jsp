<%@page import="dto.User"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

	<link rel="stylesheet" href="w3.css">
</head>
<body class="w3-padding-48">
	<table>
<%

		response.setHeader("Cache-Control", "no-cache, no-store, must revalidate");	// HTPP 1.1
		response.setHeader("Pragma", "no-cache");	// HTTP 1.0
		response.setHeader("Expires", "0");		// Proxies


		ArrayList<User> friendList = (ArrayList<User>) request.getAttribute("userList");
		User user = null;
		if(!friendList.isEmpty())
		{
			for(int i=0; i < friendList.size(); i++)
			{
					user = (User) friendList.get(i);
%>
					<tr>
						<td rowspan="2"><img src="<%=friendList.get(i).getImage_path() %>" alt="Avatar" class="w3-left w3-circle w3-margin-right" style="width:35px"></td>
						<td><a href="#" style="text-decoration: none;" onclick="viewUser('<%=user.getId()%>')"><%= user.getFirst_name()+" "+user.getLast_name()%></a></td>
					</tr>
					<tr>
						<td><%= user.getProfession()%></td>
					</tr>
<%
			}
		}
		else
		{
			
			out.print("<br><span class='w3-small'>No search found !</span>");
		}
%>
</table>

<form action="ViewUser" method="post" id="viewUserForm">
<input type="hidden" name="userId" id="viewUserId">
</form>

</body>
</html>