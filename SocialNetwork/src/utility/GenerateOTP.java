package utility;

import java.util.Random;

public class GenerateOTP 
{
	public static String getOTP()
	{
		String alphnumeric = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		char buffer[] = new char[7]; 
		Random random = new Random();
		
		
		for(int i=0; i < 7;i++)
		{
			buffer[i] = alphnumeric.charAt(random.nextInt(alphnumeric.length()));
		}
		
		String otp = new String(buffer);
		
		return otp;
	}
	
}
