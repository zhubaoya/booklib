package com.zby.test.cryption;

import org.junit.Ignore;
import org.junit.Test;

import com.zby.books.utils.cryption.Descryption;
import com.zby.books.utils.cryption.Encryption;

public class Cryption {

	@Test
	public void testEncryption() {
		System.out.println(Encryption.encrypt("ZW1KNU1USXpORFUy"));
	}

	@Test
	public void testDecryption(){
		System.out.println(Descryption.descrypt("TVRJek5EVTI="));
	}
}
