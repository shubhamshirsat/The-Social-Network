package dto;

import java.sql.Timestamp;

public class PostNotification 
{
	long postUserid;
	long likesByuserid;
	String text;
	String imagePath;
	String likeByUserFirstName;
	String likeByUserLastName;
	Timestamp postTimestamp;
	int status;						//  status  = 1 (read), status = 0 (unread)
	
	
	
	public String getImagePath() {
		return imagePath;
	}
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	public String getText() 
	{
		return text;
	}
	public void setText(String text) 
	{
		this.text = text;
	}
	
	public long getPostUserid() {
		return postUserid;
	}
	public void setPostUserid(long postUserid) {
		this.postUserid = postUserid;
	}
	public long getLikesByuserid() {
		return likesByuserid;
	}
	public void setLikesByuserid(long likesByuserid) {
		this.likesByuserid = likesByuserid;
	}
	public String getLikeByUserFirstName() {
		return likeByUserFirstName;
	}
	public void setLikeByUserFirstName(String likeByUserFirstName) {
		this.likeByUserFirstName = likeByUserFirstName;
	}
	public String getLikeByUserLastName() {
		return likeByUserLastName;
	}
	public void setLikeByUserLastName(String likeByUserLastName) {
		this.likeByUserLastName = likeByUserLastName;
	}
	public Timestamp getPostTimestamp() {
		return postTimestamp;
	}
	public void setPostTimestamp(Timestamp postTimestamp) {
		this.postTimestamp = postTimestamp;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
	
	
}
