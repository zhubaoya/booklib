package com.zby.test.javabeanoperation;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;

import com.zby.books.model.po.Tag;
import com.zby.books.model.service.TagService;

public class TestTagService {

	@Ignore
	public void testInsertTag(){
		System.out.println(new TagService().insertTag(new Tag("技术")));
	}
	
	@Test
	public void testQueryTag(){
	/*	List<Tag> list=new TagService().queryTags();
		for(Tag tag:list){
			System.out.println(tag.getTid()+"\t"+tag.getTname()+"\t"+tag.getClass());
		}*/
		Tag tag=new TagService().queryTag(1);
		System.out.print(tag.getTname());
	}
}
