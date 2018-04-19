package com.zby.books.utils.pagination;

import java.util.List;

public abstract class ImplePagination<T> implements IPagination<T> {

	private List<T> objects;

	private int records; // 数据库的多少条记录

	private int totalPages; // 总页数

	private int currentPage; // 当前第几页

	private int branches = 10; // 每页显示的条目数

	public ImplePagination() {

		initData();
	}

	public ImplePagination(int currentPage) {
		initData();
		this.currentPage = currentPage;
	}

	private void initData() {

		this.totalPages = records % 10 == 0 ? records / branches : records
				/ branches + 1;
	}

	/**
	 * 通过RowBounds来获取对应对象的列表
	 * 
	 * @author 祝宝亚
	 * @time 下午10:44:17
	 */
	protected abstract void getObjectsByRowBounds();

	/*
	 * private abstract void getBooksByRowBounds() {
	 * 
	 * SqlSession session = DBConnection.getSqlSession();
	 * 
	 * RowBounds bounds = new RowBounds((currentPage - 1) * branches, branches);
	 * 
	 * books = session.selectList(selectBooks, null, bounds);
	 * 
	 * session.close(); }
	 */

	@Override
	public boolean firstPage() {

		return currentPage == 1 ? true : false;
	}

	@Override
	public boolean hasNextPage() {

		return this.currentPage <= this.totalPages ? true : false;

	}

	@Override
	public boolean hasUpPage() {

		return this.currentPage > 0 ? true : false;

	}

	@Override
	public List<T> turnNextPage() {
		if (!hasNextPage()) {
			try {
				throw new PagingException("页数不能超过最大值");
			} catch (PagingException e) {
				e.printStackTrace();
			}
		}

		this.getObjectsByRowBounds();

		currentPage++;

		return objects;

	}

	@Override
	public List<T> turnUpPage() {

		if (!hasUpPage()) {
			try {

				throw new PagingException("总页数不能少于0");

			} catch (PagingException e) {
				e.printStackTrace();
			}
		}

		this.getObjectsByRowBounds();

		currentPage--;

		return objects;

	}

	@Override
	public int getTotalPage() {

		return this.totalPages;

	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getBranches() {
		return branches;
	}

	public void setBranches(int branches) {
		this.branches = branches;
	}

	public List<T> getObjects() {
		return objects;
	}

	public void setObjects(List<T> objects) {
		this.objects = objects;
	}

	public int getRecords() {
		return records;
	}

	public void setRecords(int records) {
		this.records = records;
	}

	/**
	 * 通过物理分页获取数据
	 * 
	 * @author 祝宝亚
	 * @time 下午10:45:58
	 * @param param
	 * @return
	 */
	public abstract List<T> getBooksByParam(int param);
	
	/*public List<Book> getBooksByParam(int param) {

		SqlSession session = DBConnection.getSqlSession();

		RowBounds bounds = new RowBounds((param - 1) * branches, branches);

		List<Book> bookList = session.selectList(selectBooks, null, bounds);

		session.close();

		return bookList;
	}*/

}
