package com.zby.books.model.service;

import java.util.ArrayList;
import java.util.List;

import com.zby.books.contents.StatementDeleted;
import com.zby.books.contents.StatementInserted;
import com.zby.books.contents.StatementSelected;
import com.zby.books.contents.StatementUpdated;
import com.zby.books.model.dao.BaseDaoImple;
import com.zby.books.model.po.ISBN;

/**
 * 这是isbn的服务类，即对表isbn操作
 * 
 * @author 祝宝亚
 * @date 2018年1月26日
 * 
 */
public class ISBNService extends BaseDaoImple<ISBN> {

	private String insertedISBN = StatementInserted.INSERT_ISBN;

	private String updateISBN = StatementUpdated.UPDATE_ISBN;

	private String selectISBN = StatementSelected.SELECT_ISBN;

	private String selectMaxBookcode = StatementSelected.SELECT_MAX_BOOKCODE;

	private String deleteISBNByISBN = StatementDeleted.DELETE_ISBN_by_ISBN;

	private String deleteISBNByBookCode = StatementDeleted.DELETE_ISBN_BY_BOOKCODE;

	private ISBN iSBN = null; // 需要添加的图书

	private List<ISBN> isbns = null; // 一共需要添加多少本书

	private int bookTotalNum; // 书的总量,来自前端的图书数量

	private Integer maxCode; // 书下标的最大值，也就是初始值

	private String bookPalce;

	/**
	 * 
	 * @author 祝宝亚
	 * @time 下午5:50:48
	 * @param bookTotalNum
	 *            图书的数量
	 */
	public ISBNService(Integer maxCode, int bookTotalNum) {
		this.bookTotalNum = bookTotalNum;
		this.maxCode = maxCode;
		isbns = new ArrayList<ISBN>();
	}

	public ISBNService() {

	}

	/**
	 * 一次添加多少数据
	 * 
	 * @author 祝宝亚
	 * @time 2018年1月28日 下午6:19:54
	 * @param oneBetchData
	 *            一次添加多少天数据
	 */
	private void AddISBNs(String bookPlace, String isbn) {

		if (maxCode == null) {
			for (int i = 1; i <= bookTotalNum; i++) {
				String bookCode = getIndex(isbn, i);
				iSBN = new ISBN(bookCode, isbn, bookPlace);
				isbns.add(iSBN);
			}
			return;
		}
		for (int i = maxCode + 1; i <= maxCode + bookTotalNum; i++) {
			String bookCode = getIndex(isbn, i);
			iSBN = new ISBN(bookCode, isbn, bookPlace);
			isbns.add(iSBN);
		}
	}

	/**
	 * 将整数i转化为字符串i
	 * 
	 * @author 祝宝亚
	 * @time 2018年1月28日 下午8:36:00
	 * @param i
	 * @return
	 */
	private String getIndex(String isbn, int i) {
		if (i < 10) {
			return isbn + "_000" + i;
		}
		if (i >= 10 && i < 100) {
			return isbn + "_00" + i;
		}
		return null;
	}

	/**
	 * 将数据添加到isbn表中
	 * 
	 * @author 祝宝亚
	 * @time 2018年1月28日 下午4:10:29
	 * @param isbn
	 * @return
	 */
	public int insertBetchISBN(String bookPlace, String isbn) {
		this.AddISBNs(bookPlace, isbn);
		return this.betchInsert(insertedISBN, isbns);
	}

	/**
	 * 更新图书信息
	 * 
	 * @author 祝宝亚
	 * @time 2018年2月4日 上午11:08:56
	 * @param isbn
	 * @return
	 */
	public int updateISBN(ISBN isbn) {
		return this.update(updateISBN, isbn);
	}

	/**
	 * 查找
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月2日 下午5:06:06
	 * @param isbn
	 * @return
	 */
	public List<ISBN> queryISBN(ISBN isbn) {
		return this.queryObjects(selectISBN, isbn);
	}

	/**
	 * 查询isbn表中的bookcode的最大值
	 * 
	 * @author 祝宝亚
	 * @time   2018年3月17日 下午1:56:04 
	 * @param isbn
	 * @return
	 */
	public Integer queryMaxBookcode(String isbn) {
		String bookCode=(String) this.queryOneData(selectMaxBookcode, isbn);
		return Integer.parseInt(bookCode.substring(bookCode.length()-4, bookCode.length()));
	}

	/**
	 * 通过isbn删除操作
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月3日 下午10:54:30
	 * @param isbn
	 * @return
	 */
	public int deleteISBNByISBN(String isbn) {
		return this.delete(deleteISBNByISBN, isbn);
	}

	/**
	 * 通过bookcode删除该图书的某本书
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月3日 下午11:09:17
	 * @param bookCode
	 * @return
	 */
	public int deleteISBNByBookCode(String bookCode) {
		return this.delete(deleteISBNByBookCode, bookCode);
	}
}
