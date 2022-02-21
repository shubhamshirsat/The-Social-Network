package servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bl.BusinessLogic;
import dto.Post;
import dto.User;

public class ActivityServlet extends HttpServlet 
{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession();
		
		int activity = Integer.parseInt(request.getParameter("activity"));
		long userid = Long.parseLong(request.getParameter("userid"));
		
		BusinessLogic logic = new BusinessLogic();
		
		if(activity == 1)				// Acitvity 1 is for searching friend
		{
			String keyword =  request.getParameter("keyword");
			String key;
			
			if(keyword.equals("")||keyword.equals(" "))
			{
				key = "\t";
			}	
			else
			{
				key = keyword;
			}
			
	
			ArrayList<User> friendList = logic.getUserList(userid,key);
			
			if(friendList != null)
			{
				request.setAttribute("userList", friendList);
			}
					
			
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("searchFriend.jsp");
			requestDispatcher.forward(request, response);
			
		}
		else if(activity == 2)			// Acitivity 2 is for updating likes hitted to the post
		{
			long postUserid = Long.parseLong(request.getParameter("postUserid"));
			Timestamp timestamp = Timestamp.valueOf(request.getParameter("postTimestamp"));
			
			System.out.println(userid);
			System.out.println(postUserid);
			System.out.println(timestamp);
			
			
			if(!logic.hitLikeToPost(userid, postUserid, timestamp, session))
			{
				System.out.println("Error occured while updating post like");
			}
			
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("newsFeed.jsp");
			requestDispatcher.forward(request, response);
			
		}
		
		
	}

}
