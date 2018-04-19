package com.zby.test.javabeanoperation;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;

import com.zby.books.model.po.BookProvince;
import com.zby.books.model.service.BookProvinceService;

public class TestBookProvince {

	@Ignore
	public void testInsertBookProvince() {
		BookProvince bookProvince = new BookProvince("北京");
		new BookProvinceService().insertBookProvince(bookProvince);
	}

	@Test
	public void testBookProvince() {
		List<BookProvince> list = new BookProvinceService()
				.queryBookProvince(2,null);
		for (BookProvince bookProvince : list) {
			System.out.println(bookProvince.getPname()+"\t"+bookProvince.getPid());
		}
	}
}
