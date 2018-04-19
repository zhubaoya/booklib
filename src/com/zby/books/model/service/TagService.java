package com.zby.books.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.zby.books.contents.StatementInserted;
import com.zby.books.contents.StatementSelected;
import com.zby.books.model.dao.BaseDaoImple;
import com.zby.books.model.po.Tag;

/**
 * 这是图书标签表的服务类，即对表tag操作
 * 
 * @author 祝宝亚
 * @date 2018年1月26日
 * 
 */
public class TagService extends BaseDaoImple<Tag> {

	private String insertedTag = StatementInserted.INSERT_TAG;

	private String selectTag = StatementSelected.SELECT_TAG;

	/**
	 * 添加图书标签
	 * 
	 * @author 祝宝亚
	 * @time 2018年1月28日 下午9:57:45
	 * @param tag
	 * @return
	 */
	public int insertTag(Tag tag) {
		return this.insert(insertedTag, tag);
	}

	/**
	 * 查询标签
	 * 
	 * @author 祝宝亚
	 * @time   2018年3月3日 下午1:36:39 
	 * @return
	 */
	public List<Tag> queryTags() {
		return this.queryObjects(selectTag, null);
	}
	
	/**
	 * 查询tag
	 * @author 祝宝亚
	 * @time   2018年3月9日 下午5:46:17 
	 * @param tid
	 * @return
	 */
	public Tag queryTag(Integer tid){
		Map<String, Integer> map=new HashMap<String, Integer>();
		map.put("tid", tid);
		return this.queryOneObject(selectTag, map);
	}
	
}
