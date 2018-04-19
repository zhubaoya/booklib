package com.zby.books.model.service;

import java.util.List;

import com.zby.books.contents.StatementDeleted;
import com.zby.books.contents.StatementInserted;
import com.zby.books.contents.StatementSelected;
import com.zby.books.contents.StatementUpdated;
import com.zby.books.model.dao.BaseDaoImple;
import com.zby.books.model.po.Book;

/**
 * 这是图书的服务类，即对表book操作
 * 
 * @author 祝宝亚
 * @date 2018年1月26日
 * 
 */
public class BookService extends BaseDaoImple<Book> {

	private String insertedbook = StatementInserted.INSERT_BOOK;

	private String updateBook = StatementUpdated.UPDATE_BOOK;

	private String updateBookNumber = StatementUpdated.UPDATE_BOOK_NUMBER;

	private String selectBook = StatementSelected.SELECT_BOOK;

	private String deleteBook = StatementDeleted.DELETE_BOOK;

	private String selectBookByPressId = StatementSelected.SELECT_BOOK_BY_PRESSID;

	private String updateBookBorrowedTime=StatementUpdated.UPDATE_BOOK_BORROWED_TIME;
	
	private String updateBookClickedTime=StatementUpdated.UPDATE_BOOK_CLICKED_TIME;
	
	private String updateBookNumberPlus=StatementUpdated.UPDATE_BOOK_NUMBER_PLUSPLUS;
	
	private String queryBookOrder=StatementSelected.SELECT_BOOK_ORDER;
	
	/**
	 * 这是将数据添加到书籍表中，可用于添加书籍
	 * 
	 * @author 祝宝亚
	 * @time 下午10:07:22
	 * @param book
	 * @return
	 */
	public int insertBook(Book book) {
		return this.insert(insertedbook, book);
	}

	/**
	 * 更新图书信息
	 * 
	 * @author 祝宝亚
	 * @time 2018年2月3日 下午4:29:33
	 * @param book
	 * @return
	 */
	public int updateBook(Book book) {
		return this.update(updateBook, book);
	}

	/**
	 * 仅仅更新图书的数量
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月12日 下午11:36:04
	 * @param bisbn
	 * @return
	 */
	public int updateBookNumber(String bisbn) {
		return this.update(updateBookNumber, bisbn);
	}

	/**
	 * 图书数量加1
	 * 
	 * @author 祝宝亚
	 * @time   2018年3月24日 下午5:02:52 
	 * @param bisbn
	 * @return
	 */
	public int updateBookNumberPlus(String bisbn){
		return this.update(updateBookNumberPlus, bisbn);
	}
	
	/**
	 * 更新图书的借阅次数
	 * 
	 * @author 祝宝亚
	 * @time   2018年3月15日 下午12:58:08 
	 * @param isbn
	 * @return
	 */
	public int updateBookBorrowedTime(String isbn){
		return this.update(updateBookBorrowedTime, isbn);
	}
	
	/**
	 * 更新图书的点击次数
	 * 
	 * @author 祝宝亚
	 * @time   2018年3月15日 下午12:59:26 
	 * @param isbn
	 * @return
	 */
	public int updateBookClickedTime(String isbn){
		return this.update(updateBookClickedTime, isbn);
	}
	
	
	/**
	 * 查询对象集
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月2日 下午3:54:57
	 * @param book
	 * @return
	 */
	public List<Book> queryBooks(Book book) {
		return this.queryObjects(selectBook, book);
	}

	/**
	 * 通过pressid查询book对象集
	 * 
	 * @author 祝宝亚
	 * @time   2018年3月13日 下午11:02:24 
	 * @param  pname
	 * @return
	 */
	public List<Book> queryBooksByPress(String pname){
		return this.queryObjects(selectBookByPressId, pname);
	}
	
	/**
	 * 查询一本书
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月2日 下午3:55:42
	 * @param book
	 * @return
	 */
	public Book queryBook(Book book) {
		return this.queryOneObject(selectBook, book);
	}

	/**
	 * 删除操作
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月3日 下午10:48:33
	 * @param bisbn
	 * @return
	 */
	public int deleteBook(String bisbn) {
		return this.delete(deleteBook, bisbn);
	}
	
	/**
	 * 查询和排序
	 * 
	 * @author 祝宝亚
	 * @time   2018年4月1日 下午2:26:35 
	 * @param book
	 * @return
	 */
	public List<Book> queryBookOrder(Book book){
		return this.queryObjects(queryBookOrder, book);
	}
}
