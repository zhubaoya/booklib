package com.zby.books.model.service;

import java.util.List;

import com.zby.books.contents.StatementDeleted;
import com.zby.books.contents.StatementInserted;
import com.zby.books.contents.StatementSelected;
import com.zby.books.model.dao.BaseDaoImple;
import com.zby.books.model.po.Comment;

/**
 * 这是评论的服务类，即对表comments操作
 * 
 * @author 祝宝亚
 * @date 2018年1月26日
 * 
 */
public class CommentsService extends BaseDaoImple<Comment> {

	private String inertedComments = StatementInserted.INSERT_COMMENTS;

	private String selectComments = StatementSelected.SELECT_COMMENT;

	private String deleteCommentsByid = StatementDeleted.DELETE_COMMENTS_BY_ID;

	private String deleteCommentsByUid = StatementDeleted.DELETE_COMMENTS_BY_UID;

	/**
	 * 将数据添加到用户评论区中
	 * 
	 * @author 祝宝亚
	 * @time 2018年1月28日 下午3:53:32
	 * @param comments
	 * @return
	 */
	public int insertComments(Comment comment) {
		return this.insert(inertedComments, comment);
	}

	/**
	 * 查询所有的评论
	 * 
	 * @author 祝宝亚
	 * @time 2018年3月2日 下午4:27:49
	 * @param comment
	 * @return
	 */
	public List<Comment> queryComments(Comment comment) {
		return this.queryObjects(selectComments, comment);
	}

	/**
	 * 通过id删除某个评论表
	 * 
	 * @author 祝宝亚
	 * @time   2018年3月3日 下午11:16:23 
	 * @param id
	 * @return
	 */
	public int deleteCommentsById(Integer id) {
		return this.delete(deleteCommentsByid, id);
	}
	
	/**
	 * 通过uid删除某个人的评论表
	 * 
	 * @author 祝宝亚
	 * @time   2018年3月3日 下午11:22:35 
	 * @param uid
	 * @return
	 */
	public int deleteCommentsByUid(String uid){
		return this.delete(deleteCommentsByUid, uid);
	}
}
