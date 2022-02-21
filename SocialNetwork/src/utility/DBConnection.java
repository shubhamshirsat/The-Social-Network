package utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection
{
	public static Connection getConnection()
	{
		Connection connection = null;
		
		try
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection =  DriverManager.getConnection("jdbc:mysql://localhost:3306/socialnetwork","root","root");
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return connection;
	}
}




