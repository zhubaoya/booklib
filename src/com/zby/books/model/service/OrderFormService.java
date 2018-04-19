package com.zby.books.model.service;

import java.util.List;

import com.zby.books.contents.StatementInserted;
import com.zby.books.contents.StatementSelected;
import com.zby.books.contents.StatementUpdated;
import com.zby.books.model.dao.BaseDaoImple;
import com.zby.books.model.po.OrderForm;

/**
 * 这是订单表的服务类，即对orderform操作
 * 
 * @author 祝宝亚
 * @date 2018年1月26日
 * 
 */
public class OrderFormService extends BaseDaoImple<OrderForm> {

	private String insertedOrderForm = StatementInserted.INSERT_ORDER_FORM;

	private String selectOrderForm = StatementSelected.SELECT_ORDERFORM;

	private String selectBackendOrderForm=StatementSelected.SELECT_BACK_ORDERFORM;
	
	private String updateOrderForm=StatementUpdated.UPDATE_ORDERFORM;
	
	/**
	 * 将数据添加到订单表中
	 * 
	 * @author 祝宝亚
	 * @time 2018年1月28日 下午9:48:01
	 * @param form
	 * @return
	 */
	public int insertedOrderForm(OrderForm form) {
		return this.insert(insertedOrderForm, form);
	}

	/**
	 * 查询语句
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月3日 下午1:26:07
	 * @param form
	 * @return
	 */
	public List<OrderForm> queryOrderForm(OrderForm form) {
		return this.queryObjects(selectOrderForm, form);
	}
	
	/**
	 * 查询后台订单
	 * 
	 * @author 祝宝亚
	 * @time   2018年4月1日 下午11:03:14 
	 * @param form
	 * @return
	 */
	public List<OrderForm> queryBackEndOrderFroms(OrderForm form){
		return this.queryObjects(selectBackendOrderForm, form);
	}
	
	/**
	 * 更新订单数据
	 * 
	 * @author 祝宝亚
	 * @time   2018年4月2日 上午12:27:45 
	 * @param form
	 * @return
	 */
	public int updateOrderForm(OrderForm form){
		return this.update(updateOrderForm, form);
	}
}
