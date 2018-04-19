package com.zby.books.model.po;

/**
 * 
 * 这是图书类型的类，对应数据库中的genres表
 * 
 * @author 祝宝亚
 * @date 2018年1月22日
 * 
 */
public class Genres {

	private Integer gid;
	private String gname;
	private Integer tid; // 图书标签编号

	public Integer getGid() {
		return gid;
	}

	public void setGid(Integer gid) {
		this.gid = gid;
	}

	public String getGname() {
		return gname;
	}

	public void setGname(String gname) {
		this.gname = gname;
	}

	public Integer getTid() {
		return tid;
	}

	public void setTid(Integer tid) {
		this.tid = tid;
	}

	public Genres(String gname, Integer tid) {
		this.gname = gname;
		this.tid = tid;
	}

	/**
	 * 查询所用
	 * 
	 * @author 祝宝亚
	 * @time 下午5:31:39
	 */
	public Genres(String gname, Integer tid, Integer gid) {
		this(gname, tid);
		this.gid = gid;
	}

	public Genres() {

	}

}
