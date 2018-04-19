package com.zby.books.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.zby.books.contents.StatementInserted;
import com.zby.books.contents.StatementSelected;
import com.zby.books.model.dao.BaseDaoImple;
import com.zby.books.model.po.BookProvince;

/**
 * 图书所在省份的服务类，即对表bookprovince操作
 * 
 * @author 祝宝亚
 * @date 2018年1月26日
 * 
 */
public class BookProvinceService extends BaseDaoImple<BookProvince> {

	private String insertedBookProvince = StatementInserted.INSERT_BOOK_PROVINCE;

	private String selectBoiokProvince = StatementSelected.SELECT_BOOK_PROVINCE;

	/**
	 * 将数据添加到图书所在省的表中
	 * 
	 * @author 祝宝亚
	 * @time 下午11:29:37
	 * @param bookProvince
	 * @return
	 */
	public int insertBookProvince(BookProvince bookProvince) {
		return this.insert(insertedBookProvince, bookProvince);
	}

	/**
	 * 查询语句
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月2日 下午3:42:26
	 * @param pid
	 * @return
	 */
	public List<BookProvince> queryBookProvince(Integer pid, String pname) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pid", pid);
		map.put("pname", pname);
		return this.queryObjects(selectBoiokProvince, map);
	}

}
