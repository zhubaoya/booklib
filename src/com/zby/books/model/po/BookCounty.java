package com.zby.books.model.po;

/**
 * 这是图书所在县级市的类，对应数据库中bookcounty表。 该类用来记录具有相同isbn编号的图书所在的县级市。
 * 
 * @author 祝宝亚
 * @date 2018年1月22日
 * 
 */
public class BookCounty {

	private Integer id;
	private String name;
	private Integer cid; // 市名编号

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getCid() {
		return cid;
	}

	public void setCid(Integer cid) {
		this.cid = cid;
	}

	public BookCounty(String name, Integer cid) {
		this.name = name;
		this.cid = cid;
	}

	public BookCounty(String name, Integer cid, Integer id) {
		this(name, cid);
		this.id = id;
	}

	public BookCounty() {

	}

}
