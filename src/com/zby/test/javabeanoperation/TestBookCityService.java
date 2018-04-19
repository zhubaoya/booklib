package com.zby.test.javabeanoperation;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;

import com.zby.books.model.po.BookCity;
import com.zby.books.model.service.BookCityService;

public class TestBookCityService {

	private BookCity bookCity;
	
	@Ignore
	public void testInsertBookCity(){
		bookCity=new BookCity("海淀区",3);
		new BookCityService().insertBookCity(bookCity);
	}
	
	@Test
	public void testBookCity(){
		BookCity bookCity=new BookCity("海淀区", 3);
		List<BookCity> list=new BookCityService().queryBookCity(bookCity);
		for(BookCity city:list){
			System.out.println(city.getCname()+"\t"+city.getCid()+"\t"+city.getPid());
		}
	}
}
