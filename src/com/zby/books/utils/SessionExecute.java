package com.zby.books.utils;

import org.apache.ibatis.session.SqlSession;

/**
 * 
 * 这是执行mybatis数据库的事务操作的类，若只涉及到查询的事务，
 * 则不用提交事务；若事务涉及到增加、删除、修改，则需提交事务。
 * 
 * @author 祝宝亚
 * @date   2018年1月22日
 *
 */
public class SessionExecute {

	/**
	 * 
	 * 如果mybatis框架的SqlSession仅
	 * 涉及到查询事务，那么执行该方法。
	 * 
	 * @author 祝宝亚
	 * @time   下午4:13:02 
	 * @param session
	 */
	public static void executeClose(SqlSession session){
		if(session!=null){
			session.close();
		}
	}
	
	/**
	 * 如果如果mybatis框架的SqlSession涉及到
	 * 增加、删除、修改事务时，就执行该方法。
	 * 
	 * @author 祝宝亚
	 * @time   下午4:15:28 
	 * @param session
	 */
	public static void executeCommitClose(SqlSession session){
		if(session!=null){
			session.commit();
			session.close();
		}
	}
}
