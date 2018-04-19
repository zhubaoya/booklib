package com.zby.test.javabeanoperation;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;

import com.zby.books.model.po.Book;
import com.zby.books.model.service.BookService;

public class TestBookService {

	@Ignore
	public void testInsertBook(){
		Book book=new Book("9787300240121", "王吉鹏", 17, "格局进化", (float)43.5,100002,"2017-04-01", 2,"bookimgs/17_34.jpg", null, 5);
		
		System.out.println(new BookService().insertBook(book));
	}
	
	@Ignore
	public void testUpdateBook(){
		Book book=new Book();
		
		book.setBisbn("9787300240120");
		book.setBstatus(2);
		book.setAuthorName("zhubaoya");
		book.setBprice((float)15.0);
		book.setEarnest((float)5.00);
		book.setBabstract("通过一个个古老的物像，描述大漠荒荒，黄河文明的盛衰，历史的深邃苍凉；以柔丽凄迷的小桥流水为背景，形神俱佳地表现了清新婉约的江南文化和世态人情；通过文化人格、文化良知的描述和回忆，展示了中国文人艰难的心路历程以及文化的走向。");
		
		System.out.println(new BookService().updateBook(book));
	}
	
	@Test
	public void testselectBook(){
		/*Book book=new Book(null, "9787806646380", null, null, null,null);
		Book bo=new BookService().queryBook(book);
		//List<Book> books=new BookService().queryBooks(book);
		System.out.println(book);*/
		
		Book book=new Book(null, null, 1, null, null,null,"borrowedtime");
		List<Book> books=new BookService().queryBookOrder(book);
		for(Book bo:books){
			System.out.println(bo.getAuthorName()+bo.getPublication()+bo.getBorrowedTime());
		}
	}
	
	@Ignore
	public void testDelete(){
		System.out.println(new BookService().deleteBook("9787806646380"));
	}
	
}
