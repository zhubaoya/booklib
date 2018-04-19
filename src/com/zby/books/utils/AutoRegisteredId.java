package com.zby.books.utils;

import java.util.UUID;

/**
 * 自动生成用户注册的编号（userID）类
 * 
 * @author 祝宝亚
 * 
 * @date   2018年1月21日
 *
 */
public class AutoRegisteredId {

	
	private StringBuilder completeId;    //用户完整的注册id
	
	/**
	 * 该构造器初始化对象：completeId
	 *
	 * @author 祝宝亚
	 * @time   下午11:30:27
	 */
	public AutoRegisteredId(){
		completeId=new StringBuilder();
		this.integrateRegisteredId();
	}
	
	/**
	 * 创建注册时无序的编号列表
	 * 
	 * @author 祝宝亚
	 * @time   下午11:14:55 
	 * 
	 * @return
	 */
	private String[] createUnorderedIds(){
		return UUID.randomUUID().toString().split("-");
	}
	
	/**
	 * 
	 * 对无序的编号列表进行排序，并整合成一条字符串
	 * 
	 * @author 祝宝亚
	 * @time   下午11:20:46 
	 */
	private void integrateRegisteredId(){

		for(String id:createUnorderedIds()){
			completeId.append(id);
		}		
	}
	
	/**
	 * 获取注册的id编号
	 * 
	 * @author 祝宝亚
	 * @time   下午11:33:27 
	 * @return
	 */
	public String getRegisteredId(){
		return "bL_"+completeId.toString().substring(0,23);
	}
	
}
