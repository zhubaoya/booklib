package com.zby.books.model.po;

import java.util.Date;

import com.zby.books.contents.Status;

/**
 * 
 * 这是用户账户类，记录用户的充值、消费情况，对应数据库中的account表
 * 
 * @author 祝宝亚
 * @date 2018年1月24日
 * 
 */
public class Account {

	private Integer id;
	private String uid;
	private float money;
	private Date datetime;
	private Integer note;
	private float sumMoney;    //总金额

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

	public float getMoney() {
		return money;
	}

	public void setMoney(float money) {
		this.money = money;
	}

	public Date getDatetime() {
		return datetime;
	}

	public void setDatetime(Date datetime) {
		this.datetime = datetime;
	}

	public Integer getNote() {
		return note;
	}

	public void setNote(Integer note) {
		this.note = note;
	}

	public float getSumMoney() {
		return sumMoney;
	}

	public void setSumMoney(float sumMoney) {
		this.sumMoney = sumMoney;
	}

	public Account(String uid, float money, Date datetime, Integer note,float sumMoney) {
		this.uid = uid;
		this.money = money;
		this.datetime = datetime;
		this.note = note;
		this.sumMoney=sumMoney;
		
	}

	public Account(String uid, float money, Date datetime,
			Integer note,float sumMoney,Integer id) {
		this(uid,money,datetime,note,sumMoney);
		this.id = id;
	}

	/**
	 * 用来查询
	 *
	 * @author 祝宝亚
	 * @time   下午3:18:12
	 */
	public Account(String uid, Integer note) {
		this.uid = uid;
		this.note = note;
	}

	public Account() {

	}
}
