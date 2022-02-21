package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bl.BusinessLogic;
import dto.User;

/**
 * Servlet implementation class RequestServlet
 */
public class RequestServlet extends HttpServlet
{
    public RequestServlet() 
    {
    
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("friendRequests.jsp");
		requestDispatcher.forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	
			
			System.out.println(request.getParameter("requestType"));
			System.out.println(request.getParameter("senderID"));
			System.out.println(request.getParameter("receiverID"));
			
			BusinessLogic businessLogic = new BusinessLogic();
			HttpSession session = request.getSession();
	
			long requestType = Long.parseLong(request.getParameter("requestType")); 
			long senderID = Long.parseLong(request.getParameter("senderID"));
			long receiverID = Long.parseLong(request.getParameter("receiverID"));
			
			
			if(requestType == 1)					// when request type = 1 then it is send request
			{
				if(businessLogic.sendRequest(senderID, receiverID))					//  insert an entry of request to the request table
				{
					User user = businessLogic.getUser(receiverID);					// retrive the user from database
					request.setAttribute("viewUser", user);
					
					session.setAttribute("sentRequestList", businessLogic.getListofSentRequest(senderID));
					request.setAttribute("userPostList", businessLogic.getPostsSpecificToUser(user.getId()));
					request.setAttribute("searchUserFriendList", businessLogic.getFriendList(user.getId()));
					request.setAttribute("mutualFriendsList", businessLogic.getMutualFriendsList(senderID, receiverID));
				}
				else
				{
					request.setAttribute("msg", "Error occured while sending friend request!");
				}
				
				RequestDispatcher requestDispatcher = request.getRequestDispatcher("viewUser.jsp");
				requestDispatcher.forward(request, response);
			}

			else if(requestType == 2)				// when request type = 2 then it is accept request
			{
					session.setAttribute("friendList", businessLogic.acceptFriendRequest(senderID, receiverID));
					
					ArrayList<User> receivedRequestList = (ArrayList<User>) session.getAttribute("receivedRequestList");
					
					for(int i=0; i<receivedRequestList.size(); i++)
					{
						if(receivedRequestList.get(i).getId() == senderID)
						{
							receivedRequestList.remove(i);
						}
					}
					
					RequestDispatcher requestDispatcher = request.getRequestDispatcher("home.jsp");
					requestDispatcher.forward(request, response);
					
			}
			else if(requestType == 3)				// when request type = 3 then it is decline request
			{
					if(businessLogic.rejectFriendRequest(senderID, receiverID))
					{
						ArrayList<User> receivedRequestList = (ArrayList<User>) session.getAttribute("receivedRequestList");
						
						for(int i=0; i<receivedRequestList.size(); i++)
						{
							if(receivedRequestList.get(i).getId() == senderID)
							{
								receivedRequestList.remove(i);
							}
						}
					}
					
					RequestDispatcher requestDispatcher = request.getRequestDispatcher("home.jsp");
					requestDispatcher.forward(request, response);
			}
			
		
	}

}
