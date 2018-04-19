package com.zby.books.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.zby.books.contents.StatementDeleted;
import com.zby.books.contents.StatementInserted;
import com.zby.books.contents.StatementSelected;
import com.zby.books.model.dao.BaseDaoImple;
import com.zby.books.model.po.UserAddress;

/**
 * 这是用户地址的服务类，即对表useraddress操作
 * 
 * @author 祝宝亚
 * @date 2018年1月26日
 * 
 */
public class UserAddressService extends BaseDaoImple<UserAddress> {

	private String InsertedUserAddress = StatementInserted.INSERT_USER_ADDRESS;

	private String selectUserAddress = StatementSelected.SELECT_USER_ADDRESS;

	private String DeleteUserAddressById = StatementDeleted.DELETE_USER_ADDRESS_BY_ID;

	private String DeleteUserAddressByUid=StatementDeleted.DELETE_USER_ADDRESS_BY_UID;
	/**
	 * 将数据添加到用户地址表中
	 * 
	 * @author 祝宝亚
	 * @time 2018年1月28日 下午10:39:53
	 * @param address
	 * @return
	 */
	public int insertUserAddress(UserAddress address) {
		return this.insert(InsertedUserAddress, address);
	}

	/**
	 * 查询语句
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月3日 下午1:43:01
	 * @param uid
	 * @return
	 */
	public List<UserAddress> queryUserAddress(String uid) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("uid", uid);
		return this.queryObjects(selectUserAddress, map);
	}

	/**
	 * 通过id删除用户信息
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月3日 下午10:04:50
	 * @param id
	 * @param uid
	 * @return
	 */
	public int deleteUserAddressById(Integer id){
		return this.delete(DeleteUserAddressById, id);
	}
	
	/**
	 * 通过uid删除用户信息
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月3日 下午10:04:50
	 * @param id
	 * @param uid
	 * @return
	 */
	public int deleteUserAddressByUid(String uid){
		return this.delete(DeleteUserAddressByUid, uid);
	}
}
