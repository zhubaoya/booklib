package com.zby.test.javabeanoperation;

import org.junit.Ignore;
import org.junit.Test;

import com.zby.books.contents.Status;
import com.zby.books.model.po.User;
import com.zby.books.model.service.UserService;
import com.zby.books.utils.AutoRegisteredId;
import com.zby.books.utils.MyDateTime;

public class TestUserService {

	private User user;
	private UserService service=new UserService();
	
	@Ignore
	public void testInsertUser(){
		 user=new User(new AutoRegisteredId().getRegisteredId(), "安若曦", "123456", "13245623456", "arx123@136.com", Status.one, "headimg/head_arx.jpg");
		System.out.println(service.intserUser(user));
	}
	
	@Ignore
	public void testUpdateUser(){
		user =new User("bL_e6614362fc7843adbbe3bc7", null, null, null, new MyDateTime().getDate(), null, null, null);
		service.updateUser(user);
	}
	
	@Ignore
	public void testUpdatePass(){
		System.out.println(service.updateUserPass("cxr123456", "陈希"));
	}
	
	@Test
	public void testDeleteUser(){
		System.out.println(new UserService().deleteUser("bL_a930ff30c00e40fdb8b698a"));
	}
	
}
