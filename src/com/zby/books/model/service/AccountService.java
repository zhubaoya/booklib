package com.zby.books.model.service;

import java.util.List;

import com.zby.books.contents.StatementDeleted;
import com.zby.books.contents.StatementInserted;
import com.zby.books.contents.StatementSelected;
import com.zby.books.model.dao.BaseDaoImple;
import com.zby.books.model.po.Account;

/**
 * 
 * 操作账户表的服务类，即对表account操作
 * 
 * @author 祝宝亚
 * @date 2018年1月26日
 * 
 */
public class AccountService extends BaseDaoImple<Account> {

	private String insertedAccout = StatementInserted.INSERT_ACCOUNT;

	private String queryAccount = StatementSelected.SELECT_ACCOUNT;

	private String deleteAccount = StatementDeleted.DELETE_ACCOUNT;

	private String queryAccountTotalMoney = StatementSelected.SELECT_ACCOUNT_TOTALMONEY;

	/**
	 * 
	 * 这是将数据添加到account表中，可用于充值、借书时定金的支出、书损坏的赔偿操作
	 * 
	 * @author 祝宝亚
	 * @time 下午8:29:08
	 * @param account
	 * @return 1表示充值成功，反之充值失败
	 */
	public int insertAccount(Account account) {
		return this.insert(insertedAccout, account);
	}

	/**
	 * 根据uid查找该账号信息
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月2日 下午3:16:26
	 * @param account
	 * @return
	 */
	public List<Account> queryAccount(Account account) {
		return this.queryObjects(queryAccount, account);
	}

	/**
	 * 删除数据
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月20日 下午6:24:42
	 * @param uid
	 * @return
	 */
	public int deleteAccount(String uid) {
		return this.delete(deleteAccount, uid);
	}

	/**
	 * 查询总金额
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月20日 下午6:26:50
	 * @param uid
	 * @return
	 */
	public Float queryAccountTotalMoney(String uid) {
		Float money = (Float) this.queryOneData(queryAccountTotalMoney, uid);
		return (float) (money == null ? 0.00 : money);
	}
}
