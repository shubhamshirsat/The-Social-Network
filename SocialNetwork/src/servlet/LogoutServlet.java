package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bl.BusinessLogic;
import dto.User;

/**
 * Servlet implementation class LogoutServlet
 */
public class LogoutServlet extends HttpServlet 
{
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
			HttpSession session = request.getSession();
			BusinessLogic businessLogic = new BusinessLogic();
			User user = (User) session.getAttribute("user");
			businessLogic.logout(user.getId());					// mark user as offline
			user = null;		
			session.removeAttribute("user");
			session.invalidate();		
			response.sendRedirect("Signin");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
			HttpSession session = request.getSession();
			session.removeAttribute("user");
			session.invalidate();
			
			response.sendRedirect("Signin");
	}

}
