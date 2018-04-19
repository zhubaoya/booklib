package com.zby.books.contents;

/**
 * 
 * 这是执行查询语句的mapper常量池
 * 
 * @author 祝宝亚
 * @date 2018年1月22日
 * 
 */
public class StatementSelected {

	private static String prefix = "com.zby.books.configuration.select_mapper.";

	public static String SELECT_PRESS = prefix + "select_press";

	public static String SELECT_ADMIN = prefix + "select_admin";

	public static String SELECT_USER = prefix + "select_user";

	public static String SELECT_BOOK = prefix + "select_book";

	public static String SELECT_BOOK_BY_PRESSID = prefix
			+ "select_book_byBisbn";

	public static String SELECT_ISBN = prefix + "select_isbn";

	public static String SELECT_MAX_BOOKCODE = prefix + "select_maxBookcode";

	public static String SELECT_ORDERFORM = prefix + "select_orderform";

	public static String SELECT_USER_ADDRESS = prefix + "select_userAddress";

	public static String SELECT_COMMENT = prefix + "select_comment";

	public static String SELECT_CONTACT_ADMIN = prefix + "select_contact_admin";

	public static String SELECT_TAG = prefix + "select_tag";

	public static String SELECT_GENRES = prefix + "select_genres";

	public static String SELECT_BOOK_PROVINCE = prefix + "select_bookprovince";

	public static String SELECT_BOOK_CITY = prefix + "select_bookcity";

	public static String SELECT_BOOK_COUNTY = prefix + "select_bookcounty";

	public static String SELECT_ACCOUNT = prefix + "select_account";

	public static String SELECT_ACCOUNT_TOTALMONEY = prefix
			+ "select_totalMoneyAccount";

	public static String SELECT_BOOK_ORDER = prefix + "select_book_order";

	public static String SELECT_BACK_ORDERFORM = prefix
			+ "select_back_orderform";
}
