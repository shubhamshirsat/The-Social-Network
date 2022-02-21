package dto;

import java.sql.Timestamp;

public class Post 
{
	long post_id;
	long user_id;
	String post_type;
	String post_text;
	String post_url;
	long post_likes;
	Timestamp post_timestamp;
	
	String first_name;
	String last_name;
	String image_path;
	
	
	public String getImage_path() {
		return image_path;
	}
	public void setImage_path(String image_path) {
		this.image_path = image_path;
	}
	public long getPost_id() {
		return post_id;
	}
	public void setPost_id(long post_id) {
		this.post_id = post_id;
	}
	public long getUser_id() {
		return user_id;
	}
	public void setUser_id(long user_id) {
		this.user_id = user_id;
	}
	public String getPost_type() {
		return post_type;
	}
	public void setPost_type(String post_type) {
		this.post_type = post_type;
	}
	public String getPost_text() {
		return post_text;
	}
	public void setPost_text(String post_text) {
		this.post_text = post_text;
	}
	public String getPost_url() {
		return post_url;
	}
	public void setPost_url(String post_url) {
		this.post_url = post_url;
	}
	public long getPost_likes() {
		return post_likes;
	}
	public void setPost_likes(long post_likes) {
		this.post_likes = post_likes;
	}
	public Timestamp getPost_timestamp() {
		return post_timestamp;
	}
	public void setPost_timestamp(Timestamp post_timestamp) {
		this.post_timestamp = post_timestamp;
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
	
}
