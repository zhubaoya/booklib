package com.zby.books.configuration;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

/**
 * 用来读取mybatis-configuration.xml数据，并创建SQLSession的类
 * 
 * 
 * @author 祝宝亚
 * @date 2018年1月22日
 * 
 */
public class MySqlSessionBuilder {

	private static String mybatisConfiguration = "mybatis-configuration.xml";

	/**
	 * 这是一个用来创建类SqlSessionFactory的方法
	 * 
	 * @author 祝宝亚
	 * @time 下午6:05:20
	 * @return
	 */
	private static SqlSessionFactory createSqlSessionFactory() {

		try {
			InputStream resource = Resources
					.getResourceAsStream(mybatisConfiguration);
			return new SqlSessionFactoryBuilder().build(resource);
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 
	 * 通过SqlSession 获取studentmapper.xml文件中的id值来获取SQL语句，执行SQL语句
	 * 
	 * getsqlSessionFactory().openSession(autoCommit)   
	 * 
	 * 如果autoCommit为null或false，即手动提交事务
	 * 如果autoCommit为true，即自动提交事务
	 * 
	 * @author 祝宝亚
	 * @time   下午6:15:23 
	 * @return
	 */
	public static SqlSession createSqlSession(){
		return createSqlSessionFactory().openSession(false);
	}
	
}
