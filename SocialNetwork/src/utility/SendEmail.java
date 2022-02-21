package utility;

import javax.mail.*;  
import javax.mail.internet.InternetAddress;  
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;



import java.util.Properties;  

public class SendEmail 
{
	public static void send(String to,String subject,String msg, HttpServletRequest request){  
		  
		final String user="helpdesk@socialnetwork.com";		// Put your email  
		final String pass="Put your password";  
		  
	
		Properties props = new Properties();  
		props.put("mail.smtp.host", "smtp.gmail.com");  
		props.put("mail.smtp.auth", "true");  
		props.put("mail.smtp.port", "587");  
	    props.put("mail.debug", "true");  
	    props.put("mail.smtp.socketFactory.port", "587");  
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.user", user);
        props.put("mail.password", pass);
	    props.put("mail.smtp.socketFactory.fallback", "false");    
		
		
	    Session session = Session.getInstance(props, new javax.mail.Authenticator() {
	        protected PasswordAuthentication getPasswordAuthentication() {
	            return new PasswordAuthentication(user, pass);
	        }
	    });  
	
	      
		try 
		{  
			 MimeMessage message = new MimeMessage(session);  
			 message.setFrom(new InternetAddress(user));  
			 message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));  
			 message.setSubject(subject);  
			 message.setText(msg);  
			   
			  
			 Transport.send(message);  
			  
			 System.out.println("Done");  
		  
		} 
		catch (MessagingException e) 		// When email address is not valid then handle the exception
		{  
			request.setAttribute("exception", to+" is invalid email address"); 
			return;
		}  
		      
	}
}
