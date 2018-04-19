package com.zby.books.utils;

import java.util.Arrays;

/**
 * 过滤数据中的空格
 * 
 * @author 祝宝亚
 * @date   2018年1月22日
 *
 */
public class SpaceFilter {
	
	/**
	 * 过滤数据的方法
	 * 
	 * @author 祝宝亚
	 * @time   下午3:57:07 
	 * @param params
	 * @return
	 */
	public static final String[] filterSpace(String...params){
		
		String[] strArray=new String[params.length];
		
		int capacity=0;
		
		for(String str:params){
			strArray[capacity++]=str.replace(" ", "");
		}
		return Arrays.copyOfRange(strArray, 0,capacity);
	}
	
}
