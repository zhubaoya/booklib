package com.zby.books.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 自定义我的自己的dateTime类
 * 
 * @author 祝宝亚
 * @date 2018年1月26日
 * 
 */
public class MyDateTime {

	private Date date;

	public MyDateTime(Date date) {
		this.date = date;
	}

	public MyDateTime() {
		this.date = new Date(System.currentTimeMillis());
	}

	public Date getDate() {
		return date;
	}

	/**
	 * 
	 * @author 祝宝亚
	 * @time 下午9:24:36
	 * @param formate
	 * @return
	 */
	private String getDateString(String formate) {
		return new SimpleDateFormat(formate).format(date);
	}

	/**
	 * 创建当前时间的对象，并转化为String对象
	 * 
	 * @author 祝宝亚
	 * @time 下午8:53:26
	 * @return
	 */
	public String createDateToString(int situation) {

		String formateString = null;

		switch (situation) {
		case 1:
			formateString = getDateString("yyyy-MM-dd HH:mm:ss");
			break;
		case 2:
			formateString = getDateString("yyyy-MM-dd HH:mm");
			break;
		case 3:
			formateString = getDateString("yyyy年MM月dd日");
			break;
		case 4:
			formateString = getDateString("yyyy年MM月");
			break;
		default:
			break;
		}
		return formateString;
	}
	
	/**
	 * 将date类型的数据转化为String类型的数据
	 * 
	 * @author 祝宝亚
	 * @time   2018年3月4日 上午12:32:13 
	 * @param date
	 * @return
	 */
	public String dateToString(Date date,int situation){
		return new SimpleDateFormat(createDateToString(situation)).format(date);
	}
}
