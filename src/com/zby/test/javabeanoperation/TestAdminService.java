package com.zby.test.javabeanoperation;

import org.junit.Test;

import com.zby.books.model.po.Admin;
import com.zby.books.model.service.AdminService;

public class TestAdminService {

	@Test
	public void testinsertAdmin(){
		Admin admin=new Admin("祝宝亚", "ch123456", null);
		
		System.out.println(new AdminService().insertAdmin(admin));
	}
}
