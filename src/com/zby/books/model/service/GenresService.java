package com.zby.books.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.zby.books.contents.StatementInserted;
import com.zby.books.contents.StatementSelected;
import com.zby.books.model.dao.BaseDaoImple;
import com.zby.books.model.po.Genres;

/**
 * 这是图书类型的服务类，即对表genres操作
 * 
 * @author 祝宝亚
 * @date   2018年1月26日
 *
 */
public class GenresService extends BaseDaoImple<Genres> {

	private String insertedGenres=StatementInserted.INSERT_GENRES;
	
	private String selectGenres=StatementSelected.SELECT_GENRES;
	
	/**
	 * 将数据添加到图书类型当中。
	 * 
	 * @author 祝宝亚
	 * @time   2018年1月28日 下午10:33:04 
	 * @param genres
	 * @return
	 */
	public int insertGenres(Genres genres){
		return this.insert(insertedGenres, genres);
	}
	
	/**
	 * 查询
	 * 
	 * @author 祝宝亚
	 * @time   2018年3月2日 下午4:48:49 
	 * @param tid
	 * @return
	 */
	public List<Genres> queryGenress(Genres genres){
		return this.queryObjects(selectGenres, genres);
	}
	
	/**
	 * 通过genres查找
	 * 
	 * @author 祝宝亚
	 * @time   2018年3月9日 下午5:30:00 
	 * @param genres
	 * @return
	 */
	public Genres queryGenres(Genres genres){
		return this.queryOneObject(selectGenres, genres);
	}
	
}
