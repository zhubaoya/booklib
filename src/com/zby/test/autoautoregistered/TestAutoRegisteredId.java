package com.zby.test.autoautoregistered;

import org.junit.Test;

import com.zby.books.utils.AutoRegisteredId;

public class TestAutoRegisteredId {

	@Test
	public void testRegisterId() {
		System.out.print(new AutoRegisteredId().getRegisteredId().length());
	}

	@Test
	public void testTime() {
		long beginTime = System.currentTimeMillis();
		System.out.println(new AutoRegisteredId().getRegisteredId());
		long endTime = System.currentTimeMillis();
		System.out.println(endTime - beginTime);
	}
}
