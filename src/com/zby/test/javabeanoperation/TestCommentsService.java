package com.zby.test.javabeanoperation;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;

import com.zby.books.model.po.Comment;
import com.zby.books.model.service.CommentsService;
import com.zby.books.utils.MyDateTime;

/**
 * 测试Comments类
 * 
 * @author 祝宝亚
 * @date 2018年1月28日
 * 
 */
public class TestCommentsService {

	@Test
	public void testInsertComments() {
		Comment comments = new Comment("bL_70186b39688e4249933d95e",
				"9787300240121", "这本书写的忒好了", new MyDateTime().getDate(),"格物进化");
		new CommentsService().insertComments(comments);
	}
	
	@Test
	public void testQuerComments(){
		Comment comment=new Comment(null, "9787300240121");
		List<Comment> list=new CommentsService().queryComments(comment);
		for(Comment comment2:list){
			System.out.println(comment2.getComment()+"\t"+comment2.getIsbn()+"\t"+comment2.getId());
		}
	}
	
	@Test
	public void testdelete(){
		//System.out.println(new CommentsService().deleteCommentsById(5));
		//System.out.println(new CommentsService().deleteCommentsByUid("bL_a930ff30c00e40fdb8b698a"));
	}
}
