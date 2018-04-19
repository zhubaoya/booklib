package com.zby.books.model.service;

import java.util.HashMap;
import java.util.Map;

import com.zby.books.contents.StatementDeleted;
import com.zby.books.contents.StatementInserted;
import com.zby.books.contents.StatementSelected;
import com.zby.books.contents.StatementUpdated;
import com.zby.books.contents.Status;
import com.zby.books.model.dao.BaseDaoImple;
import com.zby.books.model.po.User;
import com.zby.books.utils.MyDateTime;
import com.zby.books.utils.cryption.Encryption;

/**
 * 这是用户服务类，即对表user操作
 * 
 * @author 祝宝亚
 * @date 2018年1月26日
 * 
 */
public class UserService extends BaseDaoImple<User> {

	private Map<String, String> map;

	private String insertedUser = StatementInserted.INSERT_USER;

	private String updateUserPassword = StatementUpdated.UPDATE_USER_PASSWORD;

	private String updateUser = StatementUpdated.UPDATE_USER;

	private String selectUser = StatementSelected.SELECT_USER;

	private String deleteUser = StatementDeleted.DELETE_USER;

	/**
	 * 将数据添加到用户表中，可用于注册
	 * 
	 * @author 祝宝亚
	 * @time 下午9:37:14
	 * @param user
	 * @return
	 */
	public int intserUser(User user) {
		user.setNewpass(Encryption.encrypt(user.getNewpass()));
		return this.insert(insertedUser, user);
	}

	/**
	 * 更新用户信息
	 * 
	 * @author 祝宝亚
	 * @time 2018年2月3日 下午3:02:40
	 * @param user
	 * @return
	 */
	public int updateUser(User user) {
		return this.update(updateUser, user);
	}

	/**
	 * 更新用户名的密码
	 * 
	 * @author 祝宝亚
	 * @time 2018年2月3日 下午3:07:58
	 * @param newPass
	 *            新密码
	 * @param uname
	 *            用户名
	 * @return
	 */
	public int updateUserPass(String newPass, String uname) {
		map = new HashMap<String, String>();
		map.put("newpass", Encryption.encrypt(newPass));
		map.put("uname", uname);
		return this.update(updateUserPassword, map);
	}

	/**
	 * 查询用户
	 * 
	 * @author 祝宝亚
	 * @time 2018年2月28日 下午11:37:37
	 * @param user
	 * @return
	 */
	public User queryUser(User user) {
		return this.queryOneObject(selectUser, user);
	}

	/**
	 * 删除用户
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月3日 下午9:40:29
	 * @param uid
	 * @return
	 */
	public int deleteUser(String uid) {
		return this.delete(deleteUser, uid);
	}
}
