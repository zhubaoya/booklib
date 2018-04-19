package com.zby.books.contents;

/**
 * 
 * 这是执行删除的mapper常量池
 * 
 * @author 祝宝亚
 * @date 2018年1月22日
 * 
 */
public class StatementDeleted {

	private static String prefix = "com.zby.books.configuration.delete_mapper.";

	public static String DELETE_USER = prefix + "delete_user";
	
	public static String DELETE_USER_ADDRESS_BY_ID = prefix + "delete_user_address_by_id";
	
	public static String DELETE_USER_ADDRESS_BY_UID = prefix + "delete_user_address_by_uid";
	
	public static String DELETE_ACCOUNT = prefix + "delete_account";
	
	public static String DELETE_BOOK = prefix + "delete_book";
	
	public static String DELETE_ISBN_by_ISBN = prefix + "delete_isbn_by_isbn";
	
	public static String DELETE_ISBN_BY_BOOKCODE = prefix + "delete_isbn_by_bookcode";
	
	public static String DELETE_COMMENTS_BY_ID = prefix + "delete_comments_by_id";
	
	public static String DELETE_COMMENTS_BY_UID = prefix + "delete_comments_by_uid";
	
}
