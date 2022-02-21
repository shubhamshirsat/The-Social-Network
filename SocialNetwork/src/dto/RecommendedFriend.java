package dto;

public class RecommendedFriend 
{
	long user_id;
	String first_name;
	String last_name;
	int mutualFriends;
	String image_path;
	
	
	
	
	public String getImage_path() {
		return image_path;
	}

	public void setImage_path(String image_path) {
		this.image_path = image_path;
	}

	public long getUser_id() 
	{
		return user_id;
	}
	
	public void setUser_id(long user_id) 
	{
		this.user_id = user_id;
	}
	public String getFirst_name() {
		return first_name;
	}
	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}
	public String getLast_name() {
		return last_name;
	}
	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}
	public int getMutualFriends() {
		return mutualFriends;
	}
	public void setMutualFriends(int mutualFriends) {
		this.mutualFriends = mutualFriends;
	}

}
