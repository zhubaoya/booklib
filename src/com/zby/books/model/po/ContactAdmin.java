package com.zby.books.model.po;


/**
 * 
 * 这是联系后台管理员类，对应数据库中的contactadmin表
 * 
 * @author 祝宝亚
 * @date 2018年1月22日
 * 
 */
public class ContactAdmin {

	private Integer caid;
	private String name;
	private String phone; // 用户手机号
	private String content; // 反馈内容
	private Integer status; // 反馈信息的状态
	private String pressName;  //出版社的名字

	public String getPressName() {
		return pressName;
	}

	public void setPressName(String pressName) {
		this.pressName = pressName;
	}

	public Integer getCaid() {
		return caid;
	}

	public void setCaid(Integer caid) {
		this.caid = caid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	/**
	 * 添加联系后台管理员的构造器
	 *
	 * @author 祝宝亚
	 * @time   下午9:43:29
	 */
	public ContactAdmin(String name, String phone, String content,String pressName) {
		this.name = name;
		this.phone = phone;
		this.content = content;
		this.pressName=pressName;
	}

	/**
	 * 更新的构造器
	 *
	 * @author 祝宝亚
	 * @time   下午9:43:55
	 */
	public ContactAdmin(Integer caid, Integer status) {
		this.caid = caid;
		this.status = status;
	}

	public ContactAdmin( String name, String phone,
			String content,String pressName,Integer caid, int status) {
		this(name,phone,content,pressName);
		this.caid = caid;
		this.status = status;
	}

	
	public ContactAdmin() {
	
	}

	/**
	 * 查询
	 * 
	 *
	 * @author 祝宝亚
	 * @time   下午5:18:17
	 */
	public ContactAdmin(Integer status, String pressName,Integer caid) {
		this.status = status;
		this.pressName = pressName;
		this.caid = caid;
	}
	
	

}
