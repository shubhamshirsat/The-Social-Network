package servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import bl.BusinessLogic;
import dto.Post;
import dto.User;

/**
 * Servlet implementation class ProfileServlet
 */
public class ProfileServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    public ProfileServlet() 
    {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		request.setAttribute("requestFrom", "profile_update");
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("profile.jsp");
		requestDispatcher.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
	
		String requestFrom = "";
		
		try
		{
			ServletFileUpload fileUpload = new ServletFileUpload(new DiskFileItemFactory());
			List<FileItem> fileItems = fileUpload.parseRequest(request);
			ServletContext context = getServletContext();
			
			if(!fileItems.get(0).getContentType().equals("application/octet-stream"))				// Check whether a new image for upload
			{
				
				String directoryPath = context.getInitParameter("directoryPath")+user.getId()+"\\"; // Read Path to store the files 
				
				fileItems.get(0).write(new File(directoryPath+fileItems.get(0).getName()));			// Save incoming image to the user's directory
				user.setImage_path("Images/Users/"+user.getId()+"/"+fileItems.get(0).getName());	// Set the profile image path
			}
			
			if(!fileItems.get(3).getContentType().equals("application/octet-stream"))
			{
				
				String directoryPath = context.getInitParameter("directoryPath")+user.getId()+"\\";
				fileItems.get(3).write(new File(directoryPath+fileItems.get(3).getName()));			// Save incoming image to the user's directory
				user.setCover_image("Images/Users/"+user.getId()+"/"+fileItems.get(3).getName());	// Set the cover image path
			}
			
			if(fileItems.get(1).getString().equals("0"))												// Check whether update request for removing image
			{
				if(user.getGender().equals("Male"))
				{
					user.setImage_path("Images/Male/avatar2.png");
				}
				else if(user.getGender().equals("Female"))
				{
					user.setImage_path("Images/Female/avatar6.png");
				}
			}
			
			
			requestFrom = fileItems.get(2).getString();
			
			user.setAbout(fileItems.get(4).getString());
			user.setProfession(fileItems.get(5).getString());
			user.setPlace(fileItems.get(6).getString());
			user.setWorkplace(fileItems.get(7).getString());
			
			java.util.Date date = null;
			try 
			{
				date = new SimpleDateFormat("yyyy-MM-dd").parse(fileItems.get(8).getString());
				
			} 
			catch (ParseException e) 
			{
		
				e.printStackTrace();
			}
			
			user.setDob(new Date(date.getTime()));
			user.setMobile(fileItems.get(9).getString());
					
			BusinessLogic businessLogic = new BusinessLogic();
			User newUser = businessLogic.updateProfile(user);			// save changes to the database
			session.setAttribute("user", newUser);						// set the updated user into session
			
			
			ArrayList<Post> postList = (ArrayList<Post>) session.getAttribute("postList");  // get the post list from session
			
			for(Post post : postList)
			{
				if(post.getUser_id() == user.getId())
				{
					post.setImage_path(newUser.getImage_path());			// update the profile image in post list of logged in user
				}
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
			
		if(requestFrom.equals("signup"))
		{
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("home.jsp");
			requestDispatcher.forward(request, response);
		}
		else if(requestFrom.equals("profile_update"))
		{
			request.setAttribute("requestFrom", "profile_update");
							
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("profile.jsp");
			requestDispatcher.forward(request, response);
		}
		
		/*	String about = request.getParameter("about");
			String profession = request.getParameter("profession");
			String place = request.getParameter("place");
			String imagePath = request.getParameter("imagePath");
			String requestFrom = request.getParameter("requestFrom");
			
			System.out.println(imagePath);
			System.out.println(about);
			System.out.println(profession);
			System.out.println(place);
			System.out.println(requestFrom);
			
			HttpSession session = request.getSession();
			
			User user = (User) session.getAttribute("user");			// get user from session
			
			BusinessLogic businessLogic = new BusinessLogic();
			
			user.setImage_path(imagePath);								// update user data 
			user.setAbout(about);
			user.setProfession(profession);
			user.setPlace(place);
			
			User newUser = businessLogic.updateProfile(user);			// save changes to the database
			session.setAttribute("user", newUser);						// set the updated user into session
			
			
			ArrayList<Post> postList = (ArrayList<Post>) session.getAttribute("postList");  // get the post list from session
			
			for(Post post : postList)
			{
				if(post.getUser_id() == user.getId())
				{
					post.setImage_path(newUser.getImage_path());			// update the profile image in post list of logged in user
				}
			}
			
			if(newUser != null)
			{
				
				System.out.println("Profile Updated......");
			}
			else
			{
				System.out.println("Unable to update profile");
			}
			
			
			if(requestFrom.equals("signup"))
			{
				RequestDispatcher requestDispatcher = request.getRequestDispatcher("home.jsp");
				requestDispatcher.forward(request, response);
			}
			else if(requestFrom.equals("profile_update"))
			{
				request.setAttribute("requestFrom", "profile_update");
								
				RequestDispatcher requestDispatcher = request.getRequestDispatcher("profile.jsp");
				requestDispatcher.forward(request, response);
			}*/
			
	}

}
