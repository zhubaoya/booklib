package com.zby.books.model.po;

/**
 * 这是管理员类，对应数据库中的admin表
 * 
 * @author 祝宝亚
 * @date 2018年1月22日
 * 
 */
public class Admin {

	private Integer id;
	private String aname;
	private String apass;
	private String pressName;
	private String userid;
	private String handid;
	
	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getHandid() {
		return handid;
	}

	public void setHandid(String handid) {
		this.handid = handid;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAname() {
		return aname;
	}

	public void setAname(String aname) {
		this.aname = aname;
	}

	public String getApass() {
		return apass;
	}

	public void setApass(String apass) {
		this.apass = apass;
	}

	public String getPressName() {
		return pressName;
	}

	public void setPressName(String pressName) {
		this.pressName = pressName;
	}

	public Admin() {
		
	}

	public Admin(String aname, String apass, String pressName) {
		this.aname = aname;
		this.apass = apass;
		this.pressName = pressName;
	}

	public Admin(Integer id, String aname, String apass, String pressName,
			String userid, String handid) {
		this.id = id;
		this.aname = aname;
		this.apass = apass;
		this.pressName = pressName;
		this.userid = userid;
		this.handid = handid;
	}

	public Admin( String aname, String apass, String pressName,
			String userid, String handid) {
		this.aname = aname;
		this.apass = apass;
		this.pressName = pressName;
		this.userid = userid;
		this.handid = handid;
	}
	
}
