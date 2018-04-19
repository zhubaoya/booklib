package com.zby.books.model.po;

/**
 * 这是出版社类，对应着数据库press表
 * 
 * @author 祝宝亚
 * @date 2018年1月25日
 * 
 */
public class Press {
	private Integer pid;
	private String pname;
	private String address;
	private Integer postcode;
	private String phone; // 座机
	private String purchasePhone; // 购买图书的座机
	private String website; // 出版社的网址
	private String ICP; // 网站备案号

	public String getICP() {
		return ICP;
	}

	public void setICP(String iCP) {
		ICP = iCP;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Integer getPostcode() {
		return postcode;
	}

	public void setPostcode(Integer postcode) {
		this.postcode = postcode;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPurchasePhone() {
		return purchasePhone;
	}

	public void setPurchasePhone(String purchasePhone) {
		this.purchasePhone = purchasePhone;
	}

	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

	public Press(String pname, String address, Integer postcode, String phone,
			String purchasePhone, String website, String ICP) {
		this.pname = pname;
		this.address = address;
		this.postcode = postcode;
		this.phone = phone;
		this.purchasePhone = purchasePhone;
		this.website = website;
		this.ICP = ICP;
	}

	public Press(String pname, String address, Integer postcode, String phone,
			String purchasePhone, String website, String ICP, Integer pid) {
		this(pname, address, postcode, phone, purchasePhone, website, ICP);
		this.pid = pid;
	}

	
	
	public Press(Integer pid, String pname) {
		this.pid = pid;
		this.pname = pname;
	}

	public Press() {

	}

}
