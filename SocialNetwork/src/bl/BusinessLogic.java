package bl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import dto.Chat;
import dto.Post;
import dto.PostNotification;
import dto.RecommendedFriend;
import dto.User;
import utility.DBConnection;


public class BusinessLogic 
{
		public User saveUser(User user)
		{
			User savedUser = null;
			
			Connection connection = DBConnection.getConnection();
			
			try
			{
				Statement statement = connection.createStatement();
					
				//  Procedure written on 15 August 2018 12:00 PM
				
				String procedure = "{CALL createAccount(?,?,?,?,?,?,?,?,?)}";
				
				CallableStatement stmnt = connection.prepareCall(procedure);
				
				stmnt.setString("f_name", user.getFirst_name());
				stmnt.setString("l_name", user.getLast_name());
				stmnt.setString("mail", user.getEmail());
				stmnt.setString("mob", user.getMobile());
				stmnt.setDate("birth", user.getDob());
				stmnt.setString("gen", user.getGender());
				stmnt.setString("pass",user.getPassword());
				stmnt.setInt("ag", 20);
				if(user.getGender().equals("Male"))
				{
					stmnt.setString("path", "Images/Male/avatar2.png");
				}
				else
				{
					stmnt.setString("path", "Images/Female/avatar6.png");
				}
				
					
				ResultSet resultSet = stmnt.executeQuery();
				
				while(resultSet.next())
				{
					savedUser = new User();
					
					savedUser.setId(resultSet.getInt("user_id"));
					savedUser.setFirst_name(resultSet.getString("first_name"));
					savedUser.setLast_name(resultSet.getString("last_name"));
					savedUser.setEmail(resultSet.getString("email"));
					savedUser.setMobile(resultSet.getString("mobile"));
					savedUser.setDob(resultSet.getDate("dob"));
					savedUser.setGender(resultSet.getString("gender"));
					savedUser.setAge(resultSet.getShort("age"));
					savedUser.setCreated_date(resultSet.getTimestamp("created_date"));
					
					savedUser.setImage_path(resultSet.getString("image_path"));
					savedUser.setAbout(resultSet.getString("about"));
					savedUser.setProfession(resultSet.getString("profession"));
					savedUser.setPlace(resultSet.getString("place"));
					user.setWorkplace(resultSet.getString("workplace"));
				}
				
							
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			return savedUser;
		}
		
		
		
		
		
		public User getUser(long id)
		{
			User user = null;
			
			Connection connection = DBConnection.getConnection();
			try
			{
				Statement statement = connection.createStatement();
				//String query = "SELECT user_id,first_name, last_name, email,mobile,gender FROM user WHERE email= '"+email+"';";
				
				String newQuery = "select user.user_id, first_name, last_name, email, mobile, dob, gender, age, created_date, image_path, about, profession, place,cover_image, workplace from user inner join profile on user.user_id = profile.user_id where user.user_id = "+id+";";
				
				ResultSet set = statement.executeQuery(newQuery);
				
				while(set.next())
				{
					user = new User();
					
					user.setId(set.getInt("user_id"));
					user.setFirst_name(set.getString("first_name"));
					user.setLast_name(set.getString("last_name"));
					user.setEmail(set.getString("email"));
					user.setMobile(set.getString("mobile"));
					user.setDob(set.getDate("dob"));
					user.setGender(set.getString("gender"));
					user.setAge(set.getShort("age"));
					user.setCreated_date(set.getTimestamp("created_date"));
					user.setImage_path(set.getString("image_path"));
					user.setAbout(set.getString("about"));
					user.setProfession(set.getString("profession"));
					user.setPlace(set.getString("place"));
					user.setCover_image(set.getString("cover_image"));
					user.setWorkplace(set.getString("workplace"));
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			return user;
		}	
		
		
		
		
		
		public User logIn(String username, String password)
		{	
			User user = null;
			
			Connection connection = DBConnection.getConnection();
			try
			{
				/*CallableStatement callableStatement = connection.prepareCall("{call login(?,?)}");
				callableStatement.setString("username", username);
				callableStatement.setString("pass", password);
				*/
				Statement statement = connection.createStatement();
				String query = "SELECT user.user_id, first_name, last_name, email, mobile, dob, gender, created_date, image_path, about, profession, place,cover_image, workplace FROM user INNER JOIN profile WHERE user.user_id = profile.user_id AND (user.email = '"+username+"' AND user.password='"+password+"');";
				
				/*ResultSet set = callableStatement.executeQuery();*/
				
				ResultSet set = statement.executeQuery(query);
				
				while(set.next())
				{
					user = new User();
					
					user.setId(set.getInt("user.user_id"));
					user.setFirst_name(set.getString("first_name"));
					user.setLast_name(set.getString("last_name"));
					user.setEmail(set.getString("email"));
					user.setMobile(set.getString("mobile"));
					user.setDob(set.getDate("dob"));
					user.setGender(set.getString("gender"));
					user.setCreated_date(set.getTimestamp("created_date"));
					user.setImage_path(set.getString("image_path"));
					user.setAbout(set.getString("about"));
					user.setProfession(set.getString("profession"));
					user.setPlace(set.getString("place"));
					user.setCover_image(set.getString("cover_image"));
					user.setWorkplace(set.getString("workplace"));
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			return user;
		}

		
		public void logout(long id)
		{
			Connection connection = DBConnection.getConnection();
			
			try
			{
				Statement statement = connection.createStatement();
				String query = "update user set current_status = 0 where user_id = "+id;	// To mark user as offline
				
				statement.executeUpdate(query);			
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		
		
		public ArrayList<User> getUserList(long userid, String keyword)
		{
			ArrayList<User> userList = new ArrayList<User>();
			User user = null;
			Connection connection = DBConnection.getConnection();
			
			try
			{
				Statement statement = connection.createStatement();
				String query = "SELECT user.user_id, first_name, last_name, image_path, profession FROM user INNER JOIN profile WHERE user.user_id = profile.user_id AND (CONCAT(first_name,last_name) like '"+keyword+"%' AND user.user_id != "+userid+"); ";
				
				ResultSet resultSet = statement.executeQuery(query);
				
				while(resultSet.next())
				{
					user = new User();
					
					user.setId(resultSet.getInt("user.user_id"));
					user.setFirst_name(resultSet.getString("first_name"));
					user.setLast_name(resultSet.getString("last_name"));
					user.setImage_path(resultSet.getString("image_path"));
					user.setProfession(resultSet.getString("profession"));
					
					userList.add(user);
					
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			return userList;
		}
		
		
		
		
		
		public ArrayList<User> getFriendList(long userid)
		{
			ArrayList<User> friendList = new ArrayList<User>();

			User user = null;
			Connection connection = DBConnection.getConnection();
			
			try
			{
				/*
				Statement statement = connection.createStatement();
				String query = "SELECT user.user_id,first_name, last_name,image_path FROM user INNER JOIN friends INNER JOIN profile WHERE user.user_id = friends.receiver_id AND user.user_id = profile.user_id  AND friends.sender_id = "+userid+" UNION SELECT user.user_id,first_name, last_name,image_path FROM user INNER JOIN friends INNER JOIN profile WHERE user.user_id = friends.sender_id AND user.user_id = profile.user_id AND friends.receiver_id ="+userid+";";
				
				ResultSet resultSet = statement.executeQuery(query);
				*/
				
				// Procedure added on 14-08-2018 7:00pm
				
				String procedure = "{CALL getFriends(?)}";
				
				CallableStatement stmnt = connection.prepareCall(procedure);
				
				stmnt.setLong("id", userid);
				
				ResultSet resultSet = stmnt.executeQuery();
		
				
				
				while(resultSet.next())
				{
					user = new User();
					
					user.setId(resultSet.getInt(1));
					user.setFirst_name(resultSet.getString("first_name"));
					user.setLast_name(resultSet.getString("last_name"));
					user.setImage_path(resultSet.getString("image_path"));
					user.setCurrent_status(resultSet.getInt("current_status"));
		
					
					friendList.add(user);
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			return friendList;
		}
		
		
		// This method is added on 01-09-2018 10:02 AM
		
		public ArrayList<User> getMutualFriendsList(long login_user_id, long searched_user_id)
		{
			ArrayList<User> mutualFriendsList = new ArrayList<User>();
			User mutualFriend = null;
			Connection connection = DBConnection.getConnection();
			
			try	
			{
				String procedure = "{call mutualFriends(?,?)}";
				CallableStatement callableStatement = connection.prepareCall(procedure);
				
				callableStatement.setLong("login_user_id", login_user_id);
				callableStatement.setLong("other_user_id", searched_user_id);
				
				ResultSet resultSet = callableStatement.executeQuery();
				
				while(resultSet.next())
				{
					mutualFriend = new User();
					
					mutualFriend.setId(resultSet.getLong(1));
					mutualFriend.setFirst_name(resultSet.getString("first_name"));
					mutualFriend.setLast_name(resultSet.getString("last_name"));
					mutualFriend.setImage_path(resultSet.getString("image_path"));
					
					mutualFriendsList.add(mutualFriend);
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			return mutualFriendsList;
		}
		

		
		public ArrayList<Post> getPostsSpecificToUser(long userid)
		{
			ArrayList<Post> postList = new ArrayList<Post>();
			Post post = null;
			
			Connection connection = DBConnection.getConnection();

			try
			{
				Statement statement = connection.createStatement();
				
				String query = "select * from posts where user_id = "+userid+" ORDER BY post_timestamp DESC;";
				
				ResultSet resultSet = statement.executeQuery(query);
				
				while(resultSet.next())
				{
					post = new Post();
					
					post.setPost_id(resultSet.getLong("post_id"));
					post.setUser_id(resultSet.getLong("user_id"));
					post.setPost_type(resultSet.getString("post_type"));
					post.setPost_text(resultSet.getString("post_text"));
					post.setPost_url(resultSet.getString("post_url"));
					post.setPost_likes(resultSet.getLong("post_likes"));
					post.setPost_timestamp(resultSet.getTimestamp("post_timestamp"));
					
					postList.add(post);
				}
				
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
		return postList;
			
		}
		
		
		public ArrayList<Post> getPosts(long userid)
		{
			ArrayList<Post> postList = new ArrayList<Post>();
			Post post = null;
			
			Connection connection = DBConnection.getConnection();
			
			try
			{
				Statement statement = connection.createStatement();
				String q = "SELECT post_id, user.user_id, first_name, last_name, post_type, post_text, post_url, post_likes, post_timestamp AS TIME FROM user INNER JOIN friends INNER JOIN posts WHERE user.user_id = friends.receiver_id AND posts.user_id = friends.receiver_id AND friends.sender_id = "+userid+" UNION SELECT post_id, user.user_id, first_name, last_name, post_type, post_text, post_url, post_likes, post_timestamp AS TIME FROM user INNER JOIN friends INNER JOIN posts WHERE user.user_id = friends.sender_id AND posts.user_id = friends.sender_id AND friends.receiver_id = "+userid+" UNION SELECT post_id, user.user_id, first_name, last_name, post_type, post_text, post_url, post_likes, post_timestamp AS TIME FROM user INNER JOIN posts WHERE user.user_id = posts.user_id AND posts.user_id = "+userid+"  ORDER BY TIME DESC;";
				
				String query = "SELECT post_id, user.user_id, image_path, first_name, last_name, post_type, post_text, post_url, post_likes, post_timestamp FROM user INNER JOIN friends INNER JOIN posts INNER JOIN profile WHERE user.user_id = friends.receiver_id AND posts.user_id = friends.receiver_id AND profile.user_id = friends.receiver_id AND friends.sender_id = "+userid+" UNION SELECT post_id, user.user_id, image_path, first_name, last_name, post_type, post_text, post_url, post_likes, post_timestamp FROM user INNER JOIN friends INNER JOIN posts INNER JOIN profile  WHERE user.user_id = friends.sender_id AND posts.user_id = friends.sender_id AND profile.user_id = friends.sender_id AND friends.receiver_id = "+userid+" UNION SELECT post_id, user.user_id, image_path, first_name, last_name, post_type, post_text, post_url, post_likes, post_timestamp FROM user INNER JOIN posts INNER JOIN profile WHERE user.user_id = posts.user_id AND profile.user_id = user.user_id AND posts.user_id = "+userid+"  ORDER BY post_timestamp DESC;";
				
				
				ResultSet resultSet = statement.executeQuery(query);
				
				while(resultSet.next())
				{
					post = new Post();
					
					post.setPost_id(resultSet.getLong("post_id"));
					post.setImage_path(resultSet.getString("image_path"));
					post.setUser_id(resultSet.getLong("user_id"));
					post.setFirst_name(resultSet.getString("first_name"));
					post.setLast_name(resultSet.getString("last_name"));
					post.setPost_type(resultSet.getString("post_type"));
					post.setPost_text(resultSet.getString("post_text"));
					post.setPost_url(resultSet.getString("post_url"));
					post.setPost_likes(resultSet.getLong("post_likes"));
					post.setPost_timestamp(resultSet.getTimestamp("post_timestamp"));
					
					postList.add(post);
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			return postList;
		}
		
		
		
		
		public ArrayList<Post> updatePost(Post post)
		{
			//boolean saved = false;
			
			ArrayList<Post> postList = new ArrayList<Post>();
			Post oldPost = null;
			
			Connection connection = DBConnection.getConnection();
			
			try
			{
				/*
				Statement statement = connection.createStatement();
				String query = "INSERT INTO posts(user_id,post_type,post_text,post_url,post_likes,post_timestamp) values("+post.getUser_id()+",'"+post.getPost_type()+"','"+post.getPost_text()+"','"+post.getPost_url()+"',"+post.getPost_likes()+",current_timestamp); ";
				
				if(statement.executeUpdate(query) > 0)
				{
					saved = true;
				}
				
				*/
				//		New Procedure written on 20-08-2018 insert post into post table and retrive all the posts.........
				//	##########################################################################################################3
				
				CallableStatement callableStatement = connection.prepareCall("{call updatePost(?,?,?,?,?)}");

				callableStatement.setLong("userid", post.getUser_id());
				callableStatement.setString("postType", post.getPost_type());
				callableStatement.setString("postText", post.getPost_text());
				callableStatement.setString("postURL", post.getPost_url());
				callableStatement.setLong("postLikes", post.getPost_likes());
				
				ResultSet resultSet = callableStatement.executeQuery();
				
				while(resultSet.next())
				{
					oldPost = new Post();
					
					oldPost.setPost_id(resultSet.getLong("post_id"));
					oldPost.setImage_path(resultSet.getString("image_path"));
					oldPost.setUser_id(resultSet.getLong("user_id"));
					oldPost.setFirst_name(resultSet.getString("first_name"));
					oldPost.setLast_name(resultSet.getString("last_name"));
					oldPost.setPost_type(resultSet.getString("post_type"));
					oldPost.setPost_text(resultSet.getString("post_text"));
					oldPost.setPost_url(resultSet.getString("post_url"));
					oldPost.setPost_likes(resultSet.getLong("post_likes"));
					oldPost.setPost_timestamp(resultSet.getTimestamp("post_timestamp"));
					
					postList.add(oldPost);
				}
				
				
				
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			return postList;
		}
		
		
		
		public User updateProfile(User user)
		{
			User updatedUser = null;
			
			
			try
			{
				Connection connection = DBConnection.getConnection();
				
				String procedure = "{CALL updateProfile(?,?,?,?,?,?,?) }";
				CallableStatement callableStatement = connection.prepareCall(procedure);

				callableStatement.setString("path", user.getImage_path());
				callableStatement.setString("abt", user.getAbout());
				callableStatement.setString("prof", user.getProfession());
				callableStatement.setString("plc", user.getPlace());
				callableStatement.setString("cover", user.getCover_image());
				callableStatement.setString("workplce", user.getWorkplace());
				callableStatement.setLong("id", user.getId());
				
				
				ResultSet resultSet = callableStatement.executeQuery();
				
				while(resultSet.next())
				{
					updatedUser = new User();
					
					updatedUser.setId(resultSet.getInt("user_id"));
					updatedUser.setFirst_name(resultSet.getString("first_name"));
					updatedUser.setLast_name(resultSet.getString("last_name"));
					updatedUser.setEmail(resultSet.getString("email"));
					updatedUser.setMobile(resultSet.getString("mobile"));
					updatedUser.setDob(resultSet.getDate("dob"));
					updatedUser.setGender(resultSet.getString("gender"));
					updatedUser.setAge(resultSet.getShort("age"));
					
					updatedUser.setImage_path(resultSet.getString("image_path"));
					updatedUser.setAbout(resultSet.getString("about"));
					updatedUser.setProfession(resultSet.getString("profession"));
					updatedUser.setPlace(resultSet.getString("place"));
					updatedUser.setCover_image(resultSet.getString("cover_image"));
					updatedUser.setWorkplace(resultSet.getString("workplace"));
				}
				
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			
			return updatedUser;
		}
		
		
		public boolean sendRequest(long senderID, long receiverID)
		{	
				boolean requestSent = false;
				Connection connection = DBConnection.getConnection();
				
				try
				{
					Statement statement = connection.createStatement();
					
					String query = "insert into friend_request(sender_id,receiver_id,status,timestamp) values("+senderID+","+receiverID+",'Sent',current_timestamp)";
					
					if(statement.executeUpdate(query)>0)
					{
						requestSent = true;
					}
					
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
				
				return requestSent;
		}
		
		
		public ArrayList<User> getListofSentRequest(long loggedInUser)
		{
			ArrayList<User> sentRequests = new ArrayList<User>();
			Connection connection = DBConnection.getConnection();
			
				try
				{
					Statement statement = connection.createStatement();
					
					String query = "select user.user_id, first_name, last_name,image_path from profile INNER JOIN user INNER JOIN friend_request ON user.user_id = receiver_id and user.user_id = profile.user_id where sender_id = "+loggedInUser+" and status='Sent';";
					
					ResultSet resultSet = statement.executeQuery(query);
					
					while(resultSet.next())
					{
						User user = new User();
						
						user.setId(resultSet.getLong("user_id"));
						user.setFirst_name(resultSet.getString("first_name"));
						user.setLast_name(resultSet.getString("last_name"));
						user.setImage_path(resultSet.getString("image_path"));
						
						sentRequests.add(user);
					}
				}
				catch(Exception e)
				{
						e.printStackTrace();
				}
			
			return sentRequests;
		}
		
		
		
		
		public ArrayList<User> getListofReceivedRequest(long loggedInUser)
		{
			ArrayList<User> receivedRequests = new ArrayList<User>();
			Connection connection = DBConnection.getConnection();
			
			try
			{
				Statement statement = connection.createStatement();
				
				String query = "select user.user_id, first_name, last_name,image_path from profile INNER JOIN user INNER JOIN friend_request ON user.user_id = friend_request.sender_id and user.user_id = profile.user_id  where receiver_id = "+loggedInUser+" and status = 'Sent';";
				
				ResultSet resultSet = statement.executeQuery(query);
				
				while(resultSet.next())
				{
					User user = new User();
					
					user.setId(resultSet.getLong("user_id"));
					user.setFirst_name(resultSet.getString("first_name"));
					user.setLast_name(resultSet.getString("last_name"));
					user.setImage_path(resultSet.getString("image_path"));
					
					receivedRequests.add(user);
				}
			}
			catch(Exception e)
			{
					e.printStackTrace();
			}
			
			return receivedRequests;
		}
		
		
		
		public ArrayList<User> acceptFriendRequest(long senderID, long receiverID)
		{
			ArrayList<User> friendList = new ArrayList<User>();
			
			try
			{
				Connection connection = DBConnection.getConnection();
				
				String procedure = "{call acceptRequest(?, ?)}";
				CallableStatement callableStatement = connection.prepareCall(procedure);
				
				callableStatement.setLong("senderID", senderID);
				callableStatement.setLong("receiverID", receiverID);
				
				ResultSet resultSet = callableStatement.executeQuery();
				
				while(resultSet.next())
				{
					User user = new User();
					
					user.setId(resultSet.getLong("user_id"));
					user.setFirst_name(resultSet.getString("first_name"));
					user.setLast_name(resultSet.getString("last_name"));
					user.setImage_path(resultSet.getString("image_path"));
					
					friendList.add(user);
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			return friendList;
		}
		
		
		
		
		public boolean rejectFriendRequest(long senderID, long receiverID)
		{
			boolean isRejected = false;
			Connection connection = DBConnection.getConnection();
			
			try
			{
				Statement statement = connection.createStatement();
				String query = "update friend_request set status = 'Rejected' where sender_id = "+senderID+" and receiver_id = "+receiverID+";";
				
				if(statement.executeUpdate(query) > 0)
				{
					isRejected = true;
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			return isRejected;
		}
		
		
		
		public boolean hitLikeToPost(long loggedInUserid,long postUserid, Timestamp timestamp, HttpSession session)
		{		
			boolean isLiked = false;
	
			ArrayList<Post> postList = new ArrayList<Post>();
			Post oldPost = null;
			Connection connection = DBConnection.getConnection();
			
			try
			{
				
			/*	
				String query = "update posts set post_likes = post_likes + 1 where user_id = "+postUserid+" and post_timestamp = "+timestamp+";";
				
				Statement statement = connection.createStatement();
				
				if(statement.executeUpdate(query)>0)
				{
					session.setAttribute("postList", getPosts(loggedInUserid));
					
					isLiked = true;
				}
				
				*/
				
				CallableStatement callableStatement = connection.prepareCall("{call hitLikes(?,?,?)}");
				
				callableStatement.setLong("userid", loggedInUserid);
				callableStatement.setLong("postUserid", postUserid);
				callableStatement.setTimestamp("timestmp", timestamp);
				
				ResultSet resultSet = callableStatement.executeQuery();
				
				
				
				while(resultSet.next())
				{
					oldPost = new Post();
					
					oldPost.setPost_id(resultSet.getLong("post_id"));
					oldPost.setImage_path(resultSet.getString("image_path"));
					oldPost.setUser_id(resultSet.getLong("user_id"));
					oldPost.setFirst_name(resultSet.getString("first_name"));
					oldPost.setLast_name(resultSet.getString("last_name"));
					oldPost.setPost_type(resultSet.getString("post_type"));
					oldPost.setPost_text(resultSet.getString("post_text"));
					oldPost.setPost_url(resultSet.getString("post_url"));
					oldPost.setPost_likes(resultSet.getLong("post_likes"));
					oldPost.setPost_timestamp(resultSet.getTimestamp("post_timestamp"));
					
					postList.add(oldPost);
					
					isLiked = true;
				}
				
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			session.setAttribute("postList", postList);  // set updated post list with likes to the session
			
			return isLiked;
		}
		
		
		public ArrayList<PostNotification> getPostNotification(long userid)
		{
			ArrayList<PostNotification> postNotificationList = new ArrayList<PostNotification>();
			PostNotification postNotification;
			
			Connection connection = DBConnection.getConnection();
			
			try
			{
				Statement statement = connection.createStatement();
				
				String query = "select post_text, like_by_user_id, timestamp, first_name,last_name, image_path, status from posts inner join likesby inner join user inner join profile on posts.user_id = likesby.post_user_id and post_timestamp = likesby.timestamp and like_by_user_id = user.user_id and profile.user_id = like_by_user_id where post_user_id = "+userid+" and status = 0 order by timestamp;";
				
				ResultSet resultSet = statement.executeQuery(query);
				
				while(resultSet.next())
				{
					postNotification = new PostNotification();
					
					postNotification.setPostUserid(userid);
					postNotification.setText(resultSet.getString("post_text"));
					postNotification.setLikesByuserid(resultSet.getLong("like_by_user_id"));
					postNotification.setPostTimestamp(resultSet.getTimestamp("timestamp"));
					postNotification.setLikeByUserFirstName(resultSet.getString("first_name"));
					postNotification.setLikeByUserLastName(resultSet.getString("last_name"));
					postNotification.setImagePath(resultSet.getString("image_path"));
					postNotification.setStatus(resultSet.getInt("status"));
					
					postNotificationList.add(postNotification);
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			return postNotificationList;
		}
		
		
		
		
		
		public ArrayList<Chat> getChatMessages(long senderID, long receiverID)
		{
			ArrayList<Chat> messageList = new ArrayList<Chat>();
			Chat chat = null;
			Connection connection = DBConnection.getConnection();
			
			try
			{
				Statement statement = connection.createStatement();
				String query="select * from chats where sender_id = "+senderID+" and receiver_id = "+receiverID+" OR sender_id = "+receiverID+" and receiver_id = "+senderID+";";	
				
				ResultSet resultSet = statement.executeQuery(query);
				
				while(resultSet.next())
				{
					chat = new Chat();
					
					chat.setSender_id(resultSet.getLong("sender_id"));
					chat.setReceiver_id(resultSet.getLong("receiver_id"));
					chat.setMessage(resultSet.getString("message"));
					chat.setUrl(resultSet.getString("url"));
					chat.setTimestamp(resultSet.getTimestamp("message_timestamp"));
					
					messageList.add(chat);
				}
				
				
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			return messageList;
		}
		
		
	
		
		public ArrayList<Chat> saveAndRetriveChats(long senderID, long receiverID, String message)
		{
			ArrayList<Chat> messageList = new ArrayList<Chat>();
			Chat chat = null;
			Connection connection = DBConnection.getConnection();
			
			try
			{
				CallableStatement callableStatement = connection.prepareCall("{call saveAndGetMessage(?,?,?,?)}");
				
				callableStatement.setLong("senderID", senderID);
				callableStatement.setLong("receiverID", receiverID);
				callableStatement.setString("message", message);
				callableStatement.setString("url", "");
				
				ResultSet resultSet = callableStatement.executeQuery();
				
				while(resultSet.next())
				{
					chat = new Chat();
					
					chat.setSender_id(resultSet.getLong("sender_id"));
					chat.setReceiver_id(resultSet.getLong("receiver_id"));
					chat.setMessage(resultSet.getString("message"));
					chat.setUrl(resultSet.getString("url"));
					chat.setTimestamp(resultSet.getTimestamp("message_timestamp"));
					
					messageList.add(chat);
				}
				
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			return messageList;
		}
		
		
		
		public ArrayList<RecommendedFriend> getRecommendedFriendList(User user)
		{
				ArrayList<RecommendedFriend> recommendedFriends = new ArrayList<RecommendedFriend>();
				Connection connection = DBConnection.getConnection();
				RecommendedFriend recommendedFriend = null;
				
				try
				{
					String procedure = "{call SuggestedFriends(?,?,?)}";
					CallableStatement callableStatement = connection.prepareCall(procedure);
					
					callableStatement.setLong("login_user_id", user.getId());
					callableStatement.setString("login_user_place", user.getPlace());
					callableStatement.setString("login_user_workplace", user.getWorkplace());
					
					
					ResultSet resultSet = callableStatement.executeQuery();
					
					while(resultSet.next())
					{
						recommendedFriend = new RecommendedFriend();
						
						recommendedFriend.setUser_id(resultSet.getLong(1));
						recommendedFriend.setFirst_name(resultSet.getString(2));
						recommendedFriend.setLast_name(resultSet.getString(3));
						recommendedFriend.setMutualFriends(resultSet.getInt(4));
						recommendedFriend.setImage_path(resultSet.getString(5));
						
						recommendedFriends.add(recommendedFriend);
					}
					
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
				
				return recommendedFriends;
		}
 		
		
		public boolean saveOTP(String email, String otp, HttpServletRequest request)
		{
			boolean isOTPSaved = false;
			Connection connection = DBConnection.getConnection();
			
			try
			{
				Statement statement= connection.createStatement();
				String query = "insert into passwordRecovery(email, otp, otp_timestamp, status) values('"+email+"','"+otp+"',current_timestamp,'Not verified')";
				
				if(statement.executeUpdate(query) > 0)
				{
					isOTPSaved = true;
				}
				
				/*
				CallableStatement callableStatement = connection.prepareCall("{call verifyEmailAndSendOTP(?,?)}");
				
				callableStatement.setString("mail", email);
				callableStatement.setString("otp_code", otp);
				
				if(callableStatement.executeUpdate() > 0)
				{
					isOTPSaved = true;
				}
				else
				{
					request.setAttribute("exception", email+" is invalid email address");
					return isOTPSaved;
				}*/
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			return isOTPSaved;
		}
		
		public boolean verifyOTPResetPassword(String otp, String password, String email)
		{
			boolean isVerified = false;
			Connection connection = DBConnection.getConnection();
			
			try
			{
				CallableStatement callableStatement = connection.prepareCall("{call verifyAndResetPassword(?,?,?)}");
				callableStatement.setString("new_otp", otp);
				callableStatement.setString("new_password", password);
				callableStatement.setString("email_id", email);
				
				ResultSet resultSet = callableStatement.executeQuery();
				
				while(resultSet.next())
				{
					isVerified = true;
				}
					
				
			}
			catch(Exception e)
			{
				return false;
			}
			
			
			return isVerified;
		}
		
}
