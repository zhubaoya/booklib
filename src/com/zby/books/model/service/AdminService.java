package com.zby.books.model.service;

import com.zby.books.contents.StatementInserted;
import com.zby.books.contents.StatementSelected;
import com.zby.books.model.dao.BaseDaoImple;
import com.zby.books.model.po.Admin;
import com.zby.books.utils.cryption.Descryption;
import com.zby.books.utils.cryption.Encryption;

/**
 * 
 * 这是管理员服务类，即对表admin操作
 * 
 * @author 祝宝亚
 * @date   2018年1月26日
 *
 */
public class AdminService extends BaseDaoImple<Admin> {

	private String insertedAdmin=StatementInserted.INSERT_ADMIN;
	
	private String selectAdmin=StatementSelected.SELECT_ADMIN;
	/**
	 * 
	 * 这是将数据插入到admin表中，可用于管理员注册
	 * 
	 * @author 祝宝亚
	 * @time   下午11:49:08 
	 * @param admin
	 * @return
	 */
	public int insertAdmin(Admin admin){
		
		admin.setApass(Encryption.encrypt(admin.getApass()));
		
		return this.insert(insertedAdmin, admin);
	}
	
	/**
	 * 查询数据
	 * 
	 * @author 祝宝亚
	 * @time   2018年2月28日 下午2:29:06 
	 * @param admin
	 * @return
	 */
	public Admin queryAdmin(Admin admin){
		return this.queryOneObject(selectAdmin, admin);
	}
	
}
