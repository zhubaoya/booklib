package com.zby.books.model.service;

import java.util.List;

import com.zby.books.contents.StatementInserted;
import com.zby.books.contents.StatementSelected;
import com.zby.books.model.dao.BaseDaoImple;
import com.zby.books.model.po.BookCity;

/**
 * 图书所在市的服务类，即对表bookcity操作
 * 
 * @author 祝宝亚
 * @date   2018年1月26日
 *
 */
public class BookCityService extends BaseDaoImple<BookCity> {

	private String insertedBookCity=StatementInserted.INSERT_BOOK_CITY;
	
	private String selectBookCity=StatementSelected.SELECT_BOOK_CITY;
	
	/**
	 * 这是将数据添加到bookcity表中的方法
	 * 
	 * @author 祝宝亚
	 * @time   下午3:35:57 
	 * @param bookCity
	 * @return 
	 */
	public int insertBookCity(BookCity bookCity){
		return this.insert(insertedBookCity, bookCity);
	}
	
	/**
	 * 查询图书所在市
	 * 
	 * @author 祝宝亚
	 * @time   2018年3月2日 下午3:31:20 
	 * @param pid
	 * @return
	 */
	public List<BookCity> queryBookCity(BookCity bookCity){
		return this.queryObjects(selectBookCity, bookCity);
	}
}
