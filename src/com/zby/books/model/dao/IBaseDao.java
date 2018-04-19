package com.zby.books.model.dao;

import java.util.List;

/**
 * 这是操作数据库的接口
 * 
 * @author 祝宝亚
 * @date   2018年1月22日
 *
 */
public interface IBaseDao<T> {

	/**
	 * 从数据库中查询数据，以一个javabean对象的方式返回查询的结果
	 * 
	 * @author 祝宝亚
	 * @time   下午9:07:58 
	 * @param mapper  配置文件的id字符串
	 * @param param   &nbsp;&nbsp;查询参数
	 * @return 查询的一个对象
	 */
	 T queryOneObject(String mapper,Object param);
	
	 /**
	  * 从数据中查询数据，以一个数据的方式返回
	  * 
	  * @author 祝宝亚
	  * @time   下午9:09:35 
	  * @param mapper 配置文件的id字符串
	  * @param param  &nbsp;&nbsp;查询参数
	  * @return 查询的一个数据
	  */
	 Object queryOneData(String mapper,Object param);
	 
	 /**
	  * 以列表的方式返回javabean对象集
	  * 
	  * @author 祝宝亚
	  * @time   下午9:11:10 
	  * @param mapper 配置文件的id字符串
	  * @param param  &nbsp;&nbsp;查询参数
	  * @return 查询的对象集
	  */
	 List<T> queryObjects(String mapper,Object param);
	 
	 /**
	  * 以列表的方式返回数据集
	  * @author 祝宝亚
	  * @time   下午9:12:25 
	  * @param mapper 配置文件的id字符串
	  * @param param  &nbsp;&nbsp;查询参数
	  * @return 查询的数据集
	  */
	 List<Object> queryDatas(String mapper,Object param);
	 
	 /**
	  * 以javabean对象的方式插入一条数据
	  * 
	  * @author 祝宝亚
	  * @time   下午9:14:54 
	  * @param mapper 配置文件的id字符串
	  * @param t &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;javabean对象
	  * @return 插入成功？1：null
	  */
	int insert(String mapper,T t);
	
	/**
	 * 批处理插入数据
	 * 
	 * @author 祝宝亚
	 * @time   下午9:17:11 
	 * @param mapper 配置文件的id字符串
	 * @param list  &nbsp;&nbsp;&nbsp;&nbsp;Javabean对象集 
	 * @return 一次插入多少条语句
	 */
	int betchInsert(String mapper,List<T> list);
	
	/**
	 * 更新一条语句
	 * 
	 * @author 祝宝亚
	 * @time   下午9:18:00 
	 * @param mapper 配置文件的id字符串
	 * @param param  &nbsp;&nbsp;更新参数
	 * @return 更新成功？1：null
	 */
	int update(String mapper,Object param);
	
	/**
	 * 批处理更新语句
	 * 
	 * @author 祝宝亚
	 * @time   下午9:19:06 
	 * @param mapper 配置文件的id字符串
	 * @param param  &nbsp;&nbsp;更新参数
	 * @return 一次更新多少条语句
	 */
	int betchUpdate(String mapper,Object param);
	
	/**
	 * 删除一条语句
	 * 
	 * @author 祝宝亚
	 * @time   下午9:19:39 
	 * @param mapper 配置文件的id字符串
	 * @param param  &nbsp;&nbsp;删除参数
	 * @return 删除成功？1：null
	 */
	int delete(String mapper,Object param);
	
	/**
	 * 批处理删除语句
	 * 
	 * @author 祝宝亚
	 * @time   下午9:20:21 
	 * @param mapper 配置文件的id字符串
	 * @param params 删除参数
	 * @return 一次删除多少条语句
	 */
	int betchDelete(String mapper,Object...params);
	
}
