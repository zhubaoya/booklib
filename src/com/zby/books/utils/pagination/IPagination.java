package com.zby.books.utils.pagination;

import java.util.List;


/**
 * 
 * 分页的接口
 * 
 * @author 祝宝亚
 * @date   2018年1月21日
 *
 */
public interface IPagination<T> {

	/**
	 * 第一页的数据
	 * 
	 * @author 祝宝亚
	 * @time   下午10:49:04 
	 * @return
	 */
	public boolean firstPage();
	
	/**
	 * 是否有下一页
	 * 
	 * @author 祝宝亚
	 * @time   下午10:49:21 
	 * @return
	 */
	public boolean hasNextPage();
	
	/**
	 * 是否有上一页
	 * 
	 * @author 祝宝亚
	 * @time   下午10:49:40 
	 * @return
	 */
	public boolean hasUpPage();
	
	/**
	 * 下一页的数据
	 * 
	 * @author 祝宝亚
	 * @time   下午10:49:52 
	 * @return
	 */
	public List<T> turnNextPage();
	
	/**
	 * 上一页的数据
	 * 
	 * @author 祝宝亚
	 * @time   下午10:50:14 
	 * @return
	 */
	public List<T> turnUpPage();
	
	/**
	 * 获取总页数
	 * 
	 * @author 祝宝亚
	 * @time   下午10:50:31 
	 * @return
	 */
	public int getTotalPage();
}
