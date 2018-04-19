package com.zby.books.model.po;

/**
 * 这是书籍所在地的属于某个省的直辖市，对应数数据库bookcity表。 
 * 该类用来记录具有相同的isbn编号的图书，存放在不同的直辖市。
 * 
 * @author 祝宝亚
 * @date 2018年1月22日
 * 
 */
public class BookCity {

	private Integer cid;
	private String cname;
	private Integer pid; // 省份的编号

	public Integer getCid() {
		return cid;
	}

	public void setCid(Integer cid) {
		this.cid = cid;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	
	public BookCity(String cname, Integer pid) {
		this.cname = cname;
		this.pid = pid;
	}

	public BookCity( String cname, Integer pid,Integer cid) {
		this(cname,pid);
		this.cid = cid;
	}

	public BookCity() {

	}
}
