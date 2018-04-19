package com.zby.test.javabeanoperation;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;

import com.zby.books.contents.Status;
import com.zby.books.model.po.ISBN;
import com.zby.books.model.service.ISBNService;

/**
 * 测试isbn信息类
 * 
 * @author 祝宝亚
 * @date   2018年1月28日
 *
 */
public class TestISBNService {

	@Test
	public void testInsertISBN(){

		System.out.println(new ISBNService(1,1).insertBetchISBN("北京市海淀区成府路", "9787300240120"));
	
	}
	
	@Ignore
	public void testUpdateISBN(){
		
		ISBN isbn=new ISBN(null, "9787300240121_0003", Status.two, null);
		
		System.out.println(new ISBNService().updateISBN(isbn));
	}
	
	@Test
	public void testqueryIsBN(){
		ISBN isbn=new ISBN(null, null,"9787300240120" , null, null);
		
		List<ISBN> list=new ISBNService().queryISBN(isbn);
		System.out.print(list.size());
		/*for(ISBN is:list){
			System.out.println(is);
			
		}*/
		
		//System.out.println(new ISBNService().queryMaxBookcode("9787300240121"));
	}
	
	@Ignore
	public void testDelete(){
		//System.out.println(new ISBNService().deleteISBNByISBN("9787300240121"));
		System.out.println(new ISBNService().deleteISBNByBookCode("9787300240121_0001"));
	}
	
}
