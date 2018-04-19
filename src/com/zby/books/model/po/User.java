package com.zby.books.model.po;

import java.util.Date;

import com.zby.books.contents.Status;

/**
 * 
 * 这是用户类，对应数据库中user表
 * 
 * @author 祝宝亚
 * @date 2018年1月22日
 * 
 */
public class User {

	private Integer idxId; // 索引
	private String uid;
	private String uname;
	private String newpass;
	private String uphone;
	private String uemail;
	private Integer usex;
	private String oldpass;
	private Date loginDateTime;
	private String portrait; // 头像
	
	public String getPortrait() {
		return portrait;
	}

	public void setPortrait(String portrait) {
		this.portrait = portrait;
	}

	private Integer signin; // 签到
	private Status member; // 会员等级，1表示布衣，2便是银衣，3表示金衣

	public Integer getIdxId() {
		return idxId;
	}

	public void setIdxId(Integer idxId) {
		this.idxId = idxId;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public String getNewpass() {
		return newpass;
	}

	public void setNewpass(String newpass) {
		this.newpass = newpass;
	}

	public String getUphone() {
		return uphone;
	}

	public void setUphone(String uphone) {
		this.uphone = uphone;
	}

	public String getUemail() {
		return uemail;
	}

	public void setUemail(String uemail) {
		this.uemail = uemail;
	}

	public Integer getUsex() {
		return usex;
	}

	public void setUsex(Integer usex) {
		this.usex = usex;
	}

	public String getOldpass() {
		return oldpass;
	}

	public void setOldpass(String oldpass) {
		this.oldpass = oldpass;
	}

	public Date getLoginDateTime() {
		return loginDateTime;
	}

	public void setLoginDateTime(Date loginDateTime) {
		this.loginDateTime = loginDateTime;
	}

	public String getUaddress() {
		return portrait;
	}

	public void setUaddress(String portrait) {
		this.portrait = portrait;
	}

	public Integer getSignin() {
		return signin;
	}

	public void setSignin(Integer signin) {
		this.signin = signin;
	}

	public Status getMember() {
		return member;
	}

	public void setMember(Status member) {
		this.member = member;
	}

	/**
	 * 注册时用的构造器
	 *
	 * @author 祝宝亚
	 * @time   下午5:39:36
	 */
	public User(String uid, String uname, String newpass, String uphone,
			String uemail, Integer usex, String portrait) {
		this.uid = uid;
		this.uname=uname;
		this.newpass = newpass;
		this.uphone = uphone;
		this.uemail = uemail;
		this.usex = usex;
		this.portrait = portrait;
	}

	/**
	 * 更新时的构造器
	 *
	 * @author 祝宝亚
	 * @time   下午3:15:23
	 */
	public User(String uid, String uphone, String uemail, Integer usex,
			Date loginDateTime, String portrait, Integer signin, Status member) {
		this.uid = uid;
		this.uphone = uphone;
		this.uemail = uemail;
		this.usex = usex;
		this.loginDateTime = loginDateTime;
		this.portrait = portrait;
		this.signin = signin;
		this.member = member;
	}

	public User(Integer idxId, String uid, String uname, String newpass,
			String uphone, String uemail, Integer usex, String oldpass,
			Date loginDateTime, String portrait, Integer signin, Status member) {
		this.idxId = idxId;
		this.uid = uid;
		this.uname = uname;
		this.newpass = newpass;
		this.uphone = uphone;
		this.uemail = uemail;
		this.usex = usex;
		this.oldpass = oldpass;
		this.loginDateTime = loginDateTime;
		this.portrait = portrait;
		this.signin = signin;
		this.member = member;
	}

	
	public User(String uid, String uname, String newpass) {
		this.uid = uid;
		this.uname = uname;
		this.newpass = newpass;
	}

	public User() {

	}
}
