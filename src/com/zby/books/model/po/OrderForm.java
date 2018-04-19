package com.zby.books.model.po;

import java.util.Date;

/**
 * 
 * 这是订单表类，对应数据库中的orderform表
 * 
 * @author 祝宝亚
 * @date 2018年1月22日
 * 
 */
public class OrderForm {
	private Integer orderId;
	private String userId;
	private String bookIsbn;
	private String bookCode; // 对应isbn表中的bookcode
	private Date lendTime;
	private Date returnTime;
	private int timeout; // 表示逾期多少天，默认为0
	private Float fine; // 表示罚款
	private Integer bookStatus; // 表示订单状态，1表示已定，2表示还书
	private Integer fineReason; // 表示罚款原因
	private String userphone; // 用户手机号
	private String userAddress;// 用户地址
	private String username; // 来自于地址表中的用户名
	private String bookname;
	private String pressname; // 出版社名称
	private String lendTo;
	private String lendFrom;
	private Float price;
	
	

	public String getLendTo() {
		return lendTo;
	}

	public void setLendTo(String lendTo) {
		this.lendTo = lendTo;
	}

	public String getLendFrom() {
		return lendFrom;
	}

	public void setLendFrom(String lendFrom) {
		this.lendFrom = lendFrom;
	}

	public Float getPrice() {
		return price;
	}

	public void setPrice(Float price) {
		this.price = price;
	}

	public String getPressname() {
		return pressname;
	}

	public void setPressname(String pressname) {
		this.pressname = pressname;
	}

	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getBookIsbn() {
		return bookIsbn;
	}

	public void setBookIsbn(String bookIsbn) {
		this.bookIsbn = bookIsbn;
	}

	public Date getLendTime() {
		return lendTime;
	}

	public void setLendTime(Date lendTime) {
		this.lendTime = lendTime;
	}

	public Date getReturnTime() {
		return returnTime;
	}

	public void setReturnTime(Date returnTime) {
		this.returnTime = returnTime;
	}

	public int getTimeout() {
		return timeout;
	}

	public void setTimeout(int timeout) {
		this.timeout = timeout;
	}

	public void setFine(Float fine) {
		this.fine = fine;
	}

	public Float getFine() {
		return fine;
	}

	public Integer getBookStatus() {
		return bookStatus;
	}

	public void setBookStatus(Integer bookStatus) {
		this.bookStatus = bookStatus;
	}

	public Integer getFineReason() {
		return fineReason;
	}

	public void setFineReason(Integer fineReason) {
		this.fineReason = fineReason;
	}

	public String getUserphone() {
		return userphone;
	}

	public void setUserphone(String userphone) {
		this.userphone = userphone;
	}

	public String getUserAddress() {
		return userAddress;
	}

	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}

	public String getBookCode() {
		return bookCode;
	}

	public void setBookCode(String bookCode) {
		this.bookCode = bookCode;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getBookname() {
		return bookname;
	}

	public void setBookname(String bookname) {
		this.bookname = bookname;
	}

	/**
	 * 生成订单使用
	 * 
	 * @author 祝宝亚
	 * @time 下午11:56:22
	 */
	public OrderForm(String userId, String bookIsbn, Date lendTime,
			String bookCode, String userphone, String userAddress,
			String username, String bookname, String pressname,Float price) {
		this.userId = userId;
		this.bookIsbn = bookIsbn;
		this.lendTime = lendTime;
		this.bookCode = bookCode;
		this.userphone = userphone;
		this.userAddress = userAddress;
		this.username = username;
		this.bookname = bookname;
		this.pressname = pressname;
		this.price=price;
	}

	public OrderForm(Integer orderId, String userId, String bookIsbn,
			String bookCode, Date lendTime, Date returnTime, int timeout,
			Float fine, Integer bookStatus, Integer fineReason,
			String userphone, String userAddress, String username,
			String bookname,Float price) {
		this.orderId = orderId;
		this.userId = userId;
		this.bookIsbn = bookIsbn;
		this.bookCode = bookCode;
		this.lendTime = lendTime;
		this.returnTime = returnTime;
		this.timeout = timeout;
		this.fine = fine;
		this.bookStatus = bookStatus;
		this.fineReason = fineReason;
		this.userphone = userphone;
		this.userAddress = userAddress;
		this.username = username;
		this.bookname = bookname;
		this.price=price;
	}

	/**
	 * 查询语句
	 * 
	 * @author 祝宝亚
	 * @time 下午1:28:50
	 */
	public OrderForm(String username, String userId, String bookIsbn,
			Integer bookStatus) {
		this.username = username;
		this.userId = userId;
		this.bookIsbn = bookIsbn;
		this.bookStatus = bookStatus;
	}

	public OrderForm() {

	}

	/**
	 * 后台的借书
	 * 
	 * 
	 * @author 祝宝亚
	 * @time 下午11:05:11
	 */
	public OrderForm(String userId, String bookIsbn, Integer bookStatus,
			String pressname, String lendTo, String lendFrom) {
		this.userId = userId;
		this.bookIsbn = bookIsbn;
		this.bookStatus = bookStatus;
		this.pressname = pressname;
		this.lendTo = lendTo;
		this.lendFrom = lendFrom;
	}

	/**
	 * 
	 * 更新图书所用
	 *
	 * @author 祝宝亚
	 * @time   上午12:28:34
	 */
	public OrderForm(Integer orderId, String userphone, String userAddress,
			String username,Integer bookStatus) {
		this.orderId = orderId;
		this.userphone = userphone;
		this.userAddress = userAddress;
		this.username = username;
		this.bookStatus= bookStatus;
	}

	
}
