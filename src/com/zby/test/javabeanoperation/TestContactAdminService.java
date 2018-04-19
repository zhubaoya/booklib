package com.zby.test.javabeanoperation;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;

import com.zby.books.contents.Status;
import com.zby.books.model.po.ContactAdmin;
import com.zby.books.model.service.ContactAdminService;

/**
 * 测试ContactAdmin类
 * 
 * @author 祝宝亚
 * @date   2018年1月28日
 *
 */
public class TestContactAdminService {

	@Ignore
	public void testInsertContactAdmin(){
		ContactAdmin admin=new ContactAdmin("祝宝亚","15956807484", "我定的书怎么还没到呢？","北京大学出版社");
		new ContactAdminService().insertContactAdmin(admin);
	}
	
	@Ignore
	public void testUpdateContact(){
		ContactAdmin admin=new ContactAdmin(1, Status.two);
		new ContactAdminService().updateContactAdmin(admin);
	}
	
	@Test
	public void testContactAdmin(){
		/*List<ContactAdmin> list=new ContactAdminService().queryContactAdmin(Status.one);
		for(ContactAdmin admin:list){
			System.out.println(admin);
		}*/
	}
}
