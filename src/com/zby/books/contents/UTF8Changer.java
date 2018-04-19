package com.zby.books.contents;

import java.io.UnsupportedEncodingException;

/**
 * 将前台传来的数据以utf-8的形式转换出去
 * 
 * @author 祝宝亚
 * @date 2018年2月28日
 * 
 */
public class UTF8Changer {

	public static String changeIntoUTF8(String param) {
		try {
			return new String(param.getBytes("ISO-8859-1"), "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return null;
		}
	}
}
