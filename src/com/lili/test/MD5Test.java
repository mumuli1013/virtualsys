package com.lili.test;

import com.lili.util.MD5Util;

/**
 * @author lili
 *2019��1��5��
 * 
 */
public class MD5Test {

	public static void main(String[] args) {
		String str = "zhangsan";
		System.out.println(MD5Util.getMd5(str));
	}

}
