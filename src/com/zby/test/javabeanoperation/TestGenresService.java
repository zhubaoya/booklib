package com.zby.test.javabeanoperation;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;

import com.zby.books.model.po.Genres;
import com.zby.books.model.service.GenresService;

public class TestGenresService {

	@Ignore
	public void testInsertGenres(){
		Genres genres=new Genres("未来",9);
		new GenresService().insertGenres(genres);
	}
	
	@Test
	public void testquerygenres() {
		Genres genres=new Genres(null,null, 5);
	
		System.out.print(new GenresService().queryGenres(genres));
		/*List<Genres> gens=new GenresService().queryGenress(genres);
		for(Genres genr:gens){
			System.out.println(genr.getGname());
		}*/
	}
}
