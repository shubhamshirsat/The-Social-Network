	package servlet;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bl.BusinessLogic;
import dto.Post;
import dto.User;
public class SigninServlet extends HttpServlet 
{

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		ServletContext context = getServletContext();
	
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp");
		requestDispatcher.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String page = "index.jsp";
		
		
		BusinessLogic businessLogic = new BusinessLogic();
		User user = businessLogic.logIn(username, password);
		
		
		if(user != null)
		{			
			// Get the session object and set the attributes in object
			
			HttpSession session = request.getSession();
			
			session.setAttribute("user", user);
			session.setAttribute("friendList", businessLogic.getFriendList(user.getId()));
			session.setAttribute("postList", businessLogic.getPosts(user.getId()));
			session.setAttribute("sentRequestList", businessLogic.getListofSentRequest(user.getId()));
			session.setAttribute("receivedRequestList", businessLogic.getListofReceivedRequest(user.getId()));
			session.setAttribute("postNotificationList", businessLogic.getPostNotification(user.getId()));
			
			page = "home.jsp";
		}
		else
		{
			request.setAttribute("msg", "Invalid username or password !");
		}
				
			
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(page);
		requestDispatcher.forward(request, response);
		
	}
	

}
