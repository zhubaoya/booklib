package com.zby.books.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.zby.books.contents.StatementInserted;
import com.zby.books.contents.StatementSelected;
import com.zby.books.model.dao.BaseDaoImple;
import com.zby.books.model.po.Press;

/**
 * 
 * 这是出版社的服务类，即对表press操作
 * 
 * @author 祝宝亚
 * @date 2018年1月26日
 * 
 */
public class PressService extends BaseDaoImple<Press> {

	private String insertedPress = StatementInserted.INSERT_PRESS;
	
	private String selectPress=StatementSelected.SELECT_PRESS;

	/**
	 * 这是添加数据到press表中，即添加出版社信息
	 * 
	 * @author 祝宝亚
	 * @time 下午10:26:30
	 * @param press
	 * @return
	 */
	public int insertPress(Press press) {
		return this.insert(insertedPress, press);
	}
	
	/**
	 * 查找出版社信息
	 * 
	 * @author 祝宝亚
	 * @time   2018年2月28日 下午12:13:59 
	 * @return
	 */
	public List<Press> queryPresss(){
		return this.queryObjects(selectPress, null);
	}
	
	/**
	 * 根据pid查询一个Press对象
	 * 
	 * @author 祝宝亚
	 * @time   2018年3月1日 下午2:01:10 
	 * @param pid
	 * @return
	 */
	public Press queryPress(String pid,String pressname){
		Map<String, String> map=new HashMap<String, String>();
		map.put("pid", pid);
		map.put("pname",pressname);
		return this.queryOneObject(selectPress, map);
	}

}
