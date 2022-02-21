package servlet;

import java.io.File;
import java.io.IOException;
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
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import bl.BusinessLogic;
import dto.Post;
import dto.User;

/**
 * Servlet implementation class PostServlet
 */
public class PostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
			HttpSession session = request.getSession();
			User user = (User) session.getAttribute("user");
			Post post = new Post();															// object for post is created
			
			String postType = "text";
			String imageURL = "";
			
				try 
				{
						ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());
			
						List<FileItem> fileItems = upload.parseRequest(request);
						
						FileItem item = fileItems.get(0);
						FileItem postText = fileItems.get(fileItems.size()-1);
						
						System.out.println("File: "+item.getFieldName());
						System.out.println("Field: "+postText.getFieldName());
						System.out.println("Value: "+postText.getString());
						
						if(!item.getContentType().equals("application/octet-stream"))
						{
							ServletContext context = getServletContext();
							
							String directoryPath = context.getInitParameter("directoryPath")+user.getId()+"\\";   // path to store the image for logged in user
		
							item.write(new File(directoryPath+item.getName()));             // Write file to server's disk
							
							postType = item.getContentType();
							imageURL = "Images/Users/"+user.getId()+"/"+item.getName();		// Relative URL w.r.t. Web Content Directory
						}
						
			
						// set parameters to the post
						
						post.setUser_id(user.getId());		
						post.setPost_type(postType);
						post.setPost_text(postText.getString());
						post.setPost_url(imageURL);
						post.setPost_likes(0);
					
				}
				catch (Exception e) 
				{
					e.printStackTrace();
				}
		
				
			BusinessLogic logic = new BusinessLogic();
			ArrayList<Post> postList = logic.updatePost(post);								// update post and retrive post
			
			session.setAttribute("postList", postList);										// Set post list in session
			
			
			
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("newsFeed.jsp");
			requestDispatcher.forward(request, response);
	}

}
