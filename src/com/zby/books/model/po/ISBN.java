package com.zby.books.model.po;

import javax.persistence.criteria.CriteriaBuilder.In;

/**
 * 
 * 这是图书isbn编号的类，对应数据库中isbn表。 
 * 该类可以对相同isbn编号的图书进行图书编号 用来对确定某本书在具体的什么地方。
 * 
 * @author 祝宝亚
 * @date 2018年1月22日
 * 
 */
public class ISBN {

	private Integer id;
	private String bookPlace; // 书籍所在地
	private String bookCode; // 图书编码
	private String isbn;
	private Integer status;             // 该编码图书的状态
	private Integer intactSituation;    //图书完整情况
	private String maxCode;        //这本图书的最大编码
	
	public String getBookPlace() {
		return bookPlace;
	}

	public Integer getIntactSituation() {
		return intactSituation;
	}

	public void setIntactSituation(Integer intactSituation) {
		this.intactSituation = intactSituation;
	}

	public void setBookPlace(String bookPlace) {
		this.bookPlace = bookPlace;
	}

	public String getBookCode() {
		return bookCode;
	}

	public void setBookCode(String bookCode) {
		this.bookCode = bookCode;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getMaxCode() {
		return maxCode;
	}

	public void setMaxCode(String maxCode) {
		this.maxCode = maxCode;
	}
	
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public ISBN( String bookCode,String isbn,String bookPlace) {
		this.bookCode = bookCode;
		this.isbn = isbn;
		this.bookPlace = bookPlace;			
	}

	/**
	 * 更新图书信息
	 *
	 * @author 祝宝亚
	 * @time   上午11:04:00
	 */
	public ISBN(String bookPlace, String bookCode, Integer status,
			Integer intactSituation) {
		this.bookPlace = bookPlace;
		this.bookCode = bookCode;
		this.status = status;
		this.intactSituation = intactSituation;
	}

	public ISBN(String bookCode,String isbn,String bookPlace, Integer id,
			Integer status,Integer intactSituation,String maxCode) {
		this(bookCode, isbn,bookPlace);
		this.id = id;
		this.status = status;
		this.intactSituation=intactSituation;
		this.maxCode=maxCode;
	}

	/**
	 * 查询使用
	 *
	 * @author 祝宝亚
	 * @time   下午4:56:44
	 */
	public ISBN(String bookPlace, String bookCode, String isbn, Integer status,
			Integer intactSituation) {
		this.bookPlace = bookPlace;
		this.bookCode = bookCode;
		this.isbn = isbn;
		this.status = status;
		this.intactSituation = intactSituation;
	}

	public ISBN() {

	}
}
