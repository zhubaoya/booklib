package com.zby.books.model.po;

/**
 * 
 * 这是图书标签类，对应数据中的tag表
 * 
 * @author 祝宝亚
 * @date 2018年1月22日
 * 
 */
public class Tag {

	private Integer tid;
	private String tname;

	public Integer getTid() {
		return tid;
	}

	public void setTid(Integer tid) {
		this.tid = tid;
	}

	public String getTname() {
		return tname;
	}

	public void setTname(String tname) {
		this.tname = tname;
	}

	public Tag(String tname){
		this.tname=tname;
	}
	
	public Tag(Integer tid, String tname) {
		this.tid = tid;
		this.tname = tname;
	}

	public Tag() {

	}
}
