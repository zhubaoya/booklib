package com.zby.books.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.zby.books.contents.StatementInserted;
import com.zby.books.contents.StatementSelected;
import com.zby.books.contents.StatementUpdated;
import com.zby.books.model.dao.BaseDaoImple;
import com.zby.books.model.po.ContactAdmin;

/**
 * 这是联系管理员的服务类，即对象表contactadmin操作
 * 
 * @author 祝宝亚
 * @date 2018年1月26日
 * 
 */
public class ContactAdminService extends BaseDaoImple<ContactAdmin> {

	private String insertedContactAdmin = StatementInserted.INSERT_CONTACT_ADMIN;

	private String updateContactAdmin = StatementUpdated.UPDATE_CONTACT_ADMIN;

	private String selectcontactAdmin = StatementSelected.SELECT_CONTACT_ADMIN;

	/**
	 * 这是将用户联系后台管理员信息添加到表contactadmin中
	 * 
	 * @author 祝宝亚
	 * @time 2018年1月28日 下午4:04:13
	 * @param admin
	 * @return
	 */
	public int insertContactAdmin(ContactAdmin admin) {
		return this.insert(insertedContactAdmin, admin);
	}

	/**
	 * 更新联系后台管理员的信息
	 * 
	 * @author 祝宝亚
	 * @time 2018年2月3日 下午9:51:20
	 * @param admin
	 * @return
	 */
	public int updateContactAdmin(ContactAdmin admin) {
		return this.update(updateContactAdmin, admin);
	}

	/**
	 * 查询
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月2日 下午4:43:30
	 * @param status
	 * @return
	 */
	public List<ContactAdmin> queryContactAdmins(ContactAdmin admin) {
		return this.queryObjects(selectcontactAdmin, admin);
	}
	
	/**
	 * 查询一个对象
	 * 
	 * @author 祝宝亚
	 * @time   2018年4月1日 下午6:01:14 
	 * @param admin
	 * @return
	 */
	public ContactAdmin queryContactAdmin(ContactAdmin admin){
		return this.queryOneObject(selectcontactAdmin, admin);
	}
}
