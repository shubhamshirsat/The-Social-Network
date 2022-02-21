package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bl.BusinessLogic;
import utility.GenerateOTP;
import utility.SendEmail;

/**
 * Servlet implementation class ForgotPasswordServlet
 */
public class ForgotPasswordServlet extends HttpServlet 
{
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		request.setAttribute("requestFor", "forgetPassword");
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("forgotPassword.jsp");
		requestDispatcher.forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String page = "forgotPassword.jsp";
		BusinessLogic businessLogic = new BusinessLogic();
		
		if("generateOTP".equals(request.getParameter("requestFor")))
		{
			String to=request.getParameter("emailTo");  
		    String subject="Password Reset Request";
		    
		    
		    String otp = GenerateOTP.getOTP();
		    
		    if(businessLogic.saveOTP(to, otp, request))
		    {
		    	String msg="Hi,\n\nGreetings from The Social Network \n\nWe have received your request to reset your password.\n\n"+ "Your OTP is  "+otp;
		    	/* String msg = "test mail";*/
			    SendEmail.send(to, subject, msg, request);  
			    System.out.print("message has been sent successfully");
		    	
			    request.setAttribute("to", to);
		    	request.setAttribute("requestFor", "verifyOTP");
		    }	
		}
		else if("verifyOTP".equals(request.getParameter("requestFor")))
		{
			String otp = request.getParameter("otp");
			String email = request.getParameter("email");
			String password = request.getParameter("password");
				
			if(businessLogic.verifyOTPResetPassword(otp, password, email)) 
			{
				page = "index.jsp";
				request.setAttribute("msg", "Login with new password");
			}
			else
			{
				request.setAttribute("requestFor", "resetPasswordFailed");	
			}
		}
		  
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(page);
		requestDispatcher.forward(request, response);
	}

}
