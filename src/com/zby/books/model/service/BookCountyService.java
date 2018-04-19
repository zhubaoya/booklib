package com.zby.books.model.service;

import java.util.List;

import com.zby.books.contents.StatementInserted;
import com.zby.books.contents.StatementSelected;
import com.zby.books.model.dao.BaseDaoImple;
import com.zby.books.model.po.BookCounty;

/**
 * 这是图书所在县的服务类，即对表bookcounty操作
 * 
 * @author 祝宝亚
 * @date 2018年1月26日
 * 
 */
public class BookCountyService extends BaseDaoImple<BookCounty> {

	private String insertedBookCounty = StatementInserted.INSERT_BOOK_COUNTY;

	private String SelectBookCounty = StatementSelected.SELECT_BOOK_COUNTY;

	/**
	 * 将数据添加到图书所在县的bookcounty表中
	 * 
	 * @author 祝宝亚
	 * @time 2018年1月28日 下午3:47:36
	 * @param bookCounty
	 * @return
	 */
	public int insertBookCounty(BookCounty bookCounty) {
		return this.insert(insertedBookCounty, bookCounty);
	}

	/**
	 * 查询图书所在县级市
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月2日 下午3:36:45
	 * @param bookCounty
	 * @return
	 */
	public List<BookCounty> queryBookCounty(BookCounty bookCounty) {
		return this.queryObjects(SelectBookCounty, bookCounty);
	}

}
