package com.zby.test.javabeanoperation;

import org.junit.Test;

import com.zby.books.model.po.Press;
import com.zby.books.model.service.PressService;

public class TestPressService {

	@Test
	public void testInsertPress(){
		Press press=new Press("中国人民大学出版社", "北京市海淀区中关村大街31号", 100080,"010-62514760", "010-62515351", "http://www.crup.com.cn", "京ICP备10054422号");
		System.out.println(new PressService().insertPress(press));
	}
}
