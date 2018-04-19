package com.zby.books.model.po;

import java.util.Date;

/**
 * 这是用户对某本书的评论类，对应数据库中的comments表
 * 
 * @author 祝宝亚
 * @date 2018年1月22日
 * 
 */
public class Comment {

	private Integer id;
	private String uid;         	 // 这是用户编号
	private String isbn;     	 // isbn编号
	private String comment;
	private Date commentDate;   //评论时间
	private String bookname;

	public String getBookname() {
		return bookname;
	}

	public void setBookname(String bookname) {
		this.bookname = bookname;
	}

	public Date getCommentDate() {
		return commentDate;
	}

	public void setCommentDate(Date commentDate) {
		this.commentDate = commentDate;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	
	public Comment(String uid, String isbn, String comment,Date commentDate,String bookname) {
		this.uid = uid;
		this.isbn = isbn;
		this.comment = comment;
		this.commentDate=commentDate;
		this.bookname=bookname;
	}

	public Comment(String uid, String isbn, String comment,Date commentDate,String bookname,Integer id) {
		this(uid,isbn,comment,commentDate,bookname);
		this.id = id;
	}

	/**
	 * 查询所用
	 *
	 * @author 祝宝亚
	 * @time   下午4:28:39
	 */
	public Comment(String uid, String isbn) {
		this.uid = uid;
		this.isbn = isbn;
	}

	public Comment() {

	}
}
