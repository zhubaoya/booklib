package com.zby.test.testspace;

import org.junit.Test;

import com.zby.books.utils.SpaceFilter;

public class TestSpace {

	@Test
	public void test(){
		long beginTime = System.currentTimeMillis();
		String strs1[]={"祝 宝  亚","123  34","jack","ro  se"};
		
		String[] strs=SpaceFilter.filterSpace("祝 宝 亚","123  34","jack","ro  se");
		for(String str:strs){
			System.out.print(str+"\t");
		}
		System.out.println();
		long endTime = System.currentTimeMillis();
		System.out.println(endTime - beginTime);
	}
}
