package com.zby.books.model.po;

/**
 * 这是书籍类，对应着数据库中的book表
 * 
 * @author 祝宝亚
 * @date 2018年1月22日
 * 
 */
public class Book {

	private Integer bid;
	private String bisbn;
	private String authorName;
	private Integer genresId; // 图书类型编号
	private String bname;
	private Float bprice;
	private Integer pressId;
	private String publication; // 出版日期
	private Integer bstatus; // 图书状态
	private Integer bnumber;
	private String bimg; // 书籍背景图
	private String babstract; // 书籍简介
	private float earnest; // 定金
	private int borrowedTime; // 借阅次数
	private int clickedTime; // 点击次数

	// 后台排序所用
	private String publicationFrom;
	private String publicationTo;
	private String orderType;

	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}

	public String getPublicationFrom() {
		return publicationFrom;
	}

	public void setPublicationFrom(String publicationFrom) {
		this.publicationFrom = publicationFrom;
	}

	public String getPublicationTo() {
		return publicationTo;
	}

	public void setPublicationTo(String publicationTo) {
		this.publicationTo = publicationTo;
	}

	public int getBorrowedTime() {
		return borrowedTime;
	}

	public void setBorrowedTime(int borrowedTime) {
		this.borrowedTime = borrowedTime;
	}

	public int getClickedTime() {
		return clickedTime;
	}

	public void setClickedTime(int clickedTime) {
		this.clickedTime = clickedTime;
	}

	public Integer getBid() {
		return bid;
	}

	public void setBid(Integer bid) {
		this.bid = bid;
	}

	public String getBisbn() {
		return bisbn;
	}

	public void setBisbn(String bisbn) {
		this.bisbn = bisbn;
	}

	public String getAuthorName() {
		return authorName;
	}

	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}

	public Integer getGenresId() {
		return genresId;
	}

	public void setGenresId(Integer genresId) {
		this.genresId = genresId;
	}

	public String getBname() {
		return bname;
	}

	public void setBname(String bname) {
		this.bname = bname;
	}

	public Float getBprice() {
		return bprice;
	}

	public void setBprice(Float bprice) {
		this.bprice = bprice;
	}

	public Integer getPressId() {
		return pressId;
	}

	public void setPressId(Integer pressId) {
		this.pressId = pressId;
	}

	public String getPublication() {
		return publication;
	}

	public void setPublication(String publication) {
		this.publication = publication;
	}

	public Integer getBstatus() {
		return bstatus;
	}

	public void setBstatus(Integer bstatus) {
		this.bstatus = bstatus;
	}

	public Integer getBnumber() {
		return bnumber;
	}

	public void setBnumber(Integer bnumber) {
		this.bnumber = bnumber;
	}

	public String getBimg() {
		return bimg;
	}

	public void setBimg(String bimg) {
		this.bimg = bimg;
	}

	public String getBabstract() {
		return babstract;
	}

	public void setBabstract(String babstract) {
		this.babstract = babstract;
	}

	public float getEarnest() {
		return earnest;
	}

	public void setEarnest(float earnest) {
		this.earnest = earnest;
	}

	public Book(String bisbn, String authorName, Integer genresId,
			String bname, Float bprice, Integer pressId, String publication,
			Integer bnumber, String bimg, String babstract, float earnest) {
		this.bisbn = bisbn;
		this.authorName = authorName;
		this.genresId = genresId;
		this.bname = bname;
		this.bprice = bprice;
		this.pressId = pressId;
		this.publication = publication;
		this.bnumber = bnumber;
		this.bimg = bimg;
		this.babstract = babstract;
		this.earnest = earnest;
	}

	public Book(String bisbn, String authorName, Integer genresId,
			String bname, Float bprice, Integer pressId, String publication,
			Integer bnumber, String bimg, String babstract, float earnest,
			Integer bid, Integer bstatus, int borrowedTime, int clickedTime) {
		this(bisbn, authorName, genresId, bname, bprice, pressId, publication,
				bnumber, bimg, babstract, earnest);
		this.bid = bid;
		this.bstatus = bstatus;
		this.borrowedTime = borrowedTime;
		this.clickedTime = clickedTime;
	}

	/**
	 * 更新图书所用的构造器
	 * 
	 * @author 祝宝亚
	 * @time 下午4:35:17
	 */
	public Book(String bisbn, String authorName, Float bprice, Integer bstatus,
			String babstract, float earnest) {
		this.bisbn = bisbn;
		this.authorName = authorName;
		this.bprice = bprice;
		this.bstatus = bstatus;
		this.babstract = babstract;
		this.earnest = earnest;
	}

	/**
	 * 多处查询使用的
	 * 
	 * @author 祝宝亚
	 * @time 下午4:08:00
	 */
	public Book(Integer bid, String bisbn, String authorName, String bname,
			Integer bstatus, Integer pressId) {
		this.bid = bid;
		this.bisbn = bisbn;
		this.authorName = authorName;
		this.bname = bname;
		this.bstatus = bstatus;
		this.pressId = pressId;
	}

	public Book() {

	}

	public Book(String bisbn, String authorName) {
		this.bisbn = bisbn;
		this.authorName = authorName;
	}

	public Book(Integer genresId) {
		this.genresId = genresId;
	}

	/**
	 * 后台查询即排序
	 * 
	 * 
	 * @author 祝宝亚
	 * @time 下午2:24:36
	 */
	public Book(String authorName, String bname, Integer bstatus,
			String publicationFrom, String publicationTo, Integer pressId,String orderType) {
		this.authorName = authorName;
		this.bname = bname;
		this.bstatus = bstatus;
		this.publicationFrom = publicationFrom;
		this.publicationTo = publicationTo;
		this.pressId = pressId;
		this.orderType=orderType;
	}

}
