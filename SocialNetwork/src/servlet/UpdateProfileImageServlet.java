package servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Properties;

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

import dto.User;


public class UpdateProfileImageServlet extends HttpServlet 
{

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		ServletContext context = getServletContext();
		
		String directoryPath = context.getInitParameter("directoryPath")+user.getId()+"\\";   // path to store the image for logged in user
		
		
		try
		{
			ServletFileUpload fileUpload = new ServletFileUpload(new DiskFileItemFactory());
			
			List<FileItem> fileItems = fileUpload.parseRequest(request);		// Parse the request
				
			FileItem item = fileItems.get(0);			// get only first file
			
			FileItem formField = fileItems.get(fileItems.size()-1);		// get last form field
			
				
				item.write(new File(directoryPath+item.getName()));		// write file to the server's disk
				
				user.setImage_path("Images/Users/"+user.getId()+"/"+item.getName());		// set image path to the users attribute in session
			
				
				if(formField.getString().equals("signup"))
				{
					request.setAttribute("requestFrom", "signup");
					
					System.out.println("request from signup attibute set is signup");
					
				}
				else
				{
					request.setAttribute("requestFrom", "profile_update");
					System.out.println("request from profile_update attibute set is profile_update");
				}
			
				
				session.setAttribute("user", user);		//  update session attribute
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
		
		
		
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("profile.jsp");
		requestDispatcher.forward(request, response);	
		
	}

}
