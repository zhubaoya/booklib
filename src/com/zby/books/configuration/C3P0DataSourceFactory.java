package com.zby.books.configuration;

import org.apache.ibatis.datasource.unpooled.UnpooledDataSourceFactory;

import com.mchange.v2.c3p0.ComboPooledDataSource;

/**
 * 连接c3p0的工厂类
 * 
 * @author 祝宝亚
 * @date   2018年1月22日
 *
 */
public class C3P0DataSourceFactory extends UnpooledDataSourceFactory {

	public C3P0DataSourceFactory() {
		this.dataSource=new ComboPooledDataSource();
	}
}
