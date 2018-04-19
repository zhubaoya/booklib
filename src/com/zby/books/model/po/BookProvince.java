package com.zby.books.model.po;

/**
 * 
 * 这是书籍所在省份的类，对应数据库中bookprovince表。 
 * 该类用来记录具有相同isbn编号的图书所在的省份。
 * 
 * @author 祝宝亚
 * @date 2018年1月22日
 * 
 */
public class BookProvince {

	private Integer pid;
	private String pname;

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

	
	public BookProvince(String pname) {
		this.pname = pname;
	}

	public BookProvince(Integer pid, String pname) {
		this.pid = pid;
		this.pname = pname;
	}

	public BookProvince() {

	}
}
