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
 * Servlet implementation class ChatServlet
 */
public class ChatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		System.out.println("get request for chat received ...");
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		BusinessLogic businessLogic = new BusinessLogic();
		
		long friendID = Long.parseLong(request.getParameter("friendID"));
		request.setAttribute("messageList", businessLogic.getChatMessages(user.getId(), friendID));
		
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("chat.jsp");
		requestDispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		
		String activity = request.getParameter("activity");
	
		BusinessLogic businessLogic = new BusinessLogic();
		
		if(activity.equals("loadChats"))		// Loads chat box according to user
		{
			
			long friendID = Long.parseLong(request.getParameter("friendID"));
			request.setAttribute("messageList", businessLogic.getChatMessages(user.getId(), friendID));
			
		}
		else if(activity.equals("sendMessage"))		// sends messages to the intended user
		{
			long senderID = Long.parseLong(request.getParameter("senderID"));
			long receiverID = Long.parseLong(request.getParameter("receiverID"));
			String message = request.getParameter("message");
			
			request.setAttribute("messageList", businessLogic.saveAndRetriveChats(senderID, receiverID, message));
		}
				
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("chat.jsp");
		requestDispatcher.forward(request, response);
		
	}

}
