package com.zby.test.javabeanoperation;

import java.util.List;

import org.junit.Test;

import com.zby.books.contents.Status;
import com.zby.books.model.po.Account;
import com.zby.books.model.service.AccountService;
import com.zby.books.utils.MyDateTime;

public class TestAccount {
	
	private Account account;
	
	@Test
	public void testInsertAccount(){
		account=new Account("bL_e6614362fc7843adbbe3bc7", 18, new MyDateTime().getDate(),Status.one ,20);
		System.out.println(new AccountService().insertAccount(account));
	}
	
	@Test
	public void testQuery(){
		account=new Account("bL_a930ff30c00e40fdb8b698a", null);
		List<Account> list=new AccountService().queryAccount(account);
		for(Account acc:list){
			System.out.println(acc.getUid()+"\t"+acc.getMoney());
		}
	}
	
	@Test
	public void testdelete(){
		System.out.println(new AccountService().deleteAccount("bL_e6614362fc7843adbbe3bc7"));
	}
}
