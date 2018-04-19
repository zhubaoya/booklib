package com.zby.books.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.zby.books.configuration.MySqlSessionBuilder;
import com.zby.books.utils.SessionExecute;

/**
 * 
 * 实现对数据库操作的接口
 * 
 * @author 祝宝亚
 * @date   2018年1月24日
 *
 * @param <T>
 */
public class BaseDaoImple<T> implements IBaseDao<T> {

	private SqlSession session;  //数据库会话
	
	public BaseDaoImple() {
		session=MySqlSessionBuilder.createSqlSession();
	}
	
	@Override
	public T queryOneObject(String mapper, Object param) {
		T t=session.selectOne(mapper, param);
		SessionExecute.executeClose(session);		
		return t;
	}

	@Override
	public Object queryOneData(String mapper, Object param) {
		Object obj=session.selectOne(mapper, param);
		SessionExecute.executeClose(session);		
		return obj;
	}

	@Override
	public List<T> queryObjects(String mapper, Object param) {
		List<T> list=session.selectList(mapper, param);
		SessionExecute.executeClose(session);
		return list;
	}

	@Override
	public List<Object> queryDatas(String mapper, Object param) {
		List<Object> list=session.selectList(mapper, param);
		SessionExecute.executeClose(session);
		return list;
	}

	@Override
	public int insert(String mapper, T t) {
		int result=session.insert(mapper, t);
		SessionExecute.executeCommitClose(session);
		return result;
	}

	@Override
	public int betchInsert(String mapper, List<T> list) {
		int result=session.insert(mapper,list);
		SessionExecute.executeCommitClose(session);
		return result;
	}

	@Override
	public int update(String mapper, Object param) {
		int result=session.update(mapper, param);
		SessionExecute.executeCommitClose(session);
		return result;
	}

	@Override
	public int betchUpdate(String mapper, Object param) {
		return 0;
	}

	@Override
	public int delete(String mapper, Object param) {
		int result=session.delete(mapper, param);
		SessionExecute.executeCommitClose(session);
		return result;
	}

	@Override
	public int betchDelete(String mapper, Object... params) {	
		return 0;
	}

}
