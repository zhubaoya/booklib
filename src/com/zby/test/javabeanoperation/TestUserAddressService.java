package com.zby.test.javabeanoperation;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;

import com.zby.books.model.po.UserAddress;
import com.zby.books.model.service.UserAddressService;

/**
 * 测试地址服务类
 * 
 * @author 祝宝亚
 * @date   2018年1月28日
 *
 */
public class TestUserAddressService {

	@Ignore
	public void testInsertUserAddress(){
		UserAddress address=new UserAddress("北京市长安区长安街88号", "bL_a930ff30c00e40fdb8b698a", "祝宝亚", "13621664265");
		new UserAddressService().insertUserAddress(address);
	}
	
	@Ignore
	public void testQueryUserAddress(){
		List<UserAddress> list=new UserAddressService().queryUserAddress("bL_a930ff30c00e40fdb8b698a");
		for(UserAddress address:list){
			System.out.println(address.getUsername()+"\t"+address.getUid());
		}
	}
	
	@Test
	public void testDeleteUserAddress(){
		//System.out.println(new UserAddressService().deleteUserAddressById(100001));
		System.out.println(new UserAddressService().deleteUserAddressByUid("bL_a930ff30c00e40fdb8b698a"));
	}
	
}
