package com.zby.books.utils.reflect;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 这是用以实现反射的接口
 * 
 * @author 祝宝亚
 * @date 2018年1月21日
 * 
 */
public abstract class Reflect {

	/**
	 * 
	 * 获取反射方法中的参数类型
	 * 
	 * @author 祝宝亚
	 * @time   上午12:13:44 
	 * @param clazz
	 * @return
	 */
	protected Class<?>[] getParameterTypes(Class... clazz) {

		return clazz;
	}

	/**
	 * 执行反射的方法，不需要任何返回值
	 * 
	 * @author 祝宝亚
	 * @time 下午11:57:02
	 * @param object
	 * @param methodParam
	 * @param request
	 * @param response
	 */
	public abstract void excuteReflect(Object object, String methodParam,
			HttpServletRequest request, HttpServletResponse response);

}
