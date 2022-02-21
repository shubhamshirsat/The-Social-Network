package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bl.BusinessLogic;
import dto.User;


public class FriendsRecommendationServlet extends HttpServlet 
{
		
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		BusinessLogic businessLogic = new BusinessLogic();
		session.setAttribute("recommendedFriends", businessLogic.getRecommendedFriendList(user));
		
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("friendsRecommendation.jsp");
		requestDispatcher.forward(request, response);
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	
	}

}
