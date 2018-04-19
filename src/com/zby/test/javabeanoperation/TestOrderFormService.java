package com.zby.test.javabeanoperation;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;

import com.zby.books.model.po.OrderForm;
import com.zby.books.model.service.OrderFormService;
import com.zby.books.utils.MyDateTime;

/**
 * 测试订单服务类
 * 
 * @author 祝宝亚
 * @date 2018年1月28日
 * 
 */
public class TestOrderFormService {

	@Ignore
	public void testInsertedOrderform() {
		OrderForm form = new OrderForm("bL_a930ff30c00e40fdb8b698a",
				"9787806646380", new MyDateTime().getDate(),
				"9787300240121_0002", "13621664265", "安徽省阜阳市颍上县古城镇", "祝宝亚","水浒传",null,null);
		System.out.println(new OrderFormService().insertedOrderForm(form));
	}
	
	@Test
	public void testqueryOrdeForm(){
		OrderForm form=new OrderForm(null, "bL_a930ff30c00e40fdb8b698a", null, null);
		List<OrderForm> list=new OrderFormService().queryOrderForm(form);
		for(OrderForm fo:list){
			System.out.println(fo.getUserphone()+"\t"+fo.getBookIsbn());
		}
		
	}
}
