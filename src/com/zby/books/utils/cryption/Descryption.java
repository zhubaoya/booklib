package com.zby.books.utils.cryption;

import java.io.UnsupportedEncodingException;

import org.apache.commons.codec.binary.Base64;

/**
 * 
 * 数据解密类
 * 
 * @author 祝宝亚
 * @date   2018年1月21日
 *
 */
public class Descryption {

	public static String descrypt(String encodeStr) {
		try {
			return new String(new Base64().decode(encodeStr.getBytes()),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return null;
		}
	}

}
