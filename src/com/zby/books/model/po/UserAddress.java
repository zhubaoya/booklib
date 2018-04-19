package com.zby.books.model.po;

/**
 * 
 * 这是一个用于记录用户地址的类，对应着数据库中的UserAddress表
 * 
 * @author 祝宝亚
 * @date 2018年1月23日
 * 
 */
public class UserAddress {

	private Integer id; // 地址编号
	private String address; // 地址
	private String uid; // 用户编号，对应着user表的uid
	private String username; // 用户名
	private String userphone; // 用户手机号

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getUserphone() {
		return userphone;
	}

	public void setUserphone(String userphone) {
		this.userphone = userphone;
	}

	public UserAddress(String address, String uid, String username,
			String userphone) {
		this.address = address;
		this.uid = uid;
		this.username = username;
		this.userphone = userphone;
	}

	public UserAddress(String address, String uid, String username,
			String userphone, Integer id) {
		this(address, uid, username, userphone);
		this.id = id;
	}

	public UserAddress() {

	}
}
