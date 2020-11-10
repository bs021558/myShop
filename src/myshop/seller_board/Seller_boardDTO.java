package myshop.seller_board;

import java.sql.Timestamp;

public class Seller_boardDTO {

	private int order_number;
	private String userId;
	private String email;
	private String subject;
	private String content;
	private Timestamp date;
	
	public int getOrder_number() {
		return order_number;
	}
	
	public String getUserId() {
		return userId;
	}
	
	public String getEmail() {
		return email;
	}
	
	public String getSubject() {
		return subject;
	}
	
	public String getContent() {
		return content;
	}
	
	public Timestamp getDate() {
		return date;
	}
	
	public void setOrder_number(int order_number) {
		this.order_number = order_number;
	}
	
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public void setDate(Timestamp date) {
		this.date = date;
	}
}
