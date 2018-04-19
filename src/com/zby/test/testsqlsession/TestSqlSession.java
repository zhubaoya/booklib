package com.zby.test.testsqlsession;

import org.junit.Test;

import com.zby.books.configuration.MySqlSessionBuilder;

public class TestSqlSession {

	@Test
	public void testSession(){
		System.out.println(MySqlSessionBuilder.createSqlSession());
	}
}
