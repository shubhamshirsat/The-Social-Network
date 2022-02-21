package servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
import dto.PostNotification;
import dto.User;

/**
 * Servlet implementation class SignupServlet
 */
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignupServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp");
		requestDispatcher.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		User user = new User();
		
		user.setFirst_name(request.getParameter("firstName"));
		user.setLast_name(request.getParameter("lastName"));
		user.setEmail(request.getParameter("email"));
		user.setMobile(request.getParameter("mobile"));
		
		
		java.util.Date date = null;
		try 
		{
			date = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dob"));
			
		} 
		catch (ParseException e) 
		{
	
			e.printStackTrace();
		}
		
		user.setDob(new Date(date.getTime()));
		user.setGender(request.getParameter("gender"));
		user.setPassword(request.getParameter("password"));
		
				
		BusinessLogic logic = new BusinessLogic();
		String page = "index.jsp";
		
		HttpSession session = request.getSession();
		
		User savedUser = logic.saveUser(user);
		
		if(savedUser != null)
		{
			session.setAttribute("user", savedUser);
			session.setAttribute("friendList", new ArrayList<User>());		//#### Initially it should be empty list #########
			session.setAttribute("postList", new ArrayList<Post>());		//#### Initially it should be empty list #########
			session.setAttribute("sentRequestList", new ArrayList<User>());
			session.setAttribute("receivedRequestList", new ArrayList<User>());
			session.setAttribute("postNotificationList", new ArrayList<PostNotification>());
									
			ServletContext context = getServletContext();
						
			new File(context.getInitParameter("directoryPath")+savedUser.getId()).mkdir();			//create a new directory for each user to store the files.....		
			
			request.setAttribute("requestFrom", "signup");
			page = "profile.jsp";
		}
		else
		{
			request.setAttribute("msg", "Unable to create an account");
		}
		
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(page);
		requestDispatcher.forward(request, response);
		
	}

}
