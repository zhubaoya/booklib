package com.zby.test.javabeanoperation;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;

import com.zby.books.model.po.BookCounty;
import com.zby.books.model.service.BookCountyService;

/**
 * 测试BookCounty类
 * 
 * @author 祝宝亚
 * @date   2018年1月28日
 *
 */
public class TestBookCounty {

	private BookCounty bookCounty;
	@Ignore
	public void testInsertBookcounty(){
		bookCounty=new BookCounty(null, 1);
		new BookCountyService().insertBookCounty(bookCounty);
	}
	
	@Test
	public void testBookCounty(){
		bookCounty =new BookCounty(null, 1);
		List<BookCounty> list=new BookCountyService().queryBookCounty(bookCounty);
		for(BookCounty bookCoun:list){
			System.out.println(bookCoun.getName()+"\t"+bookCoun.getCid());
		}
	
	}
}
