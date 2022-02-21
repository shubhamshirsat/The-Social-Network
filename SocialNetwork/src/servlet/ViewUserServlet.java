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

/**
 * Servlet implementation class ViewUserServlet
 */
public class ViewUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String viewUserId = request.getParameter("userId");
		
		HttpSession session = request.getSession();
		BusinessLogic businessLogic = new BusinessLogic();
		
		User user = businessLogic.getUser(Long.parseLong(viewUserId));		// get information of searched user
		User logged_in_user = (User) session.getAttribute("user");				// get logged in user from session
		
		if(user != null)
		{
			request.setAttribute("viewUser", user);
			request.setAttribute("userPostList", businessLogic.getPostsSpecificToUser(user.getId()));
			request.setAttribute("searchUserFriendList", businessLogic.getFriendList(user.getId()));
			request.setAttribute("mutualFriendsList", businessLogic.getMutualFriendsList(logged_in_user.getId(), user.getId()));
			
		}
		else
		{
			request.setAttribute("msg", "Unable to access user profile");
		}
		
		
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("viewUser.jsp");
		requestDispatcher.forward(request, response);
		
	}

}
